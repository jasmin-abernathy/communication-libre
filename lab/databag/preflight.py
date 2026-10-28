#!/usr/bin/env python3
"""Contrôles locaux et non destructifs avant le labo Databag.

Ne démarre aucun conteneur, ne crée aucun compte et ne vérifie pas les
fonctionnalités de messagerie. Toute sortie évite d'imprimer les secrets.
"""
from __future__ import annotations

import argparse
import pathlib
import re
import shutil
import subprocess
import sys

SECRET_PATTERN = re.compile(r"[A-Za-z0-9_-]{24,}\Z")


class PreflightError(ValueError):
    """Une configuration du laboratoire n'est pas sûre/valide."""


def validate_env(path: pathlib.Path) -> tuple[str, int]:
    """Valide les entrées qui conditionnent l'exposition et l'admin."""
    try:
        data = path.read_text(encoding="utf-8")
    except OSError as exc:
        raise PreflightError("Fichier .env absent ou illisible : copier .env.example.") from exc

    values: dict[str, str] = {}
    allowed = {"DATABAG_ADMIN_PASSWORD", "DATABAG_BIND", "DATABAG_PORT"}
    for number, raw in enumerate(data.splitlines(), 1):
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if "=" not in line:
            raise PreflightError(f"Ligne {number} : variable au format CLE=VALEUR attendue.")
        key, value = line.split("=", 1)
        key = key.strip()
        if key in values:
            raise PreflightError(f"Variable {key} répétée dans .env.")
        if key not in allowed:
            raise PreflightError(f"Variable {key} inattendue pour ce laboratoire.")
        values[key] = value.strip()

    password = values.get("DATABAG_ADMIN_PASSWORD", "")
    if not SECRET_PATTERN.fullmatch(password) or password == "change-me-lab-only":
        raise PreflightError("Secret ADMIN invalide : 24+ caractères [A-Za-z0-9_-] requis.")

    bind = values.get("DATABAG_BIND", "127.0.0.1")
    if bind != "127.0.0.1":
        raise PreflightError("Labo strictement local : DATABAG_BIND doit valoir 127.0.0.1.")

    raw_port = values.get("DATABAG_PORT", "7000")
    if not re.fullmatch(r"[0-9]{1,5}", raw_port):
        raise PreflightError("DATABAG_PORT doit être un port TCP numérique.")
    port = int(raw_port)
    if not 1024 <= port <= 65535:
        raise PreflightError("DATABAG_PORT doit être compris entre 1024 et 65535.")
    return bind, port


def check_compose(env_file: pathlib.Path, lab_directory: pathlib.Path) -> None:
    """Vérifie la syntaxe Compose avec Docker, sans démarrer les services."""
    if not shutil.which("docker"):
        raise PreflightError("Docker non disponible : contrôle Compose non exécuté.")
    try:
        process = subprocess.run(
            ["docker", "compose", "--env-file", str(env_file), "config", "--quiet"],
            cwd=lab_directory,
            text=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,  # Ne jamais risquer d'imprimer un secret.
            timeout=45,
            check=False,
        )
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise PreflightError("Docker Compose inaccessible ou hors délai.") from exc
    if process.returncode != 0:
        raise PreflightError("Configuration Docker Compose non validée (détails masqués).")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--env", default=".env", help="Chemin de .env (par défaut : labo Databag)")
    args = parser.parse_args(argv)
    lab_dir = pathlib.Path(__file__).resolve().parent
    env_file = pathlib.Path(args.env).expanduser()
    if not env_file.is_absolute():
        env_file = lab_dir / env_file
    env_file = env_file.resolve()
    try:
        bind, port = validate_env(env_file)
        check_compose(env_file, lab_dir)
    except PreflightError as exc:
        print(f"ÉCHEC pré-vol : {exc}", file=sys.stderr)
        return 1
    print(f"Pré-vol OK : configuration locale de Databag sur http://{bind}:{port}/.")
    print("Aucun service lancé. Ni chiffrement, ni groupes, ni notifications validés.")
    print("Étape suivante : docker compose --env-file .env up -d --build")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
