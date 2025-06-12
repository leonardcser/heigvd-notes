Design Patterns

Bertil Chapuis, Olivier Cuisenaire

1

2

Design Patterns
Qu’est-ce que c’est ?

• Idée originale de Christopher
Wolfgang Alexander (Autriche)

• A l’origine, appliquée à l’architecture
des constructions et des villes, pas à
la programmation

3

Each pattern describes a problem which occurs over and
over again in our environment, and then describes the
core of the solution to that problem, in such a way that
you can use this solution a million times over, without
ever doing it the same way twice.

Christophe Alexander, 1977

4

Design Patterns
Gang of Four

• Les quatre auteurs appliquent ce concept à la
programmation orientée objet en C++, en
considérant 4 éléments pour chaque modèle

• Nom - permet d’utiliser un vocabulaire

commun avec vos pairs

• Problème - description de la difficulté que le

modèle permet de résoudre

• Solution - quels éléments sont requis pour

ce modèle ?

• Conséquences - quels sont les résultats et

les compromis liés à son application ?

5

Design Patterns
Catalogue de modèles

Creational

Stuctural

Tout ce qui est lié à la création des
objets.

Comment les classes et objets sont
composés pour former de plus
grandes structures.

• Singleton
• Factory
• Abstract Factory
• Builder
• Prototype

• Adapter
• Composite
• Proxy
• Fly Weight
• Bridge
• Decorator

Behavioral

Algorithmes et partage des
responsabilité entre objets.

• Template Method
• Mediator
• Chain of responsability
• Observer
• Strategy
• Command
• State
• Visitor
•
Iterator
•
Interpreter
• Memento

Visitor Pattern

7

Problème
Ajout de comportements

• Ajouter de nouvelles opérations à
l’interface Geometry nécessite de
modifier toutes les classes qui
l’implémentent.

• Certaines opérations de l’interface

Geometry ne font pas nécessairement
de sens dans les classes qui
l’implémentent.

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

Solution
Design Pattern Visitor

Un motif de conception qui permet d’accueillir
des visiteurs dans les classes d’un modèle de
domaine.

• Le visiteur encapsule une opération à

effectuer sur les éléments d'une structure
d’objets.

• Il permet de définir une nouvelle opération sans
changer les classes des éléments sur lesquels
il opère.

• Il permet d’éviter la multiplication

d’opérations “polluantes” au sein du modèle de
domaine.

Comportement

Domaine

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

+ area(): double
+ centroid(): Point
+ envelope(): Rectangle

Toutes les géométries
n’ont pas de surface

Exercice
Implémenter le design pattern Visitor

• Sur la base du diagramme de classe et du diagramme de séquence,

implémenter le design pattern Visitor en Java.

• Identifiez où interviennent le polymorphisme et la liaison dynamique.

• Quelle fonctionnalité disponible en Java 21 permet de remplacer le design

pattern Visitor?

Questions
Combien de classes dois-je modifier?

• Lorsque j’ajouter une opération WidthCalculator?

• Lorsque j’ajoute une classe Polygon?

A design pattern is a commonly used approach for solving a particular kind
of problem, such as an iterator or an observer. Design patterns represent
an alternative to design: rather than designing a new mechanism from
scratch, just apply a well-known design pattern. For the most part, this is
good: design patterns arose because they solve common problems, and
because they are generally agreed to provide clean solutions. The greatest
risk with design patterns is over-application. Not every problem can be
solved cleanly with an existing design pattern; don’t try to force a problem
into a design pattern when a custom approach will be cleaner.

Ousterhout, John.
A Philosophy of Software Design (p. 156).
Yaknyam Press, Palo Alto, CA. Kindle Edition.

Design Patterns
Conclusions

• Pour aller plus loin… lisez le livre! ;-)

• C’est un classique que tout interviewer
s’attend à ce que vous connaissiez.

… mais …

• Design patterns considered harmful …

• Danger de sur-conception (Keep It

Simple Stupid)

• Parfois rendus obsolètes par les
langages de programmation
modernes

20


