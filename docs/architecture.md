# Architecture envisagée

## Vue logique

| Composant | Rôle | Exposition |
|---|---|---|
| Reverse proxy | TLS, routage et en-têtes de sécurité | Internet |
| Synapse | Serveur Matrix et comptes | Internet via proxy |
| PostgreSQL | Données Matrix | Réseau privé uniquement |
| Element Web | Client Web préconfiguré | Internet |
| Element X | Client Android/iOS | Applications officielles au départ |
| Jitsi Meet | Interface de visioconférence | Internet |
| Jitsi Videobridge | Transport audio/vidéo | Ports WebRTC nécessaires |
| Coturn | Relais lorsque la connexion directe échoue | Internet |
| Supervision | Disponibilité, ressources et alertes | Accès restreint |
| Sauvegardes | Restauration des services | Chiffrées, hors serveur |

## Sous-domaines indicatifs

- `matrix.example.invalid` : API Matrix ;
- `chat.example.invalid` : Element Web ;
- `meet.example.invalid` : Jitsi ;
- `turn.example.invalid` : TURN.

Aucun domaine réel ne doit être choisi avant validation du contexte et de l'organisation qui hébergera le pilote.

## Choix de départ

- serveur unique adapté à 10–30 testeurs ;
- PostgreSQL plutôt qu'une base locale ;
- inscriptions publiques désactivées ;
- administration restreinte ;
- salons sensibles E2EE ;
- fédération désactivée ou limitée ;
- Jitsi authentifié pour la création des réunions ;
- invités éventuellement autorisés à rejoindre une réunion par lien selon le test ;
- rétention minimale des journaux compatible avec le diagnostic ;
- vidéos désactivables et non obligatoires.

## Flux de confiance

1. Les clients chiffrent le contenu des salons E2EE avant envoi.
2. Synapse distribue et stocke les événements sans détenir automatiquement toutes les clés de déchiffrement.
3. Les appareils et la récupération de clés deviennent des éléments critiques.
4. Jitsi traite les flux média selon la configuration retenue ; ses fonctions annexes n'ont pas toutes les mêmes garanties.
5. Un pont Telegram, s'il existe, constitue une frontière de confiance et reste exclu des salons sensibles.
6. Les sauvegardes, journaux et consoles d'administration doivent être protégés séparément.

## Limite fonctionnelle et interopérabilité

Cette architecture transporte des échanges et fournit de la visioconférence. Les données officielles d'une association (membres, cotisations, décisions validées, archives) relèvent de ses outils métier et de son stockage documentaire, pas du serveur Matrix.

Le pilote [Verger Associations](https://github.com/jasmin-abernathy/verger-associations) utilise Delta Chat et Webxdc pour son module « Réunions et décisions ». Matrix/Element ne prend pas en charge ce paquet Webxdc tel quel. Pour partager un résultat entre les projets, privilégier l'export d'un relevé validé en Markdown ou JSON versionné, avec son archivage officiel hors messagerie. Ne pas prévoir de synchronisation de salons ou de pont de contenus sensibles comme prérequis.

## Points à trancher avant implémentation

- méthode de déploiement et distribution Matrix ;
- versions supportées ;
- fournisseur de notifications mobiles et implications ;
- politique de fédération ;
- intégration Jitsi dans Element ;
- méthode d'authentification ;
- dimensionnement réseau/CPU ;
- fréquence et durée des sauvegardes ;
- observabilité compatible avec la minimisation des données ;
- hébergeur français ou européen et juridiction.
