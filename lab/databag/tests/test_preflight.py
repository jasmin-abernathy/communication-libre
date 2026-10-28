"""Tests des garde-fous du labo ; aucun Docker réel requis."""
from __future__ import annotations

import importlib.util
import pathlib
import tempfile
import unittest
from unittest.mock import patch

PREFLIGHT = pathlib.Path(__file__).resolve().parents[1] / "preflight.py"
spec = importlib.util.spec_from_file_location("preflight", PREFLIGHT)
assert spec and spec.loader
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

SECRET = "this_is_a_test_secret_not_for_production_29"


class ValidateEnvironmentTest(unittest.TestCase):
    def validate(self, text: str):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / ".env"
            path.write_text(text, encoding="utf-8")
            return module.validate_env(path)

    def test_valid_example_with_changed_secret(self):
        self.assertEqual(
            self.validate(f"DATABAG_BIND=127.0.0.1\nDATABAG_PORT=7000\nDATABAG_ADMIN_PASSWORD={SECRET}\n"),
            ("127.0.0.1", 7000),
        )

    def test_rejects_missing_or_unsafe_password(self):
        for password in ("", "change-me-lab-only", "short", "oops'injection", "a" * 25 + "$"):
            with self.subTest(password=password), self.assertRaises(module.PreflightError):
                self.validate(f"DATABAG_ADMIN_PASSWORD={password}\n")

    def test_rejects_nonlocal_binding(self):
        for bind in ("0.0.0.0", "192.168.0.1", "::", "localhost"):
            with self.subTest(bind=bind), self.assertRaises(module.PreflightError):
                self.validate(f"DATABAG_ADMIN_PASSWORD={SECRET}\nDATABAG_BIND={bind}\n")

    def test_rejects_invalid_ports(self):
        for port in ("0", "80", "65536", "abc", "7000;echo", "-1"):
            with self.subTest(port=port), self.assertRaises(module.PreflightError):
                self.validate(f"DATABAG_ADMIN_PASSWORD={SECRET}\nDATABAG_PORT={port}\n")

    def test_rejects_duplicate_variables(self):
        with self.assertRaises(module.PreflightError):
            self.validate(f"DATABAG_ADMIN_PASSWORD={SECRET}\nDATABAG_ADMIN_PASSWORD={SECRET}\n")

    def test_rejects_unexpected_variable(self):
        with self.assertRaises(module.PreflightError):
            self.validate(f"DATABAG_ADMIN_PASSWORD={SECRET}\nDATABAG_BAD_KEY=abc\n")

    def test_rejects_missing_file(self):
        with self.assertRaises(module.PreflightError):
            module.validate_env(pathlib.Path("/nonexistent/communication-libre/.env"))

    def test_compose_is_not_run_if_docker_absent(self):
        with patch.object(module.shutil, "which", return_value=None):
            with self.assertRaises(module.PreflightError):
                module.check_compose(pathlib.Path("/tmp/.env"), pathlib.Path("/tmp"))

    def test_compose_only_validates_configuration(self):
        with patch.object(module.shutil, "which", return_value="/usr/bin/docker"):
            with patch.object(module.subprocess, "run") as run:
                run.return_value.returncode = 0
                module.check_compose(pathlib.Path("/tmp/.env"), pathlib.Path("/tmp"))
                args = run.call_args.args[0]
                self.assertEqual(args[:2], ["docker", "compose"])
                self.assertEqual(args[-2:], ["config", "--quiet"])
                self.assertNotIn("up", args)


if __name__ == "__main__":
    unittest.main()
