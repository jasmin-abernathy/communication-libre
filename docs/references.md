# Références techniques et réutilisation

## Socle retenu

- [matrix-docker-ansible-deploy](https://github.com/spantaleev/matrix-docker-ansible-deploy) — playbook Ansible/Docker sous AGPL-3.0-or-later ; révision actuellement verrouillée dans `upstream.env`.
- [Démarrage rapide du playbook](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/quick-start.md) — inventaire `hosts`, fichier `vars.yml`, prérequis et commandes.
- [Configuration Jitsi dans le playbook](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/configuring-playbook-jitsi.md).
- [Contrôle de la fédération](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/configuring-playbook-federation.md).
- [Configuration TURN](https://github.com/spantaleev/matrix-docker-ansible-deploy/blob/master/docs/configuring-playbook-turn.md).

## Composants amont

- [Synapse](https://github.com/element-hq/synapse) — serveur Matrix ; son image Docker recommande PostgreSQL pour un usage réel et n'inclut pas TURN.
- [Element Web](https://github.com/element-hq/element-web) — client Web configurable par `config.json`.
- [Element X](https://github.com/element-hq/element-x-android) et [Element X iOS](https://github.com/element-hq/element-x-ios) — clients mobiles.
- [Jitsi Meet Docker](https://github.com/jitsi/docker-jitsi-meet) — déploiement Docker officiel de Jitsi.
- [Rôle Ansible Jitsi](https://github.com/mother-of-all-self-hosting/ansible-role-jitsi) — rôle utilisé par le playbook Matrix, avec authentification, invités, lobby et réglages de sobriété.
- [Coturn](https://github.com/coturn/coturn) — serveur STUN/TURN.
- [mautrix-telegram](https://github.com/mautrix/telegram) — pont de transition éventuel, exclu des salons sensibles.

## Ce qui est adapté dans ce dépôt

Le fichier d'exemple `vars.yml.example` reprend les noms de variables documentés par le playbook Matrix et le rôle Jitsi, puis les adapte au POC : inscriptions et fédération fermées, authentification Jitsi interne, Gravatar désactivé, intégrations externes neutralisées et vidéo limitée.

Les sources tierces ne sont pas recopiées : `scripts/fetch-upstream.sh` récupère la révision verrouillée. Toute redistribution ou modification d'un composant amont doit respecter sa propre licence.
