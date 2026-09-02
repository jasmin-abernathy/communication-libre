# Décision 0001 — Overlay Ansible plutôt que fork ou Compose maison

- Statut : accepté pour le POC
- Date : 2026-09-02

## Contexte

Synapse, Element, PostgreSQL, Jitsi et TURN disposent déjà de projets maintenus. Écrire un assemblage Docker Compose indépendant ferait porter au projet la compatibilité entre toutes ces briques.

## Décision

Le dépôt conserve uniquement :

- une révision amont verrouillée ;
- nos exemples d'inventaire ;
- les choix spécifiques au POC ;
- les scripts de préparation et de contrôle ;
- la documentation d'exploitation.

Le playbook amont est téléchargé dans `.cache/` et n'est pas recopié dans Git.

## Conséquences

- moins de code à maintenir ;
- mises à jour explicites et auditables ;
- déploiement reproductible ;
- dépendance assumée au playbook AGPL et à son organisation ;
- nécessité de lire son changelog avant toute mise à jour ;
- possibilité future de remplacer le socle sans perdre la documentation fonctionnelle du POC.
