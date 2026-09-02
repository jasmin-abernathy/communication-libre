#!/usr/bin/env bash

set -Eeuo pipefail
# shellcheck source=lib.sh
# Le chemin est calculé pour permettre l'exécution hors du dépôt.
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

examples_only=false
if [[ "${1:-}" == "--examples-only" ]]; then
  examples_only=true
elif [[ $# -gt 0 ]]; then
  die "option inconnue : $1"
fi

load_upstream_lock

info "validation de la syntaxe des scripts shell"
for script in "$PROJECT_ROOT"/scripts/*.sh; do
  bash -n "$script"
done

if command -v shellcheck >/dev/null 2>&1; then
  info "analyse ShellCheck"
  shellcheck "$PROJECT_ROOT"/scripts/*.sh
else
  info "ShellCheck absent : analyse approfondie ignorée"
fi

if command -v yamllint >/dev/null 2>&1; then
  info "validation YAML"
  yamllint -c "$PROJECT_ROOT/.yamllint" \
    "$PROJECT_ROOT/inventory/host_vars/matrix.example.invalid/vars.yml.example" \
    "$PROJECT_ROOT/.github/workflows/validate.yml"
else
  info "yamllint absent : validation YAML ignorée"
fi

if git -C "$PROJECT_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  info "recherche de secrets manifestes dans les fichiers suivis"
  if git -C "$PROJECT_ROOT" grep -nE \
    '(github_pat_[A-Za-z0-9_]{20,}|ghp_[A-Za-z0-9]{20,}|-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----)' \
    -- ':!scripts/check-config.sh'; then
    die "un secret potentiel a été détecté"
  fi
fi

if [[ "$examples_only" == true ]]; then
  info "exemples validés"
  exit 0
fi

require_runtime_inventory

vars_file="$(find "$INVENTORY_DIR/host_vars" -mindepth 2 -maxdepth 2 -name vars.yml -type f)"

if grep -R -nE 'CHANGE_ME_(MATRIX|POSTGRES|JITSI)|example\.invalid|192\.0\.2\.10' "$INVENTORY_DIR"; then
  die "l'inventaire privé contient encore une valeur d'exemple"
fi

if git -C "$PROJECT_ROOT" check-ignore -q "$INVENTORY_DIR/hosts" && \
  git -C "$PROJECT_ROOT" check-ignore -q "$vars_file"; then
  info "inventaire privé correctement ignoré par Git"
else
  die "l'inventaire privé n'est pas protégé par .gitignore"
fi

info "configuration locale validée"
