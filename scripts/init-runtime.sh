#!/usr/bin/env bash

set -Eeuo pipefail
# shellcheck source=lib.sh
# shellcheck source=lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

usage() {
  printf 'Usage : bash scripts/init-runtime.sh DOMAINE IP_PUBLIQUE [UTILISATEUR_SSH]\n' >&2
  exit 2
}

[[ $# -ge 2 && $# -le 3 ]] || usage

domain="${1,,}"
public_ip="$2"
ssh_user="${3:-deploy}"

[[ "$domain" =~ ^([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z]{2,63}$ ]] || die "nom de domaine invalide"
[[ "$domain" != *.invalid ]] || die "remplacer le domaine d'exemple par un domaine réel"
[[ "$ssh_user" =~ ^[a-z_][a-z0-9_-]*$ ]] || die "utilisateur SSH invalide"

IFS='.' read -r ip1 ip2 ip3 ip4 extra <<<"$public_ip"
[[ -z "${extra:-}" && -n "${ip4:-}" ]] || die "une adresse IPv4 publique est requise pour le POC"
for octet in "$ip1" "$ip2" "$ip3" "$ip4"; do
  [[ "$octet" =~ ^[0-9]{1,3}$ && "$octet" -le 255 ]] || die "adresse IPv4 invalide"
done

require_command openssl
require_command sed
load_upstream_lock

[[ ! -e "$INVENTORY_DIR" ]] || die "$INVENTORY_DIR existe déjà ; aucune donnée ne sera écrasée"

host_fqdn="matrix.$domain"
vars_dir="$INVENTORY_DIR/host_vars/$host_fqdn"
hosts_template="$PROJECT_ROOT/inventory/hosts.example"
vars_template="$PROJECT_ROOT/inventory/host_vars/matrix.example.invalid/vars.yml.example"

umask 077
mkdir -p "$vars_dir"
cp "$hosts_template" "$INVENTORY_DIR/hosts"
cp "$vars_template" "$vars_dir/vars.yml"

matrix_secret="$(openssl rand -hex 48)"
postgres_password="$(openssl rand -hex 32)"
jitsi_password="$(openssl rand -hex 32)"

sed -i \
  -e "s/example\.invalid/$domain/g" \
  -e "s/192\.0\.2\.10/$public_ip/g" \
  -e "s/ansible_ssh_user=deploy/ansible_ssh_user=$ssh_user/" \
  "$INVENTORY_DIR/hosts" "$vars_dir/vars.yml"

sed -i \
  -e "s/CHANGE_ME_MATRIX_SECRET/$matrix_secret/" \
  -e "s/CHANGE_ME_POSTGRES_PASSWORD/$postgres_password/" \
  -e "s/CHANGE_ME_JITSI_PASSWORD/$jitsi_password/" \
  -e "s/matrix_playbook_migration_validated_version: .*/matrix_playbook_migration_validated_version: $MDAD_MIGRATION_VERSION/" \
  "$vars_dir/vars.yml"

chmod 700 "$PROJECT_ROOT/runtime" "$INVENTORY_DIR" "$INVENTORY_DIR/host_vars" "$vars_dir"
chmod 600 "$INVENTORY_DIR/hosts" "$vars_dir/vars.yml"

unset matrix_secret postgres_password jitsi_password

info "inventaire privé créé dans $INVENTORY_DIR"
info "le compte Jitsi de démarrage est pilot-admin ; son mot de passe est dans $vars_dir/vars.yml"
info "vérifier les DNS et le pare-feu avant tout déploiement"
