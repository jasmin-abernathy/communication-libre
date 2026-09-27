# Communication libre

POC indépendant de communication pour collectifs : **une adresse Web pour discuter**, sans application obligatoire pour le pilote. Ce projet n'est l'outil officiel d'aucune organisation.

## Choix de travail : Databag

**Databag est la seule piste active pour le premier pilote.** Son serveur et son client Web intégrés limitent les services à installer. Le laboratoire [Databag](lab/README.md#essai-a--databag) est prêt à démarrer sur une machine Docker ; aucun lancement ni essai sur appareil réel n'a encore été attesté. Si un défaut bloquant est confirmé, le choix sera réexaminé. Tuwunel + Cinny reste une expérience comparative archivée ; Mattermost n'est pas retenu.

La vidéo de groupe n'est pas un prérequis de la messagerie. Si le besoin est confirmé, elle sera évaluée séparément afin de ne pas alourdir le parcours d'inscription et l'exploitation du premier pilote.

## État réel

- **Critère produit établi** : URL + compte, navigateur mobile et ordinateur, sans téléchargement obligatoire.
- **Laboratoires préparés** : configuration Databag et comparaison Tuwunel + Cinny dans [`lab/`](lab/README.md), avec versions verrouillées et données de test isolées.
- **Essais appareils à faire** : invitations, groupes, chiffrement, récupération, notifications navigateur fermé, Wi-Fi/réseau mobile et restauration. Voir [`docs/test-appareils.md`](docs/test-appareils.md).
- **Orientation décidée, validation en attente** : Databag est choisi pour avancer ; le pilote avec de vraies personnes attend les essais bloquants.
- **Aucun service public déployé** : le laboratoire n'accueille ni vrais participants ni conversations sensibles.
- **Ancien prototype conservé** : le code `Matrix/Element + Jitsi` et ses scripts restent historiques. Les commandes correspondantes exigent `LEGACY_MATRIX_POC=1` pour éviter un déploiement accidentel.

## Points de vigilance déjà identifiés

### Databag

Le Web client contient un mécanisme Web Push avec service worker, mais sa fiabilité sur téléphone verrouillé doit être mesurée. Le chiffrement de bout en bout concerne les sujets **sealed**, pas l'ensemble des échanges. Le script de démarrage amont insère le secret d'administration dans une commande SQL sans paramètres : le laboratoire vérifie sa forme avant de démarrer. Un ticket amont ouvert en août 2026 décrit aussi un crash de groupe lorsque certains membres ne se sont pas ajoutés mutuellement : ce scénario fait partie des tests obligatoires.

### Alternative conservée : Tuwunel + Cinny

Tuwunel est activement maintenu et Cinny reste une interface Web légère. En revanche, le code de Cinny `v4.12.7` ne met pas en place de Web Push : ses notifications navigateur reposent sur `window.Notification` pendant que le client tourne. **Cette combinaison ne fournit donc pas d'alerte Web lorsque le navigateur est réellement fermé** sans changer de client ou accepter un autre canal (application native facultative, e-mail, etc.). La gestion des clés et la récupération après perte de session restent également des critères de sortie.

## Frontière avec Verger Associations

Ce dépôt porte la **communication** : accès, messages, salons, appels éventuels et exploitation. [Verger Associations](https://github.com/jasmin-abernathy/verger-associations) porte les **outils métier** : réunions, décisions, actions et exports. Les dépôts restent séparés. Un relevé validé exporté en Markdown ou JSON peut être échangé sans fusionner les architectures.

## Principes du pilote

- 10 à 30 volontaires maximum après validation du laboratoire ;
- logiciel libre et hébergement maîtrisé, sans publicité ni IA imposée ;
- compte et URL suffisants, application facultative ;
- inscriptions fermées ;
- sauvegarde et restauration testées avant données réelles ;
- confidentialité expliquée fonction par fonction ;
- aucun pont Telegram ni migration automatique dans la première phase.

Voir aussi [`docs/architecture.md`](docs/architecture.md), [`docs/cadrage-poc.md`](docs/cadrage-poc.md) et la [décision 0002](docs/decisions/0002-messagerie-web.md).

Le code propre à ce dépôt est sous la licence indiquée dans [LICENSE](LICENSE). Les logiciels amont gardent leurs propres licences.
