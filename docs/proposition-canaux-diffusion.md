# Proposition à discuter — diffusion publique et messagerie privée

**Statut : proposition non validée ; aucune fonctionnalité de canal développée.** Le premier pilote Databag (10–30 personnes) conserve la priorité, selon [cadrage-poc.md](cadrage-poc.md).

## Besoin nouveau : informer un public plus large que les membres du groupe

La mobilisation autour d'un **canal WhatsApp à plus de 10 millions d'abonnés** pendant l'élection brésilienne de 2026 illustre l'intérêt d'une diffusion **un-à-plusieurs**. Il ne s'agit pas d'une conversation entre dix millions de personnes : les abonnés reçoivent des publications, puis peuvent les repartager ailleurs. Cela ne prouve pas qu'une messagerie de groupe, même fédérée, pourrait supporter dix millions de membres.

Le projet devrait distinguer clairement deux usages :

1. **Discuter et s'organiser en privé** : petits groupes, invitations, rôles, récupération des clés, confidentialité maîtrisée ; évaluer des sujets Databag `sealed`, sans prétendre que toutes les conversations sont chiffrées de bout en bout.
2. **Diffuser des annonces publiques** : publications lisibles et partageables par URL, potentiellement sans compte, pas de promesse de secret des contenus, identité des abonnés non requise pour consulter, modération et correction visibles.

## Option la plus légère à évaluer *après* les tests Databag

Un canal public reposant sur un site statique et un flux **Atom ou RSS**, idéalement sous un domaine contrôlé par le collectif, plutôt qu'une deuxième messagerie ou un groupe unique de taille illimitée. L'option permet un hébergement léger et une consultation depuis le navigateur ou un lecteur de flux, sans pistage ni inscription. **Ce n'est pas un service de notification instantanée** : les notifications nécessiteraient une conception et des tests spécifiques. La distribution à plusieurs millions de personnes ne peut être revendiquée sans mesures de charge et infrastructure de diffusion adaptée.

### Exigences avant toute décision

- Ne pas mélanger canal public et groupe privé : les contenus publics sont susceptibles d'être indexés, archivés et repris.
- Pas de collecte obligatoire du numéro de téléphone, du carnet d'adresses ou de l'identité des lectrices et lecteurs du canal public.
- Publications accessibles au clavier, lisibles avec des technologies d'assistance, et disponibles via des URL stables.
- Gouvernance du collectif : rôles de publication et de modération, correction d'une annonce, protection contre une prise de contrôle des comptes éditeurs.
- Modèle de menace et politique de rétention des journaux à établir avant tout déploiement ; ne pas confondre auto-hébergement et anonymat garanti.
- Pour une diffusion sensible / réservée aux membres, réévaluer le protocole, le contrôle d'accès et les garanties de chiffrement : un flux public ne convient pas.

## Décision attendue

Terminer A1/A2/A3/A8/A10/A4/A5 sur Databag. Seulement si le pilote de discussion est validé, faire un prototype de canal **public** distinct et mesurer sa simplicité d'utilisation. Ne pas détourner le pilote existant pour reproduire un canal WhatsApp national.

## Sources pour la distinction des usages

- [Le Monde — canal « Armée de Lula », 25 octobre 2026](https://www.lemonde.fr/international/article/2026/10/25/au-bresil-les-soutiens-de-lula-et-de-bolsonaro-mobilises-jusqu-au-bout-mon-pere-ne-votait-plus-je-l-ai-convaincu-que-cette-election-etait-la-plus-importante-de-notre-vie_6800063_3210.html)
- [WhatsApp — présentation officielle des canaux](https://blog.whatsapp.com/introducing-whatsapp-channels-a-private-way-to-follow-what-matters)
