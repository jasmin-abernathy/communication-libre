#!/usr/bin/env bash

set -Eeuo pipefail
# shellcheck source=lib.sh
# shellcheck source=lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

mode="${1:-check}"
case "$mode" in
  check|install|reconcile) ;;
  *) die "mode inconnu : $mode (attendus : check, install ou reconcile)" ;;
esac

require_command ansible-playbook
require_command ansible-galaxy
require_runtime_inventory

bash "$PROJECT_ROOT/scripts/check-config.sh"
bash "$PROJECT_ROOT/scripts/fetch-upstream.sh"

info "récupération des rôles Ansible épinglés par le playbook"
if command -v make >/dev/null 2>&1; then
  make -C "$UPSTREAM_DIR" roles
else
  rm_target="$UPSTREAM_DIR/roles/galaxy"
  [[ "$rm_target" == "$UPSTREAM_DIR/roles/galaxy" ]] || die "chemin de rôles inattendu"
  mkdir -p "$rm_target"
  ansible-galaxy install -r "$UPSTREAM_DIR/requirements.yml" -p "$rm_target" --force
fi

export ANSIBLE_CONFIG="$UPSTREAM_DIR/ansible.cfg"

case "$mode" in
  check)
    info "vérification de la syntaxe Ansible"
    ansible-playbook -i "$INVENTORY_DIR/hosts" "$UPSTREAM_DIR/setup.yml" --syntax-check
    ;;
  install)
    info "installation initiale du POC"
    ansible-playbook -i "$INVENTORY_DIR/hosts" "$UPSTREAM_DIR/setup.yml" \
      --tags=install-all,ensure-matrix-users-created,start
    ;;
  reconcile)
    info "réconciliation complète de la configuration"
    ansible-playbook -i "$INVENTORY_DIR/hosts" "$UPSTREAM_DIR/setup.yml" \
      --tags=setup-all,ensure-matrix-users-created,start
    ;;
esac
