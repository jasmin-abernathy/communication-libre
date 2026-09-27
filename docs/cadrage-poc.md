# Cadrage du POC Web

## Hypothèse

Un collectif de 10 à 30 personnes peut rejoindre une messagerie Mattermost auto-hébergée par **une URL et un compte**, sur mobile et ordinateur, sans téléchargement obligatoire. Les appels audio sont testés dans le même espace ; la vidéo de groupe n'est ajoutée que si le besoin est confirmé.

## Phases

1. **Laboratoire sans données réelles** : déploiement reproductible à créer, invitation fermée, sauvegarde/restauration, accès navigateur sur Android, iOS et ordinateur.
2. **Pilote fermé** : annonces, discussions, fichiers, appels audio et partage d'écran avec 10 à 30 volontaires ; mesurer les notifications et les contraintes sur réseau mobile.
3. **Bilan** : facilité d'arrivée, continuité des notifications, disponibilité, accessibilité, coût serveur et temps de maintenance.
4. **Vidéo si nécessaire** : essai séparé de Jitsi par lien Web, avec tests de qualité et de modération ; aucune installation prévue dans la première phase.

## Critères de réussite

- Une personne non technique rejoint son canal avec une URL et une invitation, sans installer d'application.
- Les fonctions essentielles restent utilisables sur mobile et ordinateur ; les limites des navigateurs sont documentées.
- Les notifications sont suffisamment fiables pour le groupe, ou le besoin d'une application native facultative est constaté honnêtement.
- Les appels audio fonctionnent sur deux réseaux distincts.
- Le groupe sait quelles conversations ne doivent pas passer par ce pilote, faute de chiffrement de bout en bout des messages.
- Sauvegarde, restauration, départ d'un membre et coûts d'administration sont mesurés.
- Le parcours clavier, la lisibilité et le zoom sont vérifiés.

## Conditions d'arrêt

Arrêter ou limiter le pilote si la restauration échoue, si les notifications le rendent inutilisable, si l'administration excède les moyens disponibles ou si les participants veulent y traiter des échanges exigeant un chiffrement de bout en bout.

## Hors périmètre initial

Fédération Matrix, serveur Matrix, client mobile obligatoire, pont Telegram, synchronisation Verger Associations, vidéo de groupe installée d'emblée et déploiement national.
