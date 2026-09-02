#!/usr/bin/env bash

set -Eeuo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM_LOCK="$PROJECT_ROOT/upstream.env"
CACHE_ROOT="${MDAD_CACHE_ROOT:-$PROJECT_ROOT/.cache}"
# Used by the executable scripts that source this library.
# shellcheck disable=SC2034
UPSTREAM_DIR="$CACHE_ROOT/matrix-docker-ansible-deploy"
INVENTORY_DIR="${POC_INVENTORY_DIR:-$PROJECT_ROOT/runtime/inventory}"

die() {
  printf 'Erreur : %s\n' "$*" >&2
  exit 1
}

info() {
  printf '→ %s\n' "$*"
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "commande requise absente : $1"
}

load_upstream_lock() {
  [[ -f "$UPSTREAM_LOCK" ]] || die "fichier upstream.env introuvable"

  # shellcheck disable=SC1090
  source "$UPSTREAM_LOCK"

  [[ "${MDAD_REPOSITORY:-}" == "https://github.com/spantaleev/matrix-docker-ansible-deploy.git" ]] || \
    die "dépôt amont inattendu dans upstream.env"
  [[ "${MDAD_COMMIT:-}" =~ ^[0-9a-f]{40}$ ]] || die "empreinte MDAD_COMMIT invalide"
  [[ "${MDAD_MIGRATION_VERSION:-}" =~ ^v[0-9]{4}\.[0-9]{2}\.[0-9]{2}\.0$ ]] || \
    die "version de migration invalide"
}

require_runtime_inventory() {
  [[ -f "$INVENTORY_DIR/hosts" ]] || \
    die "inventaire absent ; lancer d'abord : bash scripts/init-runtime.sh DOMAINE IP"

  local vars_count
  vars_count="$(find "$INVENTORY_DIR/host_vars" -mindepth 2 -maxdepth 2 -name vars.yml -type f 2>/dev/null | wc -l)"
  [[ "$vars_count" -eq 1 ]] || die "un unique fichier vars.yml était attendu dans runtime/inventory"
}
