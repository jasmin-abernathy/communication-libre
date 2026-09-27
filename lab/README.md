# Laboratoire de messagerie Web

Ce répertoire sert uniquement à comparer des solutions avec des comptes et contenus factices. Il ne constitue pas un déploiement de production et ne doit pas être exposé publiquement tel quel.

## Pistes testées en priorité

| Piste | Version verrouillée | Pourquoi ce choix de version |
|---|---|---|
| Databag | commit `45343338582b394f4f5fdb4b7e271ea1dc8dd5fd` | le dépôt amont a encore reçu des commits en 2026 alors que la dernière release GitHub publiée est ancienne ; le laboratoire verrouille donc un commit précis plutôt qu'un tag ou `latest` mutable |
| Tuwunel | `v1.9.3` | release amont publiée le 2026-09-25 |
| Cinny | `v4.12.7` | release amont publiée le 2026-09-15 |

Databag et Tuwunel sont sous Apache-2.0. Cinny est sous AGPL-3.0-only. Mattermost reste documenté comme ancienne hypothèse de comparaison mais aucun laboratoire Mattermost n'est maintenu ici.

## Ce que la vérification statique confirme

- Le contexte Git distant du laboratoire Databag pointe sur la racine du commit verrouillé, qui contient le `Dockerfile` utilisé par l'amont.
- Databag génère ses clés VAPID Web Push au premier démarrage si elles n'existent pas encore ; le client Web enregistre `push.js` et crée une souscription `PushManager`.
- L'image Cinny copie son build dans `/app` ; monter `cinny-config.json` sur `/app/config.json` correspond donc à son image officielle.
- Cinny `v4.12.7` accepte une URL `http://...` ou `https://...` dans `homeserverList` : son auto-discovery conserve explicitement le schéma lorsqu'il est fourni.
- Tuwunel `v1.9.3` utilise les mêmes variables d'environnement que son exemple Compose officiel. Son CORS autorise toutes les origines par défaut si aucune liste `access_control_allow_origin` n'est configurée.
- L'image Tuwunel fournit un `HEALTHCHECK` basé sur `tuwunel --health-check` ; le laboratoire fait donc attendre Cinny jusqu'à l'état `healthy`.
- Cinny `v4.12.7` ne met pas en place de Web Push : ses notifications système utilisent `window.Notification` pendant que le client est actif et son service worker gère les médias authentifiés, sans abonnement `PushManager` ni gestionnaire d'événement `push`. Une notification navigateur fermé ne doit donc pas être attendue avec ce client Web.

Ces points viennent du code amont aux versions épinglées. Ils ne remplacent pas un démarrage des images ni un essai sur appareil réel.

## Pré-requis

- Docker Engine avec le plugin `docker compose` ;
- `curl` pour les contrôles HTTP de connectivité ;
- accès sortant à GitHub/GHCR pour récupérer les sources ou images ;
- aucun secret réel ni donnée personnelle ;
- pour tester les notifications sur un téléphone, prévoir un HTTPS de laboratoire reconnu par l'appareil. `localhost` suffit seulement au premier contrôle sur la machine de test.

## Essai A — Databag

Préparer et valider la configuration Compose avant de construire :

```sh
cd lab/databag
cp .env.example .env
# Modifier au minimum le mot de passe d'administration dans .env.
docker compose --env-file .env config --quiet
docker compose --env-file .env up -d --build
docker compose --env-file .env ps
docker compose --env-file .env logs --tail=100 databag
curl -fsS http://127.0.0.1:7000/ >/dev/null
```

Le `curl` confirme uniquement que le service HTTP répond. Il ne prouve ni les groupes, ni le chiffrement, ni les notifications.

Ouvrir `http://127.0.0.1:7000`. Créer uniquement des comptes factices depuis le tableau de bord d'administration. Pour l'essai de confidentialité, comparer explicitement un sujet normal et un sujet **sealed** ; ne pas assimiler tout Databag à du chiffrement de bout en bout.

Arrêt sans effacer les données :

```sh
docker compose --env-file .env down
```

Suppression complète des données de laboratoire :

```sh
docker compose --env-file .env down --volumes --remove-orphans
rm -f .env
```

## Essai B — Tuwunel + Cinny

Préparer puis contrôler les deux services :

```sh
cd lab/tuwunel-cinny
cp .env.example .env
# Modifier le jeton d'inscription dans .env.
docker compose --env-file .env config --quiet
docker compose --env-file .env up -d
docker compose --env-file .env ps
docker compose --env-file .env logs --tail=100 homeserver cinny
curl -fsS http://127.0.0.1:8008/_matrix/client/versions
curl -fsS http://127.0.0.1:8080/config.json
```

Le premier `curl` vérifie seulement que l'API Matrix répond ; le second que Cinny sert bien la configuration montée. Aucun des deux n'établit que l'inscription, les salons chiffrés ou la récupération des clés fonctionnent.

Ouvrir `http://127.0.0.1:8080`. Le homeserver local est `http://localhost:8008`, la fédération est désactivée et Cinny est verrouillé sur ce homeserver. Cinny `v4.12.7` prend en charge le stage Matrix de jeton d'inscription : utiliser uniquement le jeton factice de `.env`.

**Attention au `server_name` Tuwunel :** il devient une partie des identifiants Matrix et l'amont précise qu'il ne doit pas être modifié après initialisation sans effacer la base. Si le laboratoire passe de `localhost` à un nom de test pour les essais téléphone, faire ce choix avant le premier démarrage correspondant ou repartir d'un volume vide avec `docker compose down --volumes`.

Arrêt sans effacer les données :

```sh
docker compose --env-file .env down
```

Suppression complète des données de laboratoire :

```sh
docker compose --env-file .env down --volumes --remove-orphans
rm -f .env
```

## HTTPS local pour Android et iPhone

Ne pas publier le laboratoire sur Internet juste pour tester les téléphones. Une voie légère consiste à :

1. garder les conteneurs liés à `127.0.0.1` ;
2. utiliser sur la machine Docker un reverse proxy de test **hors dépôt** qui termine TLS et relaie vers les ports locaux ;
3. générer un certificat de laboratoire avec une autorité locale, par exemple `mkcert`, pour un nom DNS local ou l'adresse IP LAN de la machine ;
4. installer la racine de confiance du laboratoire uniquement sur les appareils de test ;
5. faire pointer Cinny vers l'URL HTTPS réelle du homeserver pendant ce passage.

Sur iPhone/iPad, un certificat racine installé manuellement doit ensuite recevoir la confiance SSL/TLS complète dans les réglages système. Ce choix ajoute une étape aux testeurs mais évite d'ouvrir le laboratoire sur Internet.

Pour le **Web Push iPhone/iPad**, HTTPS ne suffit pas : Apple prend en charge Web Push pour les **web apps ajoutées à l'écran d'accueil**, pas pour un simple onglet Safari. Le protocole doit donc distinguer « navigateur pur » et « ajout à l'écran d'accueil ». Cette étape n'est pas un téléchargement depuis un store, mais elle constitue bien une friction supplémentaire par rapport au critère « une URL suffit ».

Références :
- [Web Push Apple](https://developer.apple.com/documentation/usernotifications/sending-web-push-notifications-in-web-apps-and-browsers)
- [Web Push iOS/iPadOS — WebKit](https://webkit.org/blog/13878/web-push-for-web-apps-on-ios-and-ipados/)
- [Confiance d'un certificat racine sur iOS/iPadOS](https://support.apple.com/fr-fr/102390)
- [mkcert — certificats locaux](https://github.com/FiloSottile/mkcert)

Aucun proxy ni certificat n'est ajouté au dépôt tant que cette procédure n'a pas été exécutée sur la machine et les appareils destinés au test.

## État de validation au 2026-09-27

Les fichiers YAML et JSON de ce laboratoire ont été contrôlés statiquement. L'environnement utilisé pour préparer le dépôt ne fournit ni Docker ni Podman : aucun lancement local de conteneur, aucune restauration et aucun essai mobile n'ont donc été effectués ici.

Les tags `v1.9.3` de Tuwunel et `v4.12.7` de Cinny correspondent aux releases consultées le 2026-09-27 ; leurs workflows amont publient des images de conteneur lors des releases. Databag est construit directement depuis un commit amont verrouillé pour éviter la dépendance à un tag `latest`.

Suivre ensuite [`docs/test-appareils.md`](../docs/test-appareils.md). La décision finale reste **en attente des essais réels**.
