# Protocole d'essais sur appareils

## Règles

- 4 à 6 comptes factices maximum pour le premier passage ;
- aucun message privé réel, numéro de téléphone, adresse, fichier client ou donnée sensible ;
- mêmes scénarios pour Databag puis Tuwunel + Cinny ;
- noter les résultats observés, pas ce que la documentation promet ;
- ne jamais recopier le contenu des messages dans une remontée d'incident : utiliser un identifiant de scénario, l'heure, l'appareil et le symptôme.

## Matrice minimale

Tester au moins :

- Android récent : Chrome ou Firefox ;
- iPhone récent : Safari ;
- ordinateur : un navigateur Chromium et Firefox ;
- Wi-Fi puis réseau mobile pour les appareils téléphoniques.

## Scénarios

| ID | Action | Résultat attendu | Résultat Databag | Résultat Tuwunel + Cinny |
|---|---|---|---|---|
| A1 | ouvrir l'URL et créer un compte depuis une invitation | aucun téléchargement obligatoire | à tester | à tester |
| A2 | envoyer puis recevoir un premier message | message visible sans rechargement manuel | à tester | à tester |
| A3 | créer un groupe de trois personnes | aucun crash, membres compréhensibles | à tester | à tester |
| A4 | quitter le navigateur 10 minutes, recevoir un message | notification ou limite clairement constatée | à tester | à tester |
| A5 | fermer le navigateur et verrouiller le téléphone | notification reçue, sinon échec documenté | à tester | à tester |
| A6 | reprendre après 24 h | historique cohérent, pas de session cassée | à tester | à tester |
| A7 | changer de réseau Wi-Fi vers mobile | reprise sans perte de messages | à tester | à tester |
| A8 | perdre la session/appareil de test puis se reconnecter | procédure de récupération comprise | à tester | à tester |
| A9 | retirer un compte du groupe | révocation effective et compréhensible | à tester | à tester |
| A10 | sauvegarder puis restaurer l'instance | comptes et historique factice restaurés | à tester | à tester |

## Vérifications spécifiques Databag

1. Créer un sujet non scellé puis un sujet `sealed` et vérifier que l'interface explique suffisamment la différence.
2. Exporter ou sauvegarder la clé de chiffrement avec un mot de passe factice, puis vérifier le parcours de récupération.
3. Reproduire le scénario de groupe où tous les membres ne se sont pas ajoutés mutuellement, car un ticket amont ouvert en août 2026 signale un crash dans ce cas.
4. Tester le Web Push sur navigateur mobile : le code Web actuel enregistre un service worker et une souscription Push, mais cela ne prouve pas la fiabilité quand le navigateur est fermé.
5. Ne pas tester l'appel de groupe comme fonctionnalité acquise : le backlog amont le présente encore comme travail à faire.

## Vérifications spécifiques Tuwunel + Cinny

1. Créer un salon chiffré et vérifier la vérification des appareils ainsi que le comportement après nouvelle session.
2. Tester la récupération des clés après déconnexion, sans considérer le simple fait que Matrix supporte le chiffrement comme une preuve que le parcours Cinny est fiable.
3. Vérifier les notifications navigateur en arrière-plan et navigateur fermé. Cinny dispose d'un service worker, mais son projet considère encore l'expérience PWA/mobile native comme incomplète.
4. Tester les appels séparément. Les fonctions d'appel ont évolué en 2026 et ne doivent pas être confondues avec une expérience stabilisée sur tous les navigateurs mobiles.

## Grille d'incident

Pour chaque échec, relever seulement :

- identifiant de scénario ;
- solution et version ;
- appareil, OS et navigateur ;
- Wi-Fi ou réseau mobile ;
- heure approximative ;
- étape qui échoue ;
- capture d'écran expurgée si nécessaire ;
- extrait de journal technique sans message, nom réel, identifiant personnel ni secret.

## Décision

Aucune solution n'est retenue avant les essais réels. Une application mobile facultative peut être proposée si elle résout un problème de notification démontré ; elle ne doit pas devenir une dépendance par défaut sans nécessité observée.
