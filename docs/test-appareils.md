# Protocole d'essais sur appareils

## Règles

- 4 à 6 comptes factices maximum pour le premier passage ;
- aucun message privé réel, numéro de téléphone, adresse, fichier client ou donnée sensible ;
- mêmes scénarios pour Databag puis Tuwunel + Cinny, sauf lorsqu'une limitation de code est déjà établie ;
- noter les résultats observés, pas ce que la documentation promet ;
- ne jamais recopier le contenu des messages dans une remontée d'incident : utiliser un identifiant de scénario, l'heure, l'appareil et le symptôme ;
- conserver **non testé** tant qu'un humain n'a pas réellement exécuté le scénario sur l'appareil indiqué.

## Préconditions

Avant le premier scénario :

1. lancer le laboratoire concerné suivant [`../lab/README.md`](../lab/README.md) ;
2. confirmer les contrôles HTTP de connectivité, sans les confondre avec des tests fonctionnels ;
3. créer des comptes strictement factices ;
4. pour un téléphone physique, utiliser une URL HTTPS reconnue par l'appareil ;
5. relever appareil, version d'OS, navigateur et type de réseau.

### Cas particulier iPhone/iPad

Apple prend en charge Web Push sur iOS/iPadOS pour une **web app ajoutée à l'écran d'accueil**. Un simple onglet Safari ne constitue donc pas un test positif possible de notification Web Push écran verrouillé. Pour Databag, exécuter A5 en deux variantes :

- **A5-iOS-Safari** : onglet Safari normal ; consigner l'absence attendue de Web Push comme limite de plateforme ;
- **A5-iOS-WebApp** : ajouter le site à l'écran d'accueil, autoriser les notifications après une action de l'utilisateur, puis verrouiller l'appareil.

Cette étape supplémentaire doit être comptée dans l'évaluation du parcours « sans installation obligatoire ».

### Cas particulier Cinny v4.12.7

L'analyse du code du tag `v4.12.7` établit que Cinny :

- demande la permission via `window.Notification.requestPermission()` ;
- crée les notifications via `new window.Notification(...)` lorsque le client Matrix est en cours de synchronisation ;
- n'utilise pas `PushManager` ;
- n'enregistre aucun gestionnaire d'événement `push` dans son service worker.

A5 reste à exécuter comme **contrôle négatif** sur appareil, mais une notification avec navigateur réellement fermé n'est pas une capacité fournie par cette version du client Web. Une notification e-mail Matrix existe séparément dans Cinny, mais ce n'est pas une notification Web Push.

## Matrice minimale

Tester au moins :

- Android récent : Chrome puis, si possible, Firefox ;
- iPhone récent : Safari, avec distinction onglet normal / web app écran d'accueil pour Web Push ;
- ordinateur : un navigateur Chromium et Firefox ;
- Wi-Fi puis réseau mobile pour les appareils téléphoniques.

## Scénarios à exécuter

| ID | Prérequis | Geste ou commande humaine | À consigner |
|---|---|---|---|
| A1 | service accessible, compte factice non créé | ouvrir l'URL et créer un compte via le parcours prévu | nombre d'étapes, besoin ou non d'installation, erreur éventuelle |
| A2 | deux comptes factices | envoyer puis recevoir un premier message | délai, rechargement éventuel, message reçu ou non |
| A3 | trois comptes factices | créer un groupe et échanger depuis les trois comptes | crash, membre manquant, erreur d'affichage ou fonctionnement normal |
| A4 | notifications autorisées lorsque le client les propose | placer le navigateur en arrière-plan 10 minutes puis envoyer un message | alerte reçue ou non, délai, état du navigateur |
| A5 | HTTPS reconnu ; pour iOS Databag, variante web app écran d'accueil | fermer réellement le navigateur/client, verrouiller le téléphone puis envoyer un message | alerte écran verrouillé ou absence, état exact du client |
| A6 | session existante | reprendre le même compte après 24 h | reconnexion, historique, erreur de session |
| A7 | session connectée | passer du Wi-Fi au réseau mobile pendant l'usage | reprise, messages perdus/dupliqués, délai |
| A8 | méthode de récupération préparée | supprimer la session locale de test puis se reconnecter | étapes nécessaires, accès aux clés et aux anciens messages |
| A9 | groupe de trois comptes | révoquer/retirer un compte | accès résiduel, clarté du départ, effet sur le groupe |
| A10 | sauvegarde de données factices et procédure de restauration | arrêter, sauvegarder, recréer/restaurer puis relancer | comptes/historique récupérés, durée, erreur exacte |

## État courant

| ID | Databag | Tuwunel + Cinny |
|---|---|---|
| A1 | non testé | non testé |
| A2 | non testé | non testé |
| A3 | non testé — reproduire en plus le ticket Databag #195 | non testé |
| A4 | non testé — mécanisme Web Push présent dans le code | non testé — notifications `window.Notification` seulement pendant l'exécution du client |
| A5 | non testé — sur iOS, tester seulement positivement après ajout à l'écran d'accueil | non testé — contrôle négatif : aucun mécanisme Web Push dans Cinny v4.12.7 |
| A6 | non testé | non testé |
| A7 | non testé | non testé |
| A8 | non testé — inclure la clé `sealed` | non testé — inclure vérification et récupération des clés Matrix |
| A9 | non testé | non testé |
| A10 | non testé | non testé |

## Vérifications spécifiques Databag

1. Créer un sujet non scellé puis un sujet `sealed` et vérifier que l'interface explique suffisamment la différence.
2. Exporter ou sauvegarder la clé de chiffrement avec un mot de passe factice, puis vérifier le parcours de récupération.
3. Reproduire le scénario de groupe où tous les membres ne se sont pas ajoutés mutuellement, car un ticket amont ouvert en août 2026 signale un crash dans ce cas.
4. Tester le Web Push sur navigateur mobile : le code Web épinglé crée une vraie souscription Push, mais cela ne prouve ni la livraison réelle ni la fiabilité écran verrouillé.
5. Ne pas tester l'appel de groupe comme fonctionnalité acquise : le backlog amont le présente encore comme travail à faire.

## Vérifications spécifiques Tuwunel + Cinny

1. Créer un salon chiffré et vérifier la vérification des appareils ainsi que le comportement après nouvelle session.
2. Tester la récupération des clés après déconnexion, sans considérer le simple fait que Matrix supporte le chiffrement comme une preuve que le parcours Cinny est fiable.
3. Vérifier A4 avec la page en arrière-plan, puis A5 comme contrôle négatif. La version Web `v4.12.7` n'implémente pas Web Push navigateur fermé.
4. Vérifier l'inscription avec jeton : Cinny prend en charge le stage `RegistrationToken`, mais le flux complet doit encore être exécuté contre Tuwunel.
5. Tester les appels séparément. Les fonctions d'appel ont évolué en 2026 et ne doivent pas être confondues avec une expérience stabilisée sur tous les navigateurs mobiles.

## Grille d'incident

Pour chaque échec, relever seulement :

- identifiant de scénario ;
- solution et version ;
- appareil, OS et navigateur ;
- Wi-Fi ou réseau mobile ;
- heure approximative ;
- étape qui échoue ;
- résultat attendu et résultat observé ;
- capture d'écran expurgée si nécessaire ;
- extrait de journal technique sans message, nom réel, identifiant personnel ni secret.

## Décision

Aucune solution n'est retenue avant les essais réels. Une application mobile facultative peut être proposée si elle résout un problème démontré ; elle ne doit pas devenir une dépendance par défaut sans nécessité observée.

Pour Tuwunel + Cinny, le manque de Web Push navigateur fermé est désormais une **limitation démontrée du client Web v4.12.7**, et non une simple incertitude. Si les alertes écran verrouillé sans application sont indispensables, il faudra soit changer de client Matrix, soit écarter cette combinaison pour ce critère.

Références :
- [Apple — Web Push dans les web apps et navigateurs](https://developer.apple.com/documentation/usernotifications/sending-web-push-notifications-in-web-apps-and-browsers)
- [WebKit — Web Push pour les web apps iOS/iPadOS](https://webkit.org/blog/13878/web-push-for-web-apps-on-ios-and-ipados/)
