#!/usr/bin/env bash

set -Eeuo pipefail
# shellcheck source=lib.sh
# Le chemin est calculé pour permettre l'exécution hors du dépôt.
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

usage() {
  printf 'Usage : bash scripts/register-user.sh IDENTIFIANT [--admin]\n' >&2
  exit 2
}

[[ $# -ge 1 && $# -le 2 ]] || usage
username="$1"
admin_flag="${2:-}"

[[ "$username" =~ ^[a-z0-9._=-]+$ ]] || die "identifiant Matrix invalide"
[[ -z "$admin_flag" || "$admin_flag" == "--admin" ]] || usage

require_command ansible-playbook
require_runtime_inventory
[[ -d "$UPSTREAM_DIR/.git" ]] || die "lancer d'abord bash scripts/fetch-upstream.sh"

read -r -s -p "Mot de passe Matrix : " password
printf '\n'
read -r -s -p "Confirmer le mot de passe : " confirmation
printf '\n'
[[ -n "$password" && "$password" == "$confirmation" ]] || die "les mots de passe ne correspondent pas"

admin="no"
[[ "$admin_flag" == "--admin" ]] && admin="yes"

umask 077
extra_vars_file="$(mktemp)"
trap 'rm -f "$extra_vars_file"' EXIT
printf '%s\n' \
  "username: '$username'" \
  "password: '$password'" \
  "admin: '$admin'" >"$extra_vars_file"
unset password confirmation

export ANSIBLE_CONFIG="$UPSTREAM_DIR/ansible.cfg"
ansible-playbook -i "$INVENTORY_DIR/hosts" "$UPSTREAM_DIR/setup.yml" \
  --extra-vars "@$extra_vars_file" --tags=register-user
