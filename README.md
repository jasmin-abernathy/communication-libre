# Communication libre

Dépôt de travail privé pour préparer un **proof of concept (POC) de communication libre, auto-hébergée et réversible** à destination de collectifs, associations, syndicats, mouvements et structures distribuées.

> Projet indépendant et exploratoire : il ne constitue pas un outil officiel de La France insoumise ni d'une autre organisation.

## TL;DR

Le dépôt contient désormais un socle de déploiement pour :

- **Matrix / Synapse** : messages, comptes et salons ;
- **Element Web et Element X** : Web, ordinateur, Android et iOS ;
- **Jitsi Meet** : visioconférences autonomes ou lancées depuis Element ;
- **Coturn** : connectivité audio/vidéo depuis les réseaux restrictifs ;
- **PostgreSQL et Traefik** : données, routage HTTPS et certificats.

Nous n'en recopions pas les sources. Nos scripts téléchargent une révision précise de [`matrix-docker-ansible-deploy`](https://github.com/spantaleev/matrix-docker-ansible-deploy), puis lui fournissent notre configuration. Aucun PHP n'est nécessaire au cœur du service.

## État

**Phase 0 — socle technique prêt, serveur et domaine non choisis.**

Ce qui est déjà implémenté :

- dépendance amont verrouillée ;
- inventaire d'exemple sans données réelles ;
- génération locale des secrets ;
- inscriptions et fédération désactivées ;
- Element limité au serveur du POC ;
- Jitsi authentifié, invités et lobby activés ;
- Gravatar, IA et intégrations externes non nécessaires désactivés ;
- réglages vidéo sobres ;
- scripts de contrôle, installation et création de comptes ;
- validation automatique GitHub Actions ;
- guides DNS, pare-feu, installation et exploitation.

Aucun service n'est actuellement déployé.

## Démarrage futur

Lorsque le domaine et le VPS seront choisis :

```sh
make init DOMAIN=exemple.fr IP=203.0.113.10 SSH_USER=deploy
make fetch
make check
make install
```

Puis création des comptes :

```sh
make register USER=jasmin ADMIN=1
make register USER=personne-test
```

Ne jamais committer le dossier `runtime/` : il contient les secrets du déploiement.

## Principes

- logiciel libre et infrastructure maîtrisable ;
- chiffrement de bout en bout pour les salons qui le nécessitent ;
- aucune IA imposée, publicité ou tracker publicitaire ;
- sobriété, accessibilité et compatibilité mobile ;
- inscriptions fermées pendant le pilote ;
- fédération désactivée au départ, puis éventuellement limitée ;
- secrets, mots de passe et clés strictement absents de Git ;
- aucune promesse de sécurité absolue.

## Documentation

- [`docs/proposition-forum.md`](docs/proposition-forum.md) : texte de première contribution ;
- [`docs/cadrage-poc.md`](docs/cadrage-poc.md) : périmètre et critères de réussite ;
- [`docs/architecture.md`](docs/architecture.md) : architecture envisagée ;
- [`docs/installation.md`](docs/installation.md) : préparation et installation ;
- [`docs/dns-et-pare-feu.md`](docs/dns-et-pare-feu.md) : DNS et ports ;
- [`docs/exploitation.md`](docs/exploitation.md) : maintenance, sauvegardes et incidents ;
- [`docs/references.md`](docs/references.md) : sources amont et licences ;
- [`SECURITY.md`](SECURITY.md) : politique de sécurité.

## Périmètre du premier POC

- 10 à 30 volontaires ;
- salons d'annonces, discussions et salons E2EE ;
- Element Web et Element X ;
- deux ou trois réunions Jitsi ;
- test sur fibre, Wi-Fi et réseau mobile ;
- sauvegarde et restauration ;
- estimation des coûts et du temps d'administration.

Le pont Telegram ↔ Matrix reste une option ultérieure pour les contenus non sensibles. Il n'est ni installé ni activé par défaut.

## Décisions encore ouvertes

- nom public du projet ;
- domaine et hébergeur ;
- dimensionnement du VPS ;
- politique de fédération après le pilote fermé ;
- méthode d'authentification à plus grande échelle ;
- durée de conservation et sauvegardes ;
- licence propre au projet avant une éventuelle publication.
