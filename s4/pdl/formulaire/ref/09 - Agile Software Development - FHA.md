Processus de développement
en ingénierie logiciel

Méthodes Agile

Bertil Chapuis, Fouad Hanna, Olivier Cuisenaire, Juergen Ehrensberger

1

Bibliographie

2

Méthode Agile
Sujets abordés

• Méthodologies agiles et incrémentales

• Méthodes de développement agile (XP)

• Méthode de gestion de projet agile (SCRUM)

3

Méthodes agiles

4

Méthodes agiles
Une question de rapidité

• Les méthodes pilotées (modèles en cascade) sont essentielles à certains types
de projets, mais les temps de livraison sont longs et les processus sont lourds

• Apparues dans les années 1990, les méthodes agiles ont pour objectif de
réduire radicalement les temps de livraison et d’alléger les processus

• La rapidité des cycles de développement et de livraison est aujourd’hui l’un

des besoins les plus fondamentaux

• Les autres besoins évoluent tellement vite qu’il est difficile de les spécifier

sans qu’ils changent

• Le logiciel doit s’adapter aux besoins et non l’inverse

5

Méthodes agiles
Rappels

• Les activités de spécification, de

conception, de développement et de
validation sont entrelacées

• Le logiciel est développé en une série
de versions spécifiées et validées
avec toutes les parties prenantes

• Les livraisons permettent au client

d’évaluer fréquemment les nouvelles
versions

• L’automatisation joue un rôle clé

(tests unitaires, intégration continue,
livraison continue, etc.)

Illustration: Ian Sommerville,
Software Engineering 10th edition, chap. 2

6

Méthodes agiles
Piloté et/ou agile

• Dans les approches pilotées, les itérations
apparaissent au sein des activités. Des
documents formels (spécifications) sont
utilisés pour communiquer entre les activités

• Dans les approches agiles, des itérations

apparaissent entre les activités. La
définition des besoins, le design,
l’implémentation et les tests s’entremêlent et
s’influencent

• Dans la pratique, les grand projets agiles

incorporent des notions de pilotage

Illustration: Ian Sommerville,
Software Engineering 10th edition, chap. 2

7

Méthode agiles
Domaine d’application

• Développement d’un produit de petite ou moyenne taille

• Presque toutes les applications logicielles sont aujourd’hui développées

avec des approches agiles

• Développement sur mesure pour une organisation qui s’engage à prendre

part au processus de développement et qui n’est pas sujette à une
régulation qui affecte le logiciel

8

Agile Manifesto
https://agilemanifesto.org/

• Le Manifeste Agile a été créé en 2001 par
des experts de développement logiciel

• Il documente les valeurs et principes du

développement agile de logiciels

Valeurs du Manifeste Agile
Manifeste pour le développement agile de logiciels

Nous découvrons comment mieux développer des logiciels par la pratique et en aidant les
autres à le faire. Ces expériences nous ont amenés à valoriser :

• Les individus et leurs interactions

plus que les processus et les outils

• Des logiciels opérationnels

plus qu’une documentation exhaustive

• La collaboration avec les clients

plus que la négociation contractuelle

• L’adaptation au changement

plus que le suivi d’un plan

Nous reconnaissons la valeur des éléments à droite, mais privilégions ceux à gauche.

10

Principes du Manifeste Agile

1. Notre plus haute priorité est de satisfaire le client en livrant rapidement et régulièrement des fonctionnalités à grande valeur ajoutée.

2. Accueillez positivement les changements de besoins, même tard dans le projet.

Les processus Agiles exploitent le changement pour donner un avantage compétitif au client.

3. Livrez fréquemment un logiciel opérationnel avec des cycles de quelques semaines à quelques mois et une préférence pour les plus courts.

4. Les utilisateurs ou leurs représentants et les développeurs doivent travailler ensemble quotidiennement tout au long du projet.

5. Réalisez les projets avec des personnes motivées.

Fournissez-leur l’environnement et le soutien dont ils ont besoin et faites-leur confiance pour atteindre les objectifs fixés.

6. La méthode la plus simple et la plus efficace pour transmettre de l’information à l'équipe de développement et à l’intérieur de celle-ci est le

dialogue en face à face.

7. Un logiciel opérationnel est la principale mesure d’avancement.

8. Les processus Agiles encouragent un rythme de développement soutenable.

Ensemble, les commanditaires, les développeurs et les utilisateurs devraient être capables de maintenir indéfiniment un rythme constant.

9. Une attention continue à l'excellence technique et à une bonne conception renforce l’Agilité.

10. La simplicité – c’est-à-dire l’art de minimiser la quantité de travail inutile – est essentielle.

11. Les meilleures architectures, spécifications et conceptions émergent d'équipes autoorganisées.

12. À intervalles réguliers, l'équipe réfléchit aux moyens de devenir plus efficace, puis règle et modifie son comportement en conséquence.

11

Méthodes agiles

Différentes philosophies
et méthodes ont été
développées qui
incorporent cette vision

Une méthodologie
de gestion de
projets

Lean

Agile

Kanban

SCRUM

AUP

FDD

Crystal

XP

Une philosophie:
optimiser la
production

Méthodes et outils

Agile development
- John Ousterhout

• The best way to end up with a good design is to develop a system in increments, where
each increment adds a few new abstractions and refactors existing abstractions
based on experience

• Agile development tends to focus developers on features, not abstractions, and it

encourages developers to put off design decisions in order to produce working software
as soon as possible.

• One of the risks of agile development is that it can lead to tactical programming.

• This can result in a rapid accumulation of complexity.

• Developing incrementally is generally a good idea, but the increments of

development should be abstractions, not features.

13

Extreme Programming (XP):

Méthode de développement

14

eXtreme Programming

• XP a été développé par Kent Beck (1998) lors du développement d’un projet de très

grande envergure

• Il s’agit d’une culture et d’un ensemble de bonnes pratiques de développement

logiciel

• «Extrême», comme il pousse ces bonnes pratiques à un niveau extrême

Application pratique

• XP contient beaucoup de pratiques qui sont utiles et largement utilisées

• La méthodologie complète est difficile à appliquer et intégrer dans une entreprise

17

Extreme Programming
En quoi XP se distingue ?

• Cycles de développement court, pour obtenir du feedback rapide, concret et

continu

• Planification progressive, avec un plan global qui évolue tout au long du

projet

• Planification flexible, en réponse aux besoins changeants de l'entreprise.

• Tests automatisés rédigés par programmeurs, clients et testeurs pour

surveiller l'avancement, permettre au système d'évoluer et détecter tôt les
erreurs

18

Extreme Programming
Valeurs, Principes et Pratiques

• Valeurs: état d’esprit du développeur déterminé à atteindre un but commun

• Principe: reflet concret des valeurs dans le comportement du développeur

• Pratiques: ensemble de pratiques dérivées des valeurs et des principes

19

XP: Les valeurs

Simplicité
Communication
Feedback
Courage
Respect

http://www.extremeprogramming.org/values.html

20

Valeurs
1. Simplicité

• Nous faisons ce qui est nécessaire et demandé, mais pas plus, afin de

maximiser la valeur créée pour l'investissement.

• Nous prenons de petites mesures simples pour atteindre notre objectif et nous

atténuons les échecs au fur et à mesure qu'ils se produisent.

• Nous créons quelque chose dont nous sommes fiers et nous le maintenons à

long terme à des coûts raisonnables.

21

Valeurs
2. Communication

• Tout le monde fait partie de l'équipe et nous communiquons en face à face au

quotidien.

• Nous travaillons ensemble sur tout, de la définition des besoins à

l’implémentation.

• Nous créons ensemble et dans la mesure de nos capacités la meilleure

solution pour notre problème.

22

Valeurs
3. Feedback

• Nous prenons chaque engagement d'itération au sérieux et fournissons un

logiciel fonctionnel.

• Nous faisons une démonstration précoce de notre logiciel, nous écoutons
attentivement les feedbacks et apportons les modifications nécessaires.

• Nous parlons du projet et adaptons nos processus à celui-ci, et non l'inverse.

23

Valeurs
4. Respect

• Chacun donne et ressent le respect qu'il mérite en tant que membre précieux

de l'équipe.

• Tout le monde apporte de la valeur, même s'il s'agit simplement

d'enthousiasme.

• Les développeurs respectent l'expertise des clients et vice versa.

• La direction respecte notre droit de recevoir de l’autorité sur notre propre

travail et d’en accepter la responsabilité.

24

Valeurs
5. Courage

• Nous disons la vérité sur les progrès et les estimations.

• Nous ne documentons pas les excuses de l'échec parce que nous prévoyons

de réussir.

• Nous n'avons peur de rien car personne ne travaille jamais seul.

• Nous nous adaptons aux changements quand ils se produisent.

25

XP: Les principes

Humanité
Economie
Bénéfice mutuel
Auto-similarité
Amélioration
Réflection
Responsabilité acceptée

Flux
Opportunité
Redondance
Echec
Qualité
Petit pas

26

Principes
Humanité

• De quoi les gens ont-ils besoin pour être de bons développeurs?

• Sécurité matérielle - La peur de perdre son emploi menace ce besoin

• Accomplissement - l'occasion et la capacité de contribuer à la société

• Appartenance - capacité à s'identifier à un groupe dont ils reçoivent validation et

responsabilité et à contribuer à ses objectifs communs

• Croissance - la possibilité d'élargir leurs compétences et leur perspective

• Intimité - la capacité de comprendre et d'être compris en profondeur

• D’autres besoins humains (repos, exercice, socialisation) ne doivent pas nécessairement

êtres satisfaits au travail. Limiter les heures de travail permet de les remplir

27

Principes
Economie

• Quelqu’un paie pour le projet

• Il faut prioriser les développements en fonction de la valeur qu’ils créent

• Valeur temps de l’argent - un franc dépensé aujourd’hui coûte plus cher qu’un

franc dépensé demain

• Valeur d’option -  la possibilité de ré-utiliser le code / les compétences de

l’équipe ajoute de la valeur au projet

28

Principes
Bénéfice mutuel

• Documenter mon code maintenant bénéficiera sans doute à quelqu’un plus

tard. Mais cela ne m’apporte pas de bénéfice maintenant.

• Ecrire des tests automatisés, refactorer mon code, choisir des noms explicites
bénéficient tant au développeur aujourd’hui qu’au lecteur du code demain.
Ces pratiques offrent un bénéfice mutuel.

29

Principes
auto-similarité

• Les mêmes solutions peuvent

s’appliquer à plusieurs échelles,
de temps par exemple

30

Principes
Amélioration

• In software development, “perfect” is a verb, not an adjective

• Il n’y a pas de processus parfait, pas de conception parfaite, pas d’histoires

parfaites, mais on peut les améliorer

31

Principes
Et encore…

• Réflexion - comment et pourquoi fais-je cela ainsi ?

• Flux - par opposition aux grandes étapes

• Opportunité - un problème est une chance d’apprendre et de s’améliorer

• Redondance - si programmer par paire ne détecte pas un bug, un test

unitaire peut le faire, ou un test d’intégration, ou …

32

Principes
Et encore…

• Echec - si vous hésitez entre deux solutions, mettez les toutes les deux en

oeuvre. Même si elles échouent, vous aurez appris quelque chose

• Qualité - elle ne ralentit pas le développement, au contraire

• Petit pas - quelle est le plus petit changement que l’on pourrait faire dans la

bonne direction?

• Responsabilité acceptée - celui qui prend en charge une tâche estime le
temps requis, s’occupe de la conception et prend en charge la réalisation

33

XP: Les pratiques

34

Les pratiques clés XP

Client sur site

Planification
incrémentale

Programmation
en binôme

Développement
orienté tests

Intégration
continue

Refactoring

Un représentant de l'utilisateur final du système (le Client) doit être disponible à plein temps pour
l'équipe XP. Dans un processus de programmation extrême, le client est membre de l'équipe de
développement et est responsable de l'apport des exigences du système à l'équipe pour mise en
œuvre.
Les exigences sont enregistrées sur des « story cards », et les histoires à inclure dans une
version sont déterminées par le temps disponible et leur priorité relative. Les développeurs
décomposent ces histoires en "tâches" de développement.

Les développeurs travaillent en binômes, vérifiant le travail de l'autre et fournissant le soutien
nécessaire pour toujours faire un bon travail.

Un cadre de tests unitaires automatisé est utilisé pour écrire des tests pour une nouvelle
fonctionnalité avant que cette fonctionnalité elle-même ne soit mise en œuvre.

Dès qu'une tâche est terminée, elle est intégrée dans l'ensemble du système. Après chaque
intégration, tous les tests unitaires du système doivent réussir.

Tous les développeurs sont censés refactoriser le code en continu dès que des améliorations
potentielles du code sont trouvées. Cela permet de garder le code simple et maintenable.

Propriété
collective

Les paires de développeurs travaillent sur toutes les zones du système, de sorte qu'aucune île
d'expertise ne se développe et que tous les développeurs prennent la responsabilité de tout le
code. Tout le monde peut changer n'importe quoi.

Client sur site

• Objectif : Assurer une communication directe et continue avec le client pour

clarifier les besoins et obtenir un feedback immédiat.

• Comment ça marche : Idéalement, le client (ou un représentant) est

physiquement présent avec l'équipe de développement. Il est disponible pour
répondre aux questions, clarifier les user stories et participer aux revues
d'itération.

• Illustration : Le responsable produit du client est assis avec l'équipe,

participant aux réunions quotidiennes et fournissant des clarifications sur les
fonctionnalités en cours de développement.

Planification incrémentale

• Objectif : Établir rapidement un plan de projet flexible et basé sur la valeur métier.
• Comment ça marche :

• User Stories : Le client (ou un représentant) définit les fonctionnalités souhaitées

sous forme de "user stories" courtes et compréhensibles.

• Estimation : L'équipe de développement estime l'effort nécessaire pour
implémenter chaque user story (souvent en points relatifs ou en temps).

• Priorisation : Le client priorise les user stories en fonction de leur valeur métier et

du risque.

• Itérations : Les user stories sont regroupées en itérations courtes (généralement 1
à 3 semaines). L'équipe s'engage à livrer un ensemble de stories fonctionnelles à
la fin de chaque itération

User stories (témoignages)
Planification incrémentale

• Unité de fonctionnalité visible par

l’utilisateur

• Une story peut être divisée en
tâches par le développeur

• Estimation au plus vite du coût

de mise en œuvre

• Typiquement 2 ou 3 jours de

travail

Stories

Tache

38

Organisation de l’espace de travail

39

User stories
Avantages et problèmes

Avantages

• Beaucoup plus facile à comprendre et à rédiger qu’une spécification
• Les stories peuvent être repriorisées voire écartées si les besoins changent
• D’autres stories peuvent être développées au fur et à mesure

Problèmes

• Il est difficile de juger si assez de stories ont été créées pour couvrir les

besoins essentiels

• Les besoins non fonctionnels ne sont pas définis directement

(sécurité, performance, ergonomie, …)

Programmer en binôme

• Deux programmeurs, un ordinateur, un clavier qui passe de l’un à l’autre

• Gardez-vous mutuellement concentrés sur la tâche

• Réfléchissez sur les améliorations à apporter au système

• Clarifiez les idées.

• Prenez des initiatives lorsque votre partenaire est bloqué, réduisant ainsi la frustration.

• Tenez vous mutuellement responsables des pratiques de l’équipe

• Si vous écrivez en prototype seul, ré-écrivez le en paire pour la version de production

41

The Friendship
That Made Google
Huge
Coding together at the same
computer, Jeff Dean and Sanjay
Ghemawat changed the course
of the company—and the
Internet.

https://www.newyorker.com/magazine/2018/12/10/the-friendship-that-
made-google-huge

42

Test-first programming

Problématique

• Contrairement aux processus planifiés, il n’y a pas de spécification qui
permet de définir les tests (unités, système, intégration, utilisateurs)

Test-first programming

• Les tests sont développés avant la fonctionnalité

• Les tests découlent des user stories et des tâches y associées

• Le client peut contribuer à définir des tests d’acceptation

• L’automatisation des tests est essentielle

43

Test-first programming

Ecrire un test qui échoue avant de changer le code adresse plusieurs
problèmes …

• Scope Creep - Il est facile de se laisser entraîner par la programmation et

de mettre du code «au cas où».

• Couplage et cohésion - si écrire un test est difficile, c’est le signe que
vous avez un problème de conception, pas un problème de test.

• Confiance - les tests expriment l’intention et prouvent la validité

• Rythme - structure l’activité de programmation et évite de s’y perdre

44

Intégration continue

• Objectif : Intégrer fréquemment les modifications de code de tous les

membres de l'équipe pour détecter rapidement les problèmes.

• Comment ça marche : Les développeurs intègrent leur code dans un dépôt

partagé plusieurs fois par jour.
Chaque intégration est automatiquement construite et testée.
Les problèmes d'intégration sont identifiés et corrigés rapidement.

• Illustration : Chaque fois qu'un développeur pousse son code, un serveur de
CI lance automatiquement la compilation du projet et exécute tous les tests. Si
un test échoue, l'équipe est immédiatement notifiée.

45

Intégration continue

• Développer en équipe, ce n’est pas « divide
and conquer », c’est « divide, conquer and
integrate »

• Plus on attend pour intégrer, plus intégrer

sera cher et imprévisible

• Intégrer plusieurs fois par jour, sur la base de

tests automatiques qui passent

46

Intégration continue
Builder en 10 minutes

• Compiler et faire tourner automatiquement tous les tests en 10 minutes

• Plus long, les développeurs éviteront de builder

• Plus court, pas le temps de prendre un café…

47

Refactoring

Problématique

• Les méthodes traditionnelles préconisent une conception flexible qui peut

s’adapter aux changements des besoins

• Cette généralisation du code ajoute de la complexité

• L’effort est souvent perdu, comme il est difficile d’anticiper les changements

Refactoring

• On garde le code simple et focalisé sur la fonctionnalité à implémenter (YAGNI)

• On vise plutôt une amélioration continue du code

• Le refactoring représente une partie importante du travail de quotidien

48

Refactoring
• Objectif : Améliorer continuellement la structure interne du code sans en modifier le

comportement externe.

• Comment ça marche :

• Supprimer le code dupliqué.

• Améliorer la clarté et la lisibilité du code.

• Simplifier les structures complexes.

• Effectuée en petites étapes, avec des tests unitaires pour garantir que rien n'est cassé.

• Illustration : Après avoir implémenté plusieurs fonctionnalités, l'équipe remarque une
duplication de code dans différentes classes. Ils refactorisent le code pour extraire la
logique commune dans une nouvelle classe, rendant le code plus maintenable.

49

Organisation du processus XP
Vue simplifiée de XP

Illustration: Ian Sommerville,
Software Engineering 10th edition, chap. 3

50

Organisation du processus XP
Cycle hebdomadaire

• Planifier le travail une semaine à la fois. Commencer par une réunion où l’on :

• Examine les progrès réalisés comparés aux progrès attendus.

• Demande aux clients de choisir les histoires à mettre en œuvre

• Divise les stories en tâches, se porter volontaire, les estimer.

• Commencer la semaine en écrivant des tests automatisés qui seront exécutés une

fois les histoires terminées.

• Passez le reste de la semaine à terminer les histoires et à réussir les tests.

• Objectif : avoir un logiciel déployable à la fin de la semaine

51

Organisation du processus XP
Cycle trimestriel

• Une fois par trimestre, réfléchir sur l'équipe, le projet, ses progrès et son

alignement sur des objectifs plus vastes

• Identifier les goulots d'étranglement, en particulier ceux contrôlés en dehors

de l'équipe

• Commencer les réparations

• Planifier le ou les thèmes du trimestre

• Créer des Stories pour aborder ces thèmes

52

SCRUM:

Méthode de gestion de projet

53

54

Limitations de XP
Et le manager?

• XP est très centré sur le développeur

• Ses valeurs

• Ses principes

• Ses pratiques

• La responsabilité des managers est peu discutée

• La responsabilité du manager est de s’assurer que le projet sera délivré dans

les temps et dans les limites du budget

55

SCRUM
Une approche de gestion

• SCRUM est une méthode agile légère qui se focalise sur la gestion d’un

processus de développement itératif sans spécifier les pratiques qui
l’accompagne

• Un projet SCRUM peut être composé de trois phases

• La phase initiale est une phase de planification générale pour définir les

objectifs généraux du projet et concevoir l'architecture logicielle.

• La phase initiale est suivie d'une série de sprints correspondant aux

incréments du système.

• La phase de clôture permet de compléter la documentation, les manuels

d’utilisation et de tirer des leçons du projet.

56

Scrum
Cycle de développement

Illustration: Ian Sommerville,
Software Engineering 10th edition, chap. 3

57

Scrum team

• Une Scrum team est une petite équipe d’au maximum 10 personnes

• L’équipe doit être suffisamment grande pour accomplir un travail significatif

pendant un sprint

• Elle doit couvrir toutes les compétences nécessaires

• L’équipe est responsable de toutes les activités liées au produit:

(planification, développement, communication avec les parties prenantes, …)

• Elle comprend 3 rôles

• Développeurs
• Product owner
• Scrum Master

Scrum team
Développeurs

• Les développeurs sont redevables de:

• Créer un plan du Sprint et le Sprint backlog

• Adapter leur plan chaque jour par rapport à l’Objectif de Sprint

• Se tenir mutuellement responsables en tant que professionnels

• Les développeurs peuvent réunir différentes compétences

(architecte, designer, programmeur, …)

Scrum team
Product Owner

• Chaque équipe a un Product owner, qui est une seule personne et non pas un comité
• Le Product owner se focalise sur le côté business du projet
• Il interagit avec les parties prenantes et représente leurs besoins envers l’équipe Scrum

• Le Product owner est redevable de maximiser la valeur du produit créé par l’équipe:

• Il formule l’Objectif du produit
• Il gère le Backlog: crée et priorise les éléments.
• Il communique le Backlog à l’équipe
• Il peut effectuer les tâches de gestion de projet typiques (gouvernance, budget, risques,

communication)

Scrum team
Scrum Master

• Le Scrum master est redevable de la mise en place de la méthode Scrum et de l’efficacité de l’équipe
• Contrairement à un chef de projet, il n’a pas de responsabilité sur les ressources humaines

•

•

•

Il coach l’équipe sur la théorie et pratique de Scrum

Il rend service à l’équipe SCRUM
•
•
•
•

Il aide l’équipe à définir des incréments qui apportent une grande valeur

Il protège également l’équipe des interférences externes

Il s’assure que les événements Scrum ont lieu et sont efficients et productifs

Il rend service au Product owner
•

Il l’aide à trouver des techniques pour définir l’Objectif du produit et gérer le Backlog

Il rend service à l’organisation
•

Il l’aide à adopter la méthode Scrum (éducation, accompagnement, planification et implémentation de Scrum)

Sprint

• Les sprints sont au cœur de Scrum

• Evénements d’une durée fixe (1-4 semaines, le plus souvent 2 semaines)

• Un nouveau Sprint commence directement à la fin du précédent

• Le but d’un sprint est le développement d’un incrément, idéalement une

version fonctionnelle du produit

Evénements d’un sprint

1. Sprint Planning

• Définition de l’Objectif du sprint:

pourquoi ce sprint est-il important?

https://commons.wikimedia.org/wiki/File:Scrum_Agile_events.png

• En discussion entre l’équipe et le Product owner, sélection les éléments du

Backlog

• Affinement des éléments sélectionnés et définition des critères d’acceptation

(«done»)

• Planification du travail à faire en décomposant les éléments du Backlog en

éléments de travail d’une journée ou moins

Evénements d’un sprint

2. Daily Scrum

• Evénement de 15 minutes des développeurs

https://commons.wikimedia.org/wiki/File:Scrum_Agile_events.png

• Sert à communiquer le progrès et discuter les obstacles

• Le résultat est un plan d’action pour la prochaine journée de travail

• Si nécessaire, des développeurs peuvent organiser des séances séparées

après le Daily ou pendant la journée pour des discussion plus longues

Evénements d’un sprint

3. Sprint review

• A la fin de chaque sprint

• L’équipe présente le progrès aux parties prenantes

https://commons.wikimedia.org/wiki/File:Scrum_Agile_events.png

• La présentation est suivie par le travail collaboratif sur la marche à suivre, les décisions à

prendre et l’adaptation du Backlog

• Affinement des éléments sélectionnés et définition des critères d’acceptation («done»)

• Planification du travail à faire en décomposant les éléments du Backlog en éléments de

travail d’une journée ou moins

Evénements d’un sprint

4. Sprint rétrospective

• Séance séparée de l’équipe Scrum

• La rétrospective conclut le sprint

https://commons.wikimedia.org/wiki/File:Scrum_Agile_events.png

• Réflexion sur les pistes d’amélioration de la qualité et de l’efficacité:

• Qu’est-ce qui a bien fonctionné?

• Quels ont été les problèmes rencontrés?

• Comment peut-on résoudre ces problèmes?

Artefacts de Scrum
Product Backlog

• Liste ordonnée de ce qui est nécessaire pour améliorer le produit

(features, besoins non fonctionnels, corrections de bugs)

• Souvent exprimés comme user stories ou use cases

• Les éléments sont progressivement affinés en éléments plus fins et plus

précis

• Le Product Backlog est géré par le Product owner

• Les développeurs sont responsable du dimensionnement: estimation de

l’effort nécessaire

Artefacts de Scrum
Sprint Backlog

• «Pourquoi», «Quoi» et «Comment» du Sprint actuel

• Définition de l’objectif du sprint
• L’ensemble des éléments du Backlog à réaliser
• Plan d’action pour la réalisation de l’incrément

• Le Sprint Backlog est élaboré par les développeurs

• Les développeurs s’autoorganisent pour réaliser les tâches

• Si le travail nécessaire s’avère être différent de la planification, les

développeurs négocient le périmètre du sprint avec le Product owner

Artefacts de Scrum
Incrément

• Résultat du sprint qui correspond à l’objectif fixe

• Idéalement une nouvelle version utilisable du logiciel, intégré avec les

incréments précédents

• Doit satisfaire la «Définition de Fini»

• Description formelle des critères d’acceptation pour tous les incréments

• Par exemple tests à passer, contraintes non fonctinonnelles à respecter,

documentation, …

Méthodologies agiles
Personas - Stories

70

Agile
Personas

• Personnages de

fiction représentant
les utilisateurs ou
d’autres intervenants

• Les personas sont

partagés, visibles, et
utilisés dans les user
stories.

71

Agile
User stories

• Description courte d’une fonctionnalité, décrite du point de vue de l’utilisateur /

du client. Typiquement selon le template:

En tant que < un type d’utilisateur >,
Je veux < un but >
pour que < une raison >.

• Les « user stories » doivent tenir sur une carte / un post-it que l’on peut

déplacer sur le mur / tableau lors des réunions de planification

72

Agile
User stories

• Les histoires les plus générales sont appelées « epic », par exemple

En tant qu’utilisateur, je peux backuper mon disque dur pour ne pas
perdre de données

• Les épiques peuvent êtres divisées en sous-histoires, par exemple

En tant que power user, je peux spécifier les fichiers et répertoires à
backuper en fonction de leur taille, dates de création et de
modification

73

Agile
User stories

• La spécification n’est pas complète sur papier.

• Elle est complétée par les discussions entre développeurs et product owner

lors des séances de planification de sprint et les séances journalières.

74

Outils

75

Tableau Kanban

• Tableau pour visualiser le progrès du travail

• Selon le processus, on utilise typiquement

des colonnes comme
Backlog, Doing, Review, Done

• L’objectif est d’assurer le flux continue entre
les colonnes et faire progresser les tâches
rapidement

Burndown chart

• Représentation graphique de la quantité de

travail restant par rapport au temps disponible

• Souvent utilisé dans les itérations Scrum

• Si la ligne du travail restant est en-dessous de
la ligne idéale, l’équipe est en avance par
rapport à la planification

• Ceci permet aussi de donner un feedback
pour l’estimation du  volume de travail de
chaque itération

https://commons.wikimedia.org/wiki/File:SampleBurndownChart.svg

Github projects

• GitHub Projects permet de gérer un

backlog

• Le backlog peut être visualisé par

différentes vues

• Kanban

• Roadmap

• Tableau, …

Questions?

80


