# Laboratoire de messagerie Web

Ce répertoire sert uniquement à comparer des solutions avec des comptes et contenus factices. Il ne constitue pas un déploiement de production et ne doit pas être exposé publiquement tel quel.

## Pistes testées en priorité

| Piste | Version verrouillée | Pourquoi ce choix de version |
|---|---|---|
| Databag | commit `45343338582b394f4f5fdb4b7e271ea1dc8dd5fd` | le dépôt amont a encore reçu des commits en 2026 alors que la dernière release GitHub publiée est ancienne ; le laboratoire verrouille donc un commit précis plutôt qu'un tag ou `latest` mutable |
| Tuwunel | `v1.9.3` | release amont publiée le 2026-09-25 |
| Cinny | `v4.12.7` | release amont publiée le 2026-09-15 |

Databag et Tuwunel sont sous Apache-2.0. Cinny est sous AGPL-3.0-only. Mattermost reste documenté comme ancienne hypothèse de comparaison mais aucun laboratoire Mattermost n'est maintenu ici.

## Pré-requis

- Docker Engine avec le plugin `docker compose` ;
- accès sortant à GitHub/GHCR pour récupérer les sources ou images ;
- aucun secret réel ni donnée personnelle ;
- pour tester les notifications sur un téléphone, prévoir ensuite un nom d'hôte HTTPS de laboratoire avec certificat reconnu par l'appareil. `localhost` suffit seulement au premier contrôle sur la machine de test.

## Essai A — Databag

```sh
cd lab/databag
cp .env.example .env
# Modifier au minimum le mot de passe d'administration dans .env.
docker compose --env-file .env up --build
```

Ouvrir `http://127.0.0.1:7000`. Créer uniquement des comptes factices depuis le tableau de bord d'administration. Pour l'essai de confidentialité, comparer explicitement un sujet normal et un sujet **sealed** ; ne pas assimiler tout Databag à du chiffrement de bout en bout.

Arrêt sans effacer les données :

```sh
docker compose --env-file .env down
```

Suppression complète des données de laboratoire :

```sh
docker compose --env-file .env down --volumes --remove-orphans
rm -f .env
```

## Essai B — Tuwunel + Cinny

```sh
cd lab/tuwunel-cinny
cp .env.example .env
# Modifier le jeton d'inscription dans .env.
docker compose --env-file .env up
```

Ouvrir `http://127.0.0.1:8080`. Le homeserver de laboratoire est `http://localhost:8008` et la fédération est désactivée. Le jeton d'inscription est réservé au laboratoire. Cinny est verrouillé sur ce homeserver local dans le laboratoire. Pour des essais sur téléphone, remplacer cette configuration locale par un nom HTTPS de test et conserver la fédération désactivée tant que le besoin n'est pas démontré.

Arrêt sans effacer les données :

```sh
docker compose --env-file .env down
```

Suppression complète des données de laboratoire :

```sh
docker compose --env-file .env down --volumes --remove-orphans
rm -f .env
```

## État de validation au 2026-09-27

Les fichiers YAML et JSON de ce laboratoire ont été contrôlés statiquement. L'environnement d'exécution utilisé pour préparer le dépôt ne fournit ni Docker ni Podman : aucun lancement local de conteneur n'a donc pu être effectué ici. La disponibilité réelle des images, le premier démarrage, l'inscription, le chiffrement, la restauration et les notifications restent à vérifier sur une machine équipée de Docker.

Les tags `v1.9.3` de Tuwunel et `v4.12.7` de Cinny correspondent aux releases actuelles consultées le 2026-09-27 ; leurs workflows amont publient des images de conteneur lors des releases. Databag est construit directement depuis un commit amont verrouillé pour éviter la dépendance à un tag `latest`.

Suivre ensuite [`docs/test-appareils.md`](../docs/test-appareils.md). La décision finale reste **en attente des essais réels**.
