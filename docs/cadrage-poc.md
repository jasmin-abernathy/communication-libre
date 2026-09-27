# Cadrage du POC Web

## Hypothèse

Un collectif de 10 à 30 personnes peut rejoindre une messagerie libre auto-hébergée par **une URL et un compte**, sur mobile et ordinateur, sans téléchargement obligatoire.

Le laboratoire compare en priorité **Databag** et **Tuwunel + Cinny**. Mattermost est désormais une solution de repli à reconsidérer uniquement si ces deux pistes échouent sur les critères indispensables.

## Phases

1. **Laboratoire local, données factices** : démarrer les deux configurations de [`lab/`](../lab/README.md), créer quelques comptes, vérifier sauvegarde/restauration et fonctions essentielles.
2. **Essais appareils** : appliquer [`test-appareils.md`](test-appareils.md) sur Android, iPhone et ordinateur, en Wi-Fi puis réseau mobile.
3. **Choix d'une seule messagerie** : retenir la solution qui satisfait effectivement l'arrivée par URL, les groupes, la récupération et les notifications ; ne pas attribuer de score sans preuve.
4. **Pilote fermé** : seulement après les étapes précédentes, ouvrir à 10–30 volontaires sans données sensibles.
5. **Vidéo si nécessaire** : ajouter un service Web distinct seulement si le groupe confirme ce besoin.

## Critères de réussite

- arrivée par URL et invitation sans installation ;
- premier message et groupe fonctionnels sur mobile et ordinateur ;
- pas de bug bloquant dans les groupes ;
- notifications suffisamment fiables ou limite explicitement acceptée ; pour Cinny `v4.12.7`, l'absence de Web Push navigateur fermé est déjà établie par le code ;
- récupération après déconnexion/perte d'appareil comprise ;
- chiffrement correctement compris par les participants ;
- sauvegarde/restauration réussie ;
- départ d'un membre et révocation vérifiés ;
- parcours clavier, lisibilité et zoom contrôlés ;
- charge d'administration compatible avec un petit collectif.

## Conditions d'arrêt

Arrêter ou limiter le pilote si la restauration échoue, si un bug de groupe fait perdre des échanges, si les notifications rendent l'outil inutilisable, si la récupération des clés est incompréhensible ou si les participants veulent y traiter des échanges dont le niveau de confidentialité n'est pas garanti par la configuration testée.

## Hors périmètre initial

Fédération ouverte, pont Telegram, synchronisation Verger Associations, vidéo de groupe installée d'emblée, déploiement national et fusion des deux solutions de laboratoire.
