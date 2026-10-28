# Démarrer le laboratoire Databag — sans production

Cette configuration sert uniquement à des **essais avec des comptes et messages fictifs**. Elle n'est pas un serveur public prêt à l'emploi. Lire aussi [`../README.md`](../README.md) et [`../../docs/test-appareils.md`](../../docs/test-appareils.md).

## Pré-vol en une commande

Depuis `lab/databag/` :

```sh
cp .env.example .env
python3 -c 'import secrets; print(secrets.token_hex(24))'
# Remplacer DATABAG_ADMIN_PASSWORD dans .env avec la valeur générée.
python3 preflight.py
```

Ce pré-vol **ne démarre rien**. Il vérifie que :

- le secret a une forme acceptable, sans l'afficher (ceci n'empêche pas qu'il soit visible par l'administrateur Docker une fois le conteneur lancé) ;
- le service reste lié à `127.0.0.1` et utilise un port valide ;
- Docker Compose accepte la configuration versionnée.

**Ne pas utiliser** `DATABAG_BIND=0.0.0.0` pour faciliter un essai téléphone : conserver le labo local, puis configurer séparément un proxy HTTPS restreint comme décrit dans [`../README.md`](../README.md). Le contrôle ne vérifie pas la sûreté du proxy.

Après un pré-vol réussi seulement :

```sh
docker compose --env-file .env up -d --build
docker compose --env-file .env ps
curl -fsS http://127.0.0.1:7000/ >/dev/null
```

Si le port a été modifié dans `.env`, adapter la commande `curl`. Une réponse HTTP **ne valide pas** le chiffrement de bout en bout, les groupes, les invitations, les alertes ou la restauration. Suivre les scénarios A1 à A10 du protocole appareils et laisser « non testé » partout où ils ne sont pas passés.

Arrêt (sans effacer les données de test) :

```sh
docker compose --env-file .env down
```

Tests automatisés des seuls garde-fous de pré-vol :

```sh
python3 -m unittest discover -s tests -v
```
