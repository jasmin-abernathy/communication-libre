# Architecture cible du pilote

## Parcours participant

1. La personne ouvre l'URL du collectif sur téléphone ou ordinateur.
2. Elle accepte une invitation et crée un seul compte Mattermost.
3. Elle rejoint les canaux d'annonces et de discussion dans le navigateur.
4. Elle teste les appels audio ; la vidéo de groupe, si nécessaire, s'ouvre par un lien Jitsi distinct dans le navigateur.

L'application native est une option à évaluer après le premier essai, notamment si les notifications du navigateur ne suffisent pas.

## Composants visés

| Élément | Rôle | État |
|---|---|---|
| Mattermost Team Edition | Messagerie Web, comptes, canaux, fichiers, audio et partage d'écran | Retenu, non déployé |
| PostgreSQL | Base de données Mattermost | À installer avec le serveur |
| Proxy HTTPS | TLS et accès public à une URL unique | À choisir et configurer |
| Sauvegardes hors serveur | Restaurer la base, les fichiers et la configuration | À mettre en place et tester |
| Jitsi | Vidéo de groupe par lien Web | Option à décider après les essais |
| Matrix/Element, Coturn et playbook Ansible associé | Ancienne piste technique | Conservés hors du parcours actif |

Le premier déploiement doit éviter un service vidéo, un pont et un fournisseur d'identité supplémentaires. Le serveur nécessite des ressources et un accès système adaptés : un hébergement PHP mutualisé ne suffit pas.

## Sécurité et limites

Mattermost protège les échanges en transit avec TLS, mais sa messagerie standard n'est pas un salon chiffré de bout en bout. Le service, la base, les sauvegardes et les administrateurs appartiennent à la frontière de confiance du collectif. Ne pas utiliser ce pilote pour des échanges dont la confidentialité exige un chiffrement de bout en bout. Définir les droits, la rétention, la révocation et la restauration avant de faire entrer des données réelles.

Un lien Jitsi n'implique pas une connexion commune ni une synchronisation des membres. Évaluer l'accès des invités, la modération, le réseau et les limites de confidentialité séparément.

## Frontière avec Verger Associations

[Verger Associations](https://github.com/jasmin-abernathy/verger-associations) conserve les outils métier et l'archive officielle. Son module Webxdc sous Delta Chat ne s'exécute pas dans Mattermost. L'échange envisagé est le relevé validé exporté en Markdown ou JSON versionné, sans synchronisation automatique ni nouveau compte imposé par ce dépôt.
