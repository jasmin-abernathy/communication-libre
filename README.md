# Communication libre

Dépôt de travail privé pour préparer un **proof of concept (POC) de communication libre, auto-hébergée et réversible** à destination de collectifs, associations, syndicats, mouvements et structures distribuées.

Le projet étudie un environnement cohérent reposant principalement sur :

- **Matrix / Synapse** pour les messages et les salons ;
- **Element Web et Element X** pour les interfaces Web, ordinateur et mobile ;
- **Jitsi Meet** pour les visioconférences ;
- **Coturn** pour améliorer la connectivité des appels ;
- une migration progressive depuis Telegram et Zoom, sans coupure brutale.

> Ce projet est indépendant et exploratoire. Il ne constitue pas un outil officiel de La France insoumise ni d'une autre organisation.

## Objectif immédiat

Construire un petit pilote pour 10 à 30 volontaires afin de répondre par des mesures et des retours d'usage à quatre questions :

1. Matrix/Element peut-il remplacer les usages courants de Telegram ?
2. Une instance Jitsi dédiée apporte-t-elle une qualité suffisamment prévisible ?
3. L'ensemble reste-t-il simple pour des personnes non techniques, notamment sur mobile ?
4. Quel niveau d'administration, de sécurité, d'hébergement et de maintenance faut-il réellement prévoir ?

## Principes

- logiciel libre et infrastructure maîtrisable ;
- chiffrement de bout en bout pour les salons qui le nécessitent ;
- aucune IA imposée, aucune publicité et aucun tracker publicitaire ;
- sobriété, accessibilité et compatibilité mobile ;
- inscriptions fermées pendant le pilote ;
- fédération désactivée ou limitée par liste d'autorisation au départ ;
- secrets, mots de passe et clés strictement absents du dépôt ;
- aucune promesse de « sécurité absolue » : le POC doit documenter ses limites.

## Périmètre du premier POC

- un serveur Matrix ;
- Element Web ;
- connexion avec Element X sur Android et iOS ;
- salons d'annonces, de discussion et salons privés chiffrés ;
- une instance Jitsi dédiée ;
- TURN ;
- sauvegardes, supervision et procédure de mise à jour ;
- protocole de test et recueil des retours ;
- estimation des coûts et de la charge d'administration.

Le pont Telegram ↔ Matrix reste une option de transition pour les contenus non sensibles. Il ne doit pas être activé par défaut ni utilisé pour des salons confidentiels.

## État du projet

**Phase 0 — cadrage et prise de température.**

Aucun service n'est encore déployé et aucune organisation n'a validé l'expérimentation. Le premier livrable est une proposition courte permettant de savoir si des volontaires souhaitent tester le POC.

## Structure

- `docs/proposition-forum.md` : texte de première contribution ;
- `docs/cadrage-poc.md` : périmètre, étapes et critères de réussite ;
- `docs/architecture.md` : architecture technique envisagée ;
- `infrastructure/` : futur déploiement reproductible ;
- `SECURITY.md` : règles de sécurité du dépôt ;
- `AGENTS.md` : règles de travail pour les futures modifications assistées.

## Décisions encore ouvertes

- nom public du projet ;
- hébergeur et dimensionnement ;
- domaine ou sous-domaines de test ;
- Synapse seul ou distribution/outil de déploiement existant ;
- politique de fédération ;
- méthode d'authentification et gestion des départs ;
- durée de conservation et sauvegardes ;
- licence à utiliser lors d'une éventuelle publication.

## Licence

À déterminer avant le passage éventuel du dépôt en public. Les licences et obligations des composants amont devront être respectées.
