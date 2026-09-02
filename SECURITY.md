# Politique de sécurité

Ce dépôt prépare une infrastructure de communication potentiellement destinée à des échanges sensibles. Le code et la configuration présents ici ne doivent jamais être considérés comme sûrs par défaut sans audit, durcissement et tests adaptés au contexte réel.

## Signaler un problème

Tant que le dépôt est privé, ouvrir une issue privée ou contacter directement le propriétaire du dépôt. Ne pas publier de preuve d'exploitation contenant des données réelles.

## Données interdites dans Git

Ne jamais committer :

- jetons GitHub ou API ;
- mots de passe ;
- clés privées ou secrets TURN/Matrix/Jitsi ;
- fichiers `.env` réels ;
- journaux comportant des identifiants, adresses IP ou messages ;
- sauvegardes et bases de données ;
- listes de membres ou coordonnées personnelles.

## Exigences avant un pilote réel

- mises à jour de sécurité automatisées ou procédure documentée ;
- pare-feu et accès administrateur restreint ;
- sauvegardes chiffrées et restauration testée ;
- rotation et révocation des secrets ;
- politique de conservation des journaux ;
- procédure de départ d'un membre ;
- récupération sécurisée des clés et appareils ;
- supervision et alertes ;
- test de charge Jitsi ;
- information claire des participants sur les limites du dispositif.

## Limites à rappeler

Le chiffrement de bout en bout protège le contenu dans les usages compatibles, mais pas toutes les métadonnées. Un terminal compromis, une mauvaise gestion des clés, un pont externe ou une sauvegarde mal protégée peuvent annuler une partie importante des garanties.
