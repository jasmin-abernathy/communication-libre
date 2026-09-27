# Décision 0002 — Messagerie accessible dans le navigateur

- Statut : accepté pour le prochain pilote
- Date : 2026-09-27

## Motif

Le critère prioritaire est de réduire les installations demandées aux participants. Le socle Matrix/Element + Jitsi initial multiplie les composants serveur et son expérience mobile incite à installer Element X. Delta Chat convient au pilote Webxdc de Verger Associations, mais une application y reste le parcours ordinaire. Mattermost propose une messagerie utilisable sur mobile et ordinateur dans le navigateur, avec appels audio et partage d'écran. La vidéo de groupe est traitée comme un besoin distinct.

## Décision

1. Choisir Mattermost Team Edition auto-hébergé comme messagerie du pilote, avec invitations fermées et accès par URL.
2. Tester d'abord le navigateur, sans demander d'application. Évaluer ensuite une application facultative uniquement si les notifications ou l'ergonomie mobile posent problème.
3. Ne pas installer Jitsi par défaut. Tester un lien Jitsi Web si la vidéo de groupe est confirmée.
4. Conserver l'ancien code Matrix en référence, mais bloquer ses commandes Makefile ordinaires ; construire un nouveau déploiement avant tout accueil de testeurs.
5. Ne pas présenter les messages Mattermost comme chiffrés de bout en bout. Exclure les échanges qui l'exigent et réexaminer le choix si ce besoin devient prioritaire.

## Conséquences

Le parcours d'arrivée vise une URL et un compte. Côté serveur, Mattermost, PostgreSQL, un accès HTTPS et des sauvegardes restent à maintenir. La fiabilité des notifications dans un navigateur mobile, les appels et l'accessibilité doivent être vérifiés réellement. Le module Webxdc de Verger Associations ne fonctionne pas dans Mattermost ; seul son relevé exporté peut être partagé sans développement supplémentaire.

## Sources amont

- [Clients et accès Web Mattermost](https://docs.mattermost.com/end-user-guide/access/client-availability)
- [Appels Mattermost et limites de la vidéo](https://docs.mattermost.com/end-user-guide/collaborate/make-calls)
- [Éditions Mattermost](https://docs.mattermost.com/product-overview/editions-and-offerings.html)
- [Chiffrement Mattermost](https://docs.mattermost.com/deployment-guide/encryption-options.html)
- [Jitsi Meet](https://jitsi.org/jitsi-meet/)
