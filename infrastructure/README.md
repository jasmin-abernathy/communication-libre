# Infrastructure

Le socle est un overlay sécurisé autour de `matrix-docker-ansible-deploy`.

## Organisation

- `../upstream.env` verrouille le dépôt et la révision amont ;
- `../inventory/` contient uniquement des exemples sans secrets ;
- `../runtime/` reçoit l'inventaire réel et reste ignoré par Git ;
- `../.cache/` reçoit le playbook téléchargé ;
- `../scripts/` prépare, vérifie et lance le déploiement.

## Garde-fous

- aucun domaine, IP, utilisateur ou secret réel dans le dépôt ;
- inscriptions publiques désactivées ;
- fédération désactivée pour le premier pilote ;
- Jitsi authentifié avec invités et lobby ;
- Gravatar, IA et intégrations externes non nécessaires désactivés ;
- dépendance amont verrouillée par empreinte Git complète ;
- contrôle automatique des scripts, YAML et secrets manifestes.

Les commandes sont documentées dans `../docs/installation.md`. Aucune installation ne doit viser un service sensible avant test des sauvegardes, de la restauration et de la révocation des comptes.
