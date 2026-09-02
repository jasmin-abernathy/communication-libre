.PHONY: help fetch init check install reconcile register

help:
	@printf '%s\n' \
	  'make fetch                         Télécharger la révision amont épinglée' \
	  'make init DOMAIN=... IP=... [SSH_USER=deploy]' \
	  'make check                         Vérifier la configuration privée' \
	  'make install                       Installer le POC sur le serveur' \
	  'make reconcile                     Réappliquer toute la configuration' \
	  'make register USER=... [ADMIN=1]   Créer un compte Matrix'

fetch:
	bash scripts/fetch-upstream.sh

init:
	@test -n "$(DOMAIN)" || (echo 'DOMAIN est requis' >&2; exit 2)
	@test -n "$(IP)" || (echo 'IP est requis' >&2; exit 2)
	bash scripts/init-runtime.sh "$(DOMAIN)" "$(IP)" "$(or $(SSH_USER),deploy)"

check:
	bash scripts/deploy.sh check

install:
	bash scripts/deploy.sh install

reconcile:
	bash scripts/deploy.sh reconcile

register:
	@test -n "$(USER)" || (echo 'USER est requis' >&2; exit 2)
	bash scripts/register-user.sh "$(USER)" $(if $(ADMIN),--admin,)
