# Décision 0002 — Messagerie accessible dans le navigateur

- Statut : Databag choisi comme piste active ; mise en service en attente des essais
- Date : 2026-09-27

## Motif

Le besoin prioritaire est simple : une personne doit pouvoir rejoindre un collectif depuis une URL sur téléphone ou ordinateur, sans installer une série d'applications. L'ancienne pile Matrix/Element + Jitsi est trop lourde pour ce premier objectif. Mattermost a ensuite été envisagé pour simplifier le parcours, mais sa limite de confidentialité côté serveur et son architecture ne justifient pas d'en faire le point de départ tant que des alternatives plus légères restent plausibles.

## Décision

1. Avancer sur **Databag** comme messagerie du premier pilote ; lancer son laboratoire isolé avant d'accueillir des personnes réelles.
2. Mesurer invitation, compte, message, groupe, reprise après 24 h, récupération, notifications navigateur fermé, révocation et restauration.
3. Pour Databag, tester séparément les sujets ordinaires et `sealed`, et reproduire le scénario de groupe signalé comme défaillant en août 2026.
4. Conserver Tuwunel + Cinny comme laboratoire comparatif à reprendre seulement si Databag échoue sur un critère indispensable ; dans ce cas, vérifier réellement les salons chiffrés, la vérification des appareils et la récupération des clés. Le code de Cinny `v4.12.7` établit déjà l'absence de Web Push lorsque le navigateur est fermé ; le test appareil sert à confirmer le comportement visible, pas à supposer cette capacité.
5. Ne pas ajouter de vidéo de groupe au laboratoire initial. L'évaluer ensuite comme service séparé si le besoin est confirmé.
6. Ne pas développer de laboratoire Mattermost dans cette phase.
7. Conserver l'ancien code Matrix/Element uniquement comme référence protégée par `LEGACY_MATRIX_POC=1`.

## Conséquences

Databag est retenu comme piste de travail, sans feu vert pour un usage réel. Les fichiers de [`lab/`](../../lab/README.md) sont conçus pour des données factices et les résultats devront être consignés dans [`docs/test-appareils.md`](../test-appareils.md).

L'ouverture du pilote dépend des essais et du plus petit ensemble de composants qui satisfait réellement le groupe, sans sacrifier une garantie de confidentialité nécessaire ni masquer une dépendance à une application native. Si l'alerte écran verrouillé sans application est indispensable, le couple Tuwunel + Cinny actuel ne peut être retenu tel quel : il faut soit tester un autre client Matrix, soit assumer explicitement un autre canal.
