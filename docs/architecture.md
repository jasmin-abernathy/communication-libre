# Architecture envisagée pour le pilote

Le laboratoire compare deux architectures légères avant de retenir une messagerie. Mattermost n'est plus une cible prioritaire et l'ancien déploiement Matrix/Element reste historique.

## Parcours participant visé

1. La personne ouvre une URL sur téléphone ou ordinateur.
2. Elle accepte une invitation et crée son compte.
3. Elle rejoint un groupe et échange sans installer d'application.
4. Le navigateur reçoit idéalement les alertes essentielles ; si ce point échoue sur un système donné, l'application native reste une option facultative à discuter après mesure.
5. La vidéo de groupe, si elle devient nécessaire, est traitée comme un service séparé.

## Architecture A — Databag

| Élément | Rôle | État |
|---|---|---|
| Databag | serveur, interface Web, comptes, groupes, sujets et appels 1:1 | laboratoire préparé |
| volume Databag | données de test | isolé |
| HTTPS | exigé pour un vrai test Web Push sur téléphone | à préparer sur machine de test |
| STUN/TURN | appels à travers certains réseaux | hors premier test texte |

Databag a l'avantage d'un service principal unique. Le chiffrement de bout en bout est lié aux sujets `sealed` et doit être expliqué comme tel. Les appels de groupe ne sont pas considérés comme disponibles tant que le backlog amont les présente encore comme travail à réaliser.

## Architecture B — Tuwunel + Cinny

| Élément | Rôle | État |
|---|---|---|
| Tuwunel | homeserver Matrix | laboratoire `v1.9.3` préparé |
| Cinny | interface Web | laboratoire `v4.12.7` préparé |
| volume Tuwunel | base de données Matrix | isolé |
| HTTPS | navigation mobile, sécurité et tests d'alertes | à préparer sur machine de test |
| service d'appel/TURN | appels si retenus | secondaire |

Le laboratoire désactive la fédération. Le client et le serveur restent deux briques, mais l'interface est servie dans le navigateur et Tuwunel évite la pile Synapse/Element plus lourde étudiée auparavant.

## Anciennes hypothèses

Mattermost reste un comparateur fonctionnel mais n'est pas développé dans le laboratoire actuel. Matrix/Element + Jitsi, Coturn et l'overlay Ansible existant sont conservés uniquement comme historique technique et nécessitent `LEGACY_MATRIX_POC=1` pour leurs commandes.

## Sécurité et exploitation communes

Avant tout pilote avec de vraies personnes :

- HTTPS valide ;
- inscriptions fermées ou à jeton ;
- sauvegarde puis restauration réussie ;
- révocation d'un compte vérifiée ;
- procédure de perte d'appareil comprise ;
- périmètre du chiffrement documenté sans promesse globale ;
- journaux et captures de test expurgés ;
- notifications mesurées sur Android/iPhone, Wi-Fi et réseau mobile.

La décision finale est **en attente des essais appareils** décrits dans [`test-appareils.md`](test-appareils.md).
