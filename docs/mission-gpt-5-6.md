# Mission pour GPT-5.6 — laboratoire de messagerie Web

## Contexte

Dépôt : [communication-libre](https://github.com/jasmin-abernathy/communication-libre). Objectif : une messagerie libre pour un collectif pilote de 10 à 30 personnes, utilisable par URL sur téléphone et ordinateur, sans installation obligatoire pour les participants. Le logiciel n'est pas choisi. La [recherche GitHub](recherche-briques-messagerie-2026-09-27.md) compare Databag, Tuwunel + Cinny et Mattermost. Les anciens scripts Matrix/Element sont historiques et protégés par `LEGACY_MATRIX_POC=1`. [Verger Associations](https://github.com/jasmin-abernathy/verger-associations) garde ses outils métier et son module Webxdc ; ne pas fusionner les deux dépôts.

## Travail à déléguer

1. **Vérifier les projets amont** : relever pour Databag, Tuwunel, Cinny et Mattermost les versions maintenues, licences, prérequis, méthode d'installation, état des alertes navigateur et limites connues des groupes/appels/chiffrement. Citer les fichiers, tickets et documentations officiels, avec date de consultation. Distinguer fonction annoncée, implémentation observée et fonction vérifiée en laboratoire.
2. **Établir une matrice de comparaison** : nombre de services et dépendances serveur, parcours d'invitation, compatibilité navigateur mobile, notifications écran verrouillé, export et restauration, confidentialité des messages et métadonnées, charge de maintenance. Écrire « à tester » lorsque la preuve manque ; ne pas attribuer de score inventé.
3. **Préparer un laboratoire local reproductible** pour Databag et Tuwunel + Cinny, sur deux configurations isolées avec données factices. Ajouter des exemples de configuration sans secret et une procédure de démarrage, arrêt et suppression des données de test. Épingler les versions après vérification des versions actuelles. Ne pas brancher le laboratoire sur un domaine public ni inscrire de vrais participants.
4. **Décrire un protocole d'essai humain** : invitation, premier message, groupe, reprise après 24 h, perte d'appareil, notification avec navigateur en arrière-plan/fermé et téléphone verrouillé ; Android et iPhone, Wi-Fi et réseau mobile. Prévoir une grille de résultats observables et une procédure de remontée des incidents sans recopier de messages privés.
5. **Proposer une recommandation argumentée** après les essais. Si les tests sur appareils réels sont indisponibles, remettre le laboratoire et marquer la décision « en attente ». La vidéo de groupe par Jitsi reste une option séparée après confirmation du besoin.

## Contraintes de contribution

- Lire `AGENTS.md` et la documentation existante avant modification.
- Garder `README.md`, `docs/architecture.md`, `docs/cadrage-poc.md` et `docs/decisions/0002-messagerie-web.md` cohérents avec le statut provisoire.
- Ne pas déployer en production, activer de pont, promettre du chiffrement de bout en bout universel ou traiter de données personnelles.
- Ne pas déclencher de build coûteux sur GitHub Actions pour une modification documentaire ; grouper les changements et utiliser `[skip ci]` si approprié.
- Ne modifier `verger-associations` que si une demande distincte le requiert.

## Livrables attendus

- Un tableau sourcé des projets et des compromis dans `docs/`.
- Deux configurations de laboratoire documentées et vérifiées par lancement local, ou la cause précise si le lancement est impossible.
- Une fiche de tests sur appareils et un état clair des vérifications effectuées, échouées et non réalisées.
- Un récapitulatif des fichiers modifiés et des commandes de validation, sans annoncer de solution retenue avant preuve.
