# Recherche GitHub — briques libres pour Communication libre

Date : 2026-09-27. Cette recherche prépare un laboratoire ; elle ne valide ni un déploiement ni les promesses de sécurité des projets amont.

## Besoin

Une invitation et une URL suffisent pour entrer dans le groupe depuis un téléphone ou un ordinateur. Il faut éviter de faire installer plusieurs applications. Le nombre de composants **côté serveur** compte aussi, mais la fiabilité des notifications et la confidentialité priment sur un décompte de conteneurs.

## Trois assemblages plausibles

| Assemblage | Ce qu'il apporte | Briques nécessaires au départ | Vérification décisive |
|---|---|---|---|
| **Databag seul**, puis Jitsi seulement si besoin | Serveur léger, client Web et mobile, groupes, chiffrement des sujets « sealed » | Databag + HTTPS ; Jitsi distinct pour la vidéo de groupe | Inviter, répondre et recevoir des alertes sur Android/iPhone ; stabilité des groupes ; comprendre et activer le chiffrement. |
| **Tuwunel + Cinny**, puis Jitsi si besoin | Serveur Matrix moins lourd que Synapse, client Web mobile, salons chiffrés compatibles Matrix | Tuwunel + fichiers statiques Cinny + HTTPS ; Jitsi distinct si demandé | Récupération des clés, premier message, notifications mobile navigateur, appels et maintenance. |
| **Mattermost Team Edition**, puis Jitsi si besoin | Messagerie Web mature et audio intégré | Mattermost + PostgreSQL + HTTPS | Notifications sans application et acceptation des messages non chiffrés de bout en bout. |

**Autre piste** : Prosody + Converse.js apporte XMPP, interface Web responsive et OMEMO. Elle demanderait une configuration du serveur, de l'archivage, des groupes et des notifications ; elle n'est pas prioritaire tant que les deux premières combinaisons n'ont pas été essayées.

## Ce que montre le code amont

- [Databag](https://github.com/balzack/databag) annonce un serveur capable de fonctionner sur matériel modeste. Son exemple Docker utilise un service applicatif et un volume de données, sans PostgreSQL séparé. Son client Web contient un service worker pour les notifications. Le chiffrement de bout en bout concerne les sujets **scellés** ; sa documentation explique qu'il n'offre pas la confidentialité persistante (*forward secrecy*) de certains protocoles plus avancés. Les appels audio/vidéo nécessitent un relais STUN/TURN selon le réseau, et les **appels de groupe** figurent encore dans le backlog. Des tickets ouverts concernent une panne de groupe et les notifications : ne pas l'utiliser pour des échanges sensibles avant essai et examen de sécurité.
- [Tuwunel](https://github.com/matrix-construct/tuwunel) est un serveur Matrix en Rust destiné à remplacer Synapse dans un déploiement léger. [Cinny](https://github.com/cinnyapp/cinny) est une interface Matrix Web distribuable comme fichiers statiques. Cette combinaison conserve le protocole Matrix, mais ne garantit pas de bonnes notifications dans un navigateur mobile ; Cinny remplace actuellement son SDK Matrix, ce qui augmente le besoin de tester la version choisie.
- [Converse.js](https://github.com/conversejs/converse.js) peut être servi comme application Web autonome et prend en charge XMPP et OMEMO. Il nécessite un serveur XMPP tel que Prosody. Ses notifications documentées sont surtout celles du navigateur de bureau ; vérifier l'usage en arrière-plan sur téléphone.
- Mattermost est une option sérieuse pour un groupe qui accepte la visibilité des messages côté serveur. Son fonctionnement Web ne suffit pas à démontrer la réception d'alertes quand le navigateur est fermé.

## Assemblage proposé pour le laboratoire

1. **Essai A : Databag sans vidéo**. Une instance isolée sans données sensibles, 4 à 6 personnes, invitation, groupe, sujet scellé, notification avec écran verrouillé, reprise après 24 h.
2. **Essai B : Tuwunel + Cinny sans vidéo** avec les mêmes personnes et les mêmes tâches. Observer également la vérification des appareils et la récupération des clés.
3. **Comparer** temps d'entrée, erreurs, messages manqués, confiance comprise par les participants, ressources serveur et temps d'administration.
4. Ajouter Jitsi **uniquement** si le groupe demande une vidéo à plusieurs. Tester l'accès par lien Web sur Android, iPhone et ordinateur, sans annoncer une intégration de comptes.
5. Garder Mattermost comme point de comparaison si A et B échouent sur l'ergonomie, et obtenir l'accord du groupe sur sa limite de confidentialité avant tout pilote.

Aucun pont entre protocoles n'est nécessaire au premier pilote. Un pont imposerait une autre frontière de confiance et rendrait l'expérience plus difficile à expliquer. Aucun de ces logiciels n'exécute directement le module Webxdc de Verger Associations ; les relevés exportés restent leur point de jonction.

## Critère de sortie

Retenir une seule messagerie pour les participants. Si aucun navigateur mobile ne reçoit les alertes essentielles de manière satisfaisante, expliquer qu'une application **facultative** pourrait être nécessaire pour les notifications, et laisser le groupe arbitrer avant de migrer.

## Sources

- [Databag : README et déploiement](https://github.com/balzack/databag)
- [Databag : conception et limites du chiffrement](https://github.com/balzack/databag/blob/main/doc/design_overview.md)
- [Databag : backlog](https://github.com/balzack/databag/blob/main/doc/backlog.md)
- [Databag : tickets ouverts](https://github.com/balzack/databag/issues)
- [Tuwunel](https://github.com/matrix-construct/tuwunel)
- [Cinny](https://github.com/cinnyapp/cinny)
- [Converse.js](https://github.com/conversejs/converse.js)
