# Cadrage du POC

## Hypothèse

Un environnement Matrix/Element + Jitsi dédié peut couvrir une partie importante des usages Telegram/Zoom d'un collectif tout en renforçant la maîtrise technique, la réversibilité et la confidentialité des salons sensibles.

## Population test

- 10 à 30 volontaires ;
- profils techniques et non techniques ;
- Android, iOS et ordinateur ;
- connexions fibre, Wi-Fi, 4G/5G et connexions dégradées ;
- participation volontaire et données minimales.

## Phases

### Phase 0 — intérêt et contraintes

- publier la proposition ;
- identifier un interlocuteur et des volontaires ;
- relever les contraintes internes ;
- obtenir une validation explicite avant d'utiliser tout nom, logo ou fichier de membres.

### Phase 1 — laboratoire technique

- déployer sans données réelles ;
- tester Matrix, Element Web, Element X, Jitsi et TURN ;
- documenter mises à jour, sauvegardes, restauration et supervision ;
- réaliser un premier test de charge.

### Phase 2 — pilote fermé

- inscriptions sur invitation ;
- comptes de test ;
- salons d'annonces, discussion et E2EE ;
- deux ou trois réunions Jitsi ;
- questionnaire court après chaque étape.

### Phase 3 — bilan

- expérience utilisateur ;
- qualité et disponibilité ;
- incidents et risques ;
- coûts d'hébergement ;
- temps d'administration ;
- conditions nécessaires à une éventuelle suite.

## Critères de réussite proposés

| Domaine | Mesure |
|---|---|
| Onboarding | Un non-technicien rejoint le bon espace et active la récupération de compte sans aide prolongée |
| Mobile | Notifications reçues de manière fiable sur Android et iOS |
| Messagerie | Messages, fichiers, réponses, mentions et annonces utilisables au quotidien |
| Chiffrement | Appareils vérifiés et procédure de récupération comprise |
| Visio | Tests reproductibles à 10, 20 puis 30 participants |
| Réseau | Connexions directes et relayées via TURN testées |
| Accessibilité | Parcours clavier, lecteur d'écran et lisibilité évalués |
| Exploitation | Mise à jour, sauvegarde, restauration et révocation documentées |
| Sobriété | Ressources et volume de données observés, vidéo non imposée |
| Réversibilité | Export des configurations et changement d'hébergeur documentés |

## Conditions d'arrêt

Le pilote doit être interrompu ou limité si :

- un incident de sécurité n'est pas maîtrisé ;
- les sauvegardes/restaurations ne sont pas fiables ;
- les notifications mobiles rendent la messagerie inutilisable ;
- l'administration dépasse les moyens disponibles ;
- les participants ne reçoivent pas une information claire sur les limites du système.

## Hors périmètre initial

- déploiement à l'échelle nationale ;
- client mobile entièrement personnalisé ;
- authentification reliée à une base militante ;
- fédération ouverte ;
- migration automatique de salons sensibles ;
- promesse de remplacement complet de Telegram ou Zoom.
