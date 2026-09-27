# Références techniques et réutilisation

Vérifiées le 2026-09-27 pour préparer le laboratoire.

## Alternatives prioritaires

### Databag

- dépôt `balzack/databag` — serveur et clients, Apache-2.0 ;
- `README.md` — installation Docker, Web/mobile, sujets `sealed`, appels et notifications annoncées ;
- [`net/server/entrypoint.sh` au commit épinglé](https://github.com/balzack/databag/blob/45343338582b394f4f5fdb4b7e271ea1dc8dd5fd/net/server/entrypoint.sh) — concatène `ADMIN` dans une instruction SQLite ; contrôler le format du secret du laboratoire avant démarrage et suivre une correction amont avant usage sensible ;
- `app/client/web/src/settings/useSettings.hook.ts` — demande d'autorisation de notification, enregistrement du service worker et souscription Web Push ;
- `doc/design_overview.md` — modèle de chiffrement et limites ;
- `doc/backlog.md` — appels de groupe encore au backlog ;
- issue `#195` — crash de groupe signalé le 2026-08-25 ;
- issue `#181` — diagnostic de notifications/UnifiedPush encore ouvert.

Le laboratoire verrouille le commit `45343338582b394f4f5fdb4b7e271ea1dc8dd5fd` plutôt qu'un tag `latest` mutable.

### Tuwunel

- dépôt `matrix-construct/tuwunel` — serveur Matrix sous Apache-2.0 ;
- release `v1.9.3` publiée le 2026-09-25 ;
- `docs/deploying/docker.md` et `docs/deploying/docker-compose.yml` — images OCI, variables de configuration et délai d'arrêt nécessaire aux migrations ;
- workflow `.github/workflows/publish.yml` — publication des tags de release et des alias `preview`/`latest` ;
- issue `#543` — problème de pushers de `1.8.3`, fermé le 2026-08-19.

### Cinny

- dépôt `cinnyapp/cinny` — client Matrix Web sous AGPL-3.0-only ;
- release `v4.12.7` publiée le 2026-09-15 ;
- `config.json` — homeservers et routage configurables ;
- `src/sw.ts` — service worker actuel ;
- workflow `.github/workflows/prod-deploy.yml` — publication de l'image Docker/GHCR à chaque release ;
- issue `#17` — demande PWA toujours ouverte ;
- issue `#2400` — limites mobiles et proposition de wrapper natif ;
- issue `#2743` — évolution 2026 des appels voix/vidéo.

## Comparateurs et historique

Mattermost est conservé uniquement comme comparateur secondaire. L'ancien socle `matrix-docker-ansible-deploy` + Element + Jitsi + Coturn reste une référence historique protégée par `LEGACY_MATRIX_POC=1` et ne doit pas être confondu avec le laboratoire courant.

## Règle de réutilisation

Les sources tierces ne sont pas copiées dans ce dépôt. Les configurations de laboratoire référencent des versions ou commits amont précis. Toute modification ou redistribution d'un composant amont doit respecter sa propre licence.
