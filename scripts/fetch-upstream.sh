#!/usr/bin/env bash

set -Eeuo pipefail
# shellcheck source=lib.sh
# Le chemin est calculé pour permettre l'exécution hors du dépôt.
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

require_command git
load_upstream_lock

mkdir -p "$CACHE_ROOT"

if [[ -e "$UPSTREAM_DIR" && ! -d "$UPSTREAM_DIR/.git" ]]; then
  die "$UPSTREAM_DIR existe mais n'est pas un dépôt Git ; déplacement manuel requis"
fi

if [[ ! -d "$UPSTREAM_DIR/.git" ]]; then
  info "initialisation du playbook Matrix amont"
  git init "$UPSTREAM_DIR"
  git -C "$UPSTREAM_DIR" remote add origin "$MDAD_REPOSITORY"
fi

if ! git -C "$UPSTREAM_DIR" diff --quiet || ! git -C "$UPSTREAM_DIR" diff --cached --quiet; then
  die "le cache amont contient des modifications locales ; elles ne seront pas écrasées"
fi

info "récupération de la révision épinglée $MDAD_COMMIT"
git -C "$UPSTREAM_DIR" fetch --depth=1 origin "$MDAD_COMMIT"
git -C "$UPSTREAM_DIR" checkout --detach "$MDAD_COMMIT"

actual_commit="$(git -C "$UPSTREAM_DIR" rev-parse HEAD)"
[[ "$actual_commit" == "$MDAD_COMMIT" ]] || die "la révision récupérée ne correspond pas au verrou"

info "playbook amont prêt dans $UPSTREAM_DIR"
