# Décision 0002 — Messagerie accessible dans le navigateur

- Statut : laboratoire Databag et Tuwunel + Cinny ; décision finale en attente
- Date : 2026-09-27

## Motif

Le besoin prioritaire est simple : une personne doit pouvoir rejoindre un collectif depuis une URL sur téléphone ou ordinateur, sans installer une série d'applications. L'ancienne pile Matrix/Element + Jitsi est trop lourde pour ce premier objectif. Mattermost a ensuite été envisagé pour simplifier le parcours, mais sa limite de confidentialité côté serveur et son architecture ne justifient pas d'en faire le point de départ tant que des alternatives plus légères restent plausibles.

## Décision

1. Construire et tester d'abord **Databag** et **Tuwunel + Cinny** dans deux environnements isolés.
2. Mesurer le même parcours sur les deux solutions : invitation, compte, message, groupe, reprise après 24 h, récupération, notifications navigateur fermé, révocation et restauration.
3. Pour Databag, tester séparément les sujets ordinaires et `sealed`, et reproduire le scénario de groupe signalé comme défaillant en août 2026.
4. Pour Tuwunel + Cinny, vérifier réellement les salons chiffrés, la vérification des appareils, la récupération des clés et les limites des notifications Web mobiles.
5. Ne pas ajouter de vidéo de groupe au laboratoire initial. L'évaluer ensuite comme service séparé si le besoin est confirmé.
6. Garder Mattermost comme **comparateur secondaire**, sans nouveau déploiement tant que les deux alternatives prioritaires n'ont pas échoué sur des critères essentiels.
7. Conserver l'ancien code Matrix/Element uniquement comme référence protégée par `LEGACY_MATRIX_POC=1`.

## Conséquences

Aucune solution n'est déclarée retenue aujourd'hui. Les fichiers de [`lab/`](../../lab/README.md) sont conçus pour des données factices et les résultats devront être consignés dans [`docs/test-appareils.md`](../test-appareils.md).

Le choix final doit privilégier le plus petit ensemble de composants qui satisfait réellement le groupe, sans sacrifier une garantie de confidentialité nécessaire ni masquer une dépendance à une application native.
