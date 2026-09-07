# Instructions de travail

## Positionnement

Ce dépôt porte un POC générique de communication libre pour collectifs. Ne jamais le présenter comme un projet officiel de La France insoumise ou d'une autre organisation sans validation explicite et traçable.

## Langue et documentation

- Rédiger les contenus destinés à Jasmin et aux testeurs en français clair.
- Expliquer les termes techniques à leur première occurrence.
- Mettre à jour le README et la documentation concernée avec toute évolution structurante.
- Distinguer clairement ce qui est implémenté, envisagé, testé et validé.

## Sécurité

- Ne jamais committer de secret, jeton, mot de passe, clé privée, sauvegarde réelle ou donnée personnelle.
- Utiliser des fichiers `.env.example` avec valeurs factices.
- Chiffrer les salons sensibles par défaut dans le POC.
- Ne jamais décrire Matrix ou Jitsi comme garantissant une confidentialité absolue.
- Documenter les métadonnées, journaux, sauvegardes, terminaux et ponts comme surfaces de risque.
- Ne pas activer un pont Telegram pour des salons sensibles.
- Prévoir mises à jour, sauvegardes testées, supervision, révocation des comptes et récupération après perte d'appareil.

## Développement et infrastructure

- Favoriser un déploiement reproductible et documenté.
- Épingler les versions de production ; documenter leur mise à jour.
- Séparer configuration versionnée et secrets d'exploitation.
- Ajouter des contrôles automatisés avant tout déploiement.
- Préserver la possibilité de changer d'hébergeur.
- Viser d'abord un pilote de 10 à 30 personnes ; ne pas surdimensionner prématurément.

## Budget GitHub Actions

- Travailler par lots : plusieurs modifications, une validation, un build.
- Ne pas lancer de build lourd après chaque petit commit.
- README, documentation et ce fichier ne doivent pas déclencher de CI.
- Les APK/ZIP/artefacts de distribution doivent être construits manuellement ou sur tag de publication, sauf besoin explicite de packaging continu.
- Garder automatiques les contrôles légers de syntaxe, sécurité et sûreté de déploiement sur les chemins de code concernés.
- Utiliser filtres de chemins, timeouts, caches et `concurrency` avec `cancel-in-progress: true` lorsque l'interruption est sûre.
- Ne pas annuler un déploiement de production en cours sauf s'il est explicitement conçu pour être interrompu sans risque.
- Regrouper les modifications automatisées liées en aussi peu de pushes que possible.
- Préférer un runner self-hosted pour les builds lourds dès qu'il est disponible.

## Validation

Avant de considérer une tâche terminée :

1. vérifier les fichiers modifiés ;
2. exécuter les tests ou validations disponibles ;
3. signaler ce qui n'a pas pu être testé ;
4. consigner les décisions importantes ;
5. ne jamais confondre prototype et service prêt pour un usage sensible.
