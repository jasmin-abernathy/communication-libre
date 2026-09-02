# DNS et pare-feu

Les valeurs ci-dessous sont indicatives jusqu'au choix du domaine et du serveur.

## DNS

Pour un domaine `exemple.fr` et un serveur `203.0.113.10` :

| Type | Nom | Cible |
|---|---|---|
| A | `matrix.exemple.fr` | `203.0.113.10` |
| CNAME | `element.exemple.fr` | `matrix.exemple.fr` |
| CNAME | `jitsi.exemple.fr` | `matrix.exemple.fr` |

Ajouter les enregistrements AAAA seulement si l'IPv6 est réellement opérationnelle. Le POC démarre sans fédération ; la délégation Matrix publique et le port 8448 ne sont donc pas nécessaires au premier test fermé.

## Ports entrants

| Port | Protocole | Usage |
|---:|---|---|
| 22 | TCP | SSH, à restreindre autant que possible |
| 80 | TCP | validation des certificats et redirection HTTPS |
| 443 | TCP | Element, Matrix et Jitsi Web |
| 4443 | TCP | repli média Jitsi |
| 10000 | UDP | média Jitsi principal |
| 3478 | TCP/UDP | STUN/TURN |
| 5349 | TCP/UDP | TURN chiffré |
| 49152–49172 | UDP | relais TURN |

Ne pas ouvrir PostgreSQL sur Internet. Les règles du fournisseur, du pare-feu du serveur et d'un éventuel NAT doivent toutes être cohérentes.

## Vérifications

- les trois noms DNS pointent vers le bon serveur ;
- aucun proxy HTTP tiers ne masque les ports WebRTC ;
- l'IP annoncée par Jitsi est l'IP publique réelle ;
- les tests sont faits depuis au moins deux réseaux différents ;
- TURN est testé depuis un réseau restrictif.
