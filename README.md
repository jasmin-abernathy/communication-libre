# Communication libre

POC indépendant de communication pour collectifs : **une adresse Web pour discuter**, sans application à installer pour le pilote. Ce projet n'est l'outil officiel d'aucune organisation.

## Choix en réévaluation : assemblage Web léger

La piste Mattermost est désormais **une hypothèse parmi plusieurs**. Le pilote pourrait utiliser Mattermost, ou un assemblage plus léger de briques libres. La décision dépendra d'essais sur mobile et des garanties de confidentialité nécessaires.

L'hypothèse Mattermost utilisait **Mattermost Team Edition auto-hébergé** pour les messages, fils de discussion, annonces et fichiers. Une personne reçoit un lien d'invitation, crée son compte et utilise son navigateur sur téléphone ou ordinateur. L'application mobile reste facultative ; les notifications mobiles et la navigation doivent être vérifiées en situation réelle.

Les appels audio et le partage d'écran de Mattermost seront testés en premier. La **vidéo de groupe** n'entre pas dans la première installation : si elle est nécessaire, un lien Jitsi ouvert dans le navigateur sera évalué ensuite. Personne n'aura à installer Jitsi pour rejoindre la réunion depuis un navigateur compatible.

**Limite de confidentialité :** la messagerie Mattermost standard ne fournit pas le chiffrement de bout en bout des salons envisagé auparavant avec Matrix. Le serveur et ses administrateurs ont accès aux données nécessaires à son fonctionnement. Une hypothèse Mattermost ne doit donc pas accueillir de conversations exigeant cette protection ; TLS, accès restreints et sauvegardes protégées restent nécessaires. Si le chiffrement de bout en bout devient indispensable, il faudra réexaminer le choix de messagerie.

## État réel

- **Critère produit établi** : accès Web sans installation obligatoire ; messagerie et vidéo de groupe peuvent être deux briques distinctes.
- **Choix de logiciel en cours** : comparer Databag, Tuwunel + Cinny et Mattermost sur un parcours mobile identique. Voir [la recherche GitHub](docs/recherche-briques-messagerie-2026-09-27.md).
- **À construire après les essais** : déploiement de la solution retenue, invitations fermées, sauvegarde/restauration et suivi des notifications sur appareils réels.
- **Aucun service déployé** : domaine, serveur, dimensionnement et protocole de test restent à choisir.
- **Ancien prototype conservé** : le code `Matrix/Element + Jitsi` et ses scripts sont historiques. Ils ne déploient **pas** le nouveau choix. Les commandes `make init/fetch/check/install/reconcile/register` exigent `LEGACY_MATRIX_POC=1` pour éviter un déploiement par erreur. Leurs guides sont archivés comme références de l'ancienne option.

Voir [la décision provisoire](docs/decisions/0002-messagerie-web.md), [l'architecture cible](docs/architecture.md) et [le cadrage du pilote](docs/cadrage-poc.md). Ne pas suivre `docs/installation.md` pour installer Mattermost.

## Frontière avec Verger Associations

Ce dépôt porte la **communication** : accès, messages, salons, appels et exploitation. [Verger Associations](https://github.com/jasmin-abernathy/verger-associations) porte les **outils métier** : réunions, décisions, actions et exports. Son module Webxdc actuel fonctionne dans Delta Chat, **pas** dans les messageries comparées ici. Les pilotes restent indépendants ; un relevé validé exporté en Markdown ou JSON peut être partagé et archivé dans l'un ou l'autre contexte.

## Principes du pilote

- 10 à 30 volontaires, sans données sensibles ;
- logiciel libre et hébergement maîtrisé, sans publicité ni IA imposée ;
- un compte et une URL, application facultative ;
- inscriptions fermées, sauvegarde et restauration testées ;
- observation de la simplicité, des notifications, des coûts et du temps d'administration ;
- aucun pont Telegram ni migration automatique dans la première phase.

Le code du projet est sous la licence indiquée dans [LICENSE](LICENSE). Les logiciels amont gardent leurs propres licences.
