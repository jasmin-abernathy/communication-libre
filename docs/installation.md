# Installation du POC

Ce guide prépare un pilote fermé Matrix/Element + Jitsi. Il ne constitue pas une procédure de mise en production pour des échanges critiques.

## 1. Préparer le serveur

Le serveur doit disposer :

- d'une distribution Linux compatible avec le playbook ;
- d'un accès SSH avec `sudo` ou `root` ;
- de Docker et des prérequis indiqués par le playbook ;
- d'au moins 2 Go de mémoire pour la base Matrix, avec davantage de marge pour Jitsi ;
- d'une adresse IPv4 publique fixe ;
- des ports Web, Jitsi et TURN ouverts selon [dns-et-pare-feu.md](dns-et-pare-feu.md).

Un hébergement PHP/cPanel mutualisé ne suffit pas : la visioconférence utilise notamment UDP et l'installation demande des droits système.

## 2. Installer les outils sur le poste d'administration

Prévoir Git, OpenSSL, Ansible et Ansible Galaxy. `make`, ShellCheck et yamllint sont recommandés.

## 3. Initialiser l'inventaire privé

```sh
make init DOMAIN=exemple.fr IP=203.0.113.10 SSH_USER=deploy
```

Le script :

- refuse les domaines d'exemple ;
- exige une IPv4 explicite pour TURN ;
- génère des secrets forts ;
- crée `runtime/inventory`, ignoré par Git ;
- ferme les inscriptions et la fédération ;
- configure un compte Jitsi `pilot-admin` avec un mot de passe généré.

Lire ensuite entièrement le fichier `runtime/inventory/host_vars/matrix.<domaine>/vars.yml`.

## 4. Vérifier avant installation

```sh
make fetch
make check
```

La dépendance amont est téléchargée dans `.cache/` à la révision inscrite dans `upstream.env`.

## 5. Installer

Vérifier auparavant les DNS et le pare-feu, puis lancer :

```sh
make install
```

Pour réappliquer ultérieurement toute la configuration :

```sh
make reconcile
```

## 6. Créer les comptes Matrix

```sh
make register USER=jasmin ADMIN=1
make register USER=personne-test
```

Le mot de passe est demandé sans être affiché et transmis à Ansible par un fichier temporaire protégé.

## 7. Vérifier le pilote

- connexion à Element Web ;
- connexion au même compte dans Element X sur Android ou iOS ;
- vérification et récupération des clés ;
- salon privé chiffré ;
- création Jitsi réservée à `pilot-admin` ;
- arrivée d'un invité et salle d'attente ;
- test audio seul puis vidéo à 10, 20 et 30 participants ;
- sauvegarde et restauration avant toute donnée importante.
