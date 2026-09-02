# Proposition de première contribution

## Version prête à publier

Je fais partie du groupe numérique depuis quelque temps, mais je n'ai jusqu'ici quasiment pas participé aux échanges, notamment parce que je souhaite éviter Telegram et Zoom.

Avant de développer quoi que ce soit, je voulais savoir s'il y aurait un intérêt pour tester une alternative libre et auto-hébergée, sans demander à ce stade de remplacer les outils existants.

Pour la messagerie, je pense à Matrix/Element — la technologie sur laquelle repose notamment Tchap — avec un serveur maîtrisé et des salons privés pouvant être chiffrés de bout en bout. Pour les utilisateurs, Element existe sur Android, iOS, Web et ordinateur : il n'est pas nécessaire de comprendre l'architecture Matrix pour l'utiliser.

Pour la visioconférence, je propose d'évaluer une instance Jitsi dédiée, correctement dimensionnée, plutôt qu'une instance publique partagée. Elle pourrait être reliée aux salons Matrix afin d'offrir un environnement cohérent.

Je peux préparer un petit proof of concept pour le groupe numérique, destiné à 10 à 30 volontaires, afin de tester concrètement :

- la simplicité d'installation et d'utilisation ;
- la fiabilité des notifications mobiles ;
- les salons et annonces ;
- la qualité des appels sur différentes connexions ;
- le partage d'écran ;
- l'accessibilité ;
- la charge serveur, l'administration et les coûts ;
- les procédures de sécurité, de sauvegarde et de départ d'un membre.

L'auto-hébergement ne rend pas automatiquement un service plus sûr : il transfère aussi la responsabilité des mises à jour, des sauvegardes, des comptes et de la supervision. L'objectif du pilote serait justement de mesurer ces contraintes sans interrompre les usages actuels.

**Est-ce que ce serait quelque chose que le groupe aurait intérêt à expérimenter ?**

## Réponses courtes aux objections probables

### « Pourquoi ne pas rester sur Telegram ? »

L'enjeu n'est pas seulement que Telegram soit propriétaire : ses groupes et canaux ordinaires ne sont pas chiffrés de bout en bout. Matrix permet de créer des salons E2EE et d'héberger l'infrastructure choisie par l'organisation.

### « Matrix est trop compliqué »

Le pilote doit précisément tester ce point. Les utilisateurs emploieraient Element X sur téléphone ou Element sur ordinateur, avec un serveur déjà présélectionné et un parcours simplifié.

### « Jitsi laggue »

Une instance publique partagée et une instance dédiée ne donnent pas la même prévisibilité. Il ne faut pas promettre l'absence de ralentissements, mais dimensionner un serveur, configurer TURN puis mesurer les résultats à 10, 20 et 30 participants.

### « On ne peut pas migrer tout le monde »

Le POC ne demande aucune migration. Il fonctionne d'abord en parallèle. Un pont temporaire peut être étudié pour les annonces non sensibles, jamais pour les salons confidentiels.

### « Qui maintient tout cela ? »

C'est l'un des résultats attendus : documenter le temps, les compétences, le coût et les procédures nécessaires avant toute décision plus large.
