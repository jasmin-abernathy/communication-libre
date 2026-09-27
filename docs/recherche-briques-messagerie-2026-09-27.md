# Recherche GitHub — briques libres pour Communication libre

Date de vérification : 2026-09-27. Cette note distingue les fonctions annoncées par les projets amont des fonctions qu'il reste à vérifier sur nos appareils.

## Besoin

Une invitation et une URL doivent suffire pour rejoindre le groupe depuis téléphone ou ordinateur. L'application native peut exister, mais ne doit pas être obligatoire par défaut. Le laboratoire privilégie le moins de dépendances serveur possible tout en gardant une confidentialité compréhensible et une exploitation réaliste.

## Pistes prioritaires

| Assemblage | Version/état vérifié | Licence | Points forts à confirmer | Risque principal à tester |
|---|---|---|---|---|
| **Databag** | `main` verrouillé sur `45343338582b394f4f5fdb4b7e271ea1dc8dd5fd`, dernier commit observé le 2026-06-14 | Apache-2.0 | un service principal, Web Push dans le client Web, sujets `sealed` E2EE | bug de groupe ouvert en août 2026, récupération de clé, alertes navigateur fermé |
| **Tuwunel + Cinny** | Tuwunel `v1.9.3` (2026-09-25) + Cinny `v4.12.7` (2026-09-15) | Apache-2.0 + AGPL-3.0-only | pile Matrix plus légère, client Web, salons chiffrés | **pas de Web Push navigateur fermé dans Cinny v4.12.7**, récupération des clés, maturité récente des appels |

### Databag

La documentation amont annonce un serveur léger, une interface Web, des groupes, des appels audio/vidéo et des alertes mobiles. Le code Web actuel demande l'autorisation de notification, enregistre un service worker `push.js` et crée une souscription Push : **le mécanisme existe donc dans le code**, mais son fonctionnement téléphone verrouillé reste à tester.

Le chiffrement de bout en bout concerne les sujets **sealed**. L'interface permet de générer une clé de chiffrement ; cette distinction doit être visible dans le protocole humain. Le backlog amont liste encore les appels de groupe comme fonctionnalité à faire.

Un ticket ouvert le 2026-08-25 décrit un crash lorsque certains membres d'un groupe ne sont pas mutuellement ajoutés comme contacts. Ce scénario est bloquant pour notre usage s'il est reproductible et doit être testé avant toute recommandation.

La dernière release GitHub affichée est `v1.1.1021`, publiée en 2024, alors que le dépôt a encore reçu des commits en 2026. Pour le laboratoire, le choix est donc de **verrouiller un commit source précis** plutôt que d'utiliser `balzack/databag:latest` sans traçabilité.

### Tuwunel

Tuwunel `v1.9.3` a été publié le 2026-09-25. Le projet fournit des images OCI et une configuration Docker Compose officielle ; son workflow de publication crée un tag correspondant à la release, puis les alias `preview` et `latest`. Le laboratoire utilise le tag `v1.9.3` et désactive la fédération.

Un ticket sur les pushers apparu avec `1.8.3` en août 2026 a été fermé après correction. Cela réduit l'incertitude côté homeserver, sans prouver la fiabilité des notifications du navigateur Cinny.

### Cinny

Cinny `v4.12.7` a été publié le 2026-09-15 et son workflow de release publie également une image sur GHCR et Docker Hub. L'application reste d'abord un client Web : une demande PWA est encore ouverte et une proposition de clients mobiles de 2025 décrit explicitement les limites du navigateur mobile, notamment pour les notifications et le stockage sur iOS.

Le code du tag `v4.12.7` permet les notifications système quand le client est actif : il demande la permission via `window.Notification.requestPermission()` puis crée des notifications avec `new window.Notification(...)` pendant la synchronisation Matrix. En revanche, aucune utilisation de `PushManager` ni aucun gestionnaire d'événement `push` n'est présent ; le service worker sert à intercepter les requêtes de médias authentifiés. **Cette version n'implémente donc pas le Web Push nécessaire à une alerte lorsque le navigateur est réellement fermé.** Les appels voix/vidéo ont reçu des évolutions en 2026, donc leur parcours doit être testé séparément.

## Comparateur secondaire : Mattermost

Mattermost reste documenté pour mémoire, mais n'est plus au centre de la décision. Son interface Web est mature, mais la messagerie standard n'apporte pas le chiffrement de bout en bout recherché pour certains usages et son schéma n'est pas retenu comme point de départ. Aucun laboratoire Mattermost n'est ajouté.

## Assemblage retenu pour le laboratoire

1. **Essai A : Databag**, construit depuis le commit source verrouillé, sans vidéo de groupe.
2. **Essai B : Tuwunel `v1.9.3` + Cinny `v4.12.7`**, fédération désactivée.
3. Même fiche d'essai et mêmes données factices pour les deux, en traitant l'absence de Web Push fermé dans Cinny comme une limitation déjà démontrée.
4. Aucun pont entre protocoles.
5. Décision finale uniquement après essais sur appareils réels. Si les notifications écran verrouillé sans application sont indispensables, Tuwunel devra être évalué avec un autre client Web avant de conserver cette piste.

Les configurations sont dans [`../lab/`](../lab/README.md) et la grille commune dans [`test-appareils.md`](test-appareils.md).
