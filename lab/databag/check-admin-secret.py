#!/usr/bin/env python3
"""Valide le secret ADMIN avant le démarrage du laboratoire Databag."""
import pathlib
import re
import sys

if len(sys.argv) > 2:
    sys.exit("Usage : python3 check-admin-secret.py [.env]")
path = pathlib.Path(sys.argv[1] if len(sys.argv) == 2 else ".env")
try:
    lines = path.read_text(encoding="utf-8").splitlines()
except OSError:
    sys.exit("Fichier .env introuvable : copier .env.example puis choisir un secret.")
values = [line.split("=", 1)[1].strip() for line in lines if line.startswith("DATABAG_ADMIN_PASSWORD=")]
if len(values) != 1 or not re.fullmatch(r"[A-Za-z0-9_-]{24,}", values[0]):
    sys.exit("Secret ADMIN invalide : une seule valeur de 24+ caractères A-Z, a-z, 0-9, _ ou - est requise.")
if values[0] == "change-me-lab-only":
    sys.exit("Remplacer le secret d'exemple.")
print("Forme du secret ADMIN validée (valeur non affichée).")
