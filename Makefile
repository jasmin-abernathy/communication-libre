.PHONY: help fetch init check install reconcile register legacy-guard

legacy-guard:
	@test "$(LEGACY_MATRIX_POC)" = "1" || (echo "Ancien POC Matrix : commande désactivée. Voir docs/decisions/0002-messagerie-web.md. Pour une reprise volontaire : LEGACY_MATRIX_POC=1." >&2; exit 2)

help:
	@printf '%s\n' \
	  'Ancien POC Matrix : commandes ci-dessous bloquées par défaut (LEGACY_MATRIX_POC=1 pour reprise volontaire)' \
	  'make fetch                         Télécharger la révision amont épinglée' \
	  'make init DOMAIN=... IP=... [SSH_USER=deploy]' \
	  'make check                         Vérifier la configuration privée' \
	  'make install                       Installer le POC sur le serveur' \
	  'make reconcile                     Réappliquer toute la configuration' \
	  'make register USER=... [ADMIN=1]   Créer un compte Matrix'

fetch: legacy-guard
	bash scripts/fetch-upstream.sh

init: legacy-guard
	@test -n "$(DOMAIN)" || (echo 'DOMAIN est requis' >&2; exit 2)
	@test -n "$(IP)" || (echo 'IP est requis' >&2; exit 2)
	bash scripts/init-runtime.sh "$(DOMAIN)" "$(IP)" "$(or $(SSH_USER),deploy)"

check: legacy-guard
	bash scripts/deploy.sh check

install: legacy-guard
	bash scripts/deploy.sh install

reconcile: legacy-guard
	bash scripts/deploy.sh reconcile

register: legacy-guard
	@test -n "$(USER)" || (echo 'USER est requis' >&2; exit 2)
	bash scripts/register-user.sh "$(USER)" $(if $(ADMIN),--admin,)
