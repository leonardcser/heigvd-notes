Testing and Refactoring

Bertil Chapuis, Olivier Cuisenaire, Juergen Ehrensberger

1

Références

https://martinfowler.com/articles/workflowsOfRefactoring/

Test Driven Development (TDD)

3

TDD
Le processus de base

https://martinfowler.com/articles/workflowsOfRefactoring/#tdd

4

Etape 1: ajouter un test
Specification by example

• Dans un processus itératif le développeur ne dispose pas d’une

spécification qui guide le développement

• Les tests peuvent servir de «spécification exécutable»

On définit le comportement attendu deux fois: dans les tests et dans
l’implémentation

• Avantages

• Typiquement mieux compréhensible qu’une spécification

• Les tests guident la conception des interface et de l’implémentation

Etape 1: ajouter un test
Specification by example

• Java Math.pow method

Etape 1: ajouter un test
Specification by example

• Java Math.pow method

Etape 1: ajouter un test
Specification by example

• Java Math.pow method

Etapes 1: ajouter un test
Liste des tests

• Traiter une seule fonctionnalité à la fois
• Lister toutes les variantes du comportement attendu:

• La méthode retourne la personne recherchée si elle existe dans la DB
• La méthode retourne null si la personne n’existe pas
• La méthode produit une exception si la DB ne répond pas dans les x secondes
• …

• Ensuite, traiter un cas à la fois: implémenter le test et la fonctionnalité

Etapes 2 et 3: Green, then Refactor
Deux étapes séparées

• Make it Green

•

Implémenter la fonctionnalité
nécessaire de manière simple et
rudimentaire

• Refactor

• Rendre le code propre

TDD
On ne peut porter qu’un seul chapeau à la fois

Refactoring
Lors du refactoring, chaque modification que
vous effectuez est un petit changement qui
préserve le comportement. Vous ne
refactorisez qu'avec des tests réussis, et tout
test échouant indique une erreur. En
enchaînant une série de petits changements
de cette manière, vous pouvez progresser
plus rapidement et avec moins de risques, car
vous ne devriez pas vous retrouver contraint
de déboguer.

Ajouter une fonctionnalité
Toute autre modification du code revient à
ajouter une fonctionnalité. Vous ajouterez
de nouveaux tests et casserez les tests
existants. Vous n'êtes pas limité aux
changements qui préservent le
comportement (mais il est judicieux de
maintenir les changements petits et de
revenir rapidement à des tests réussis).

https://martinfowler.com/articles/workflowsOfRefactoring/#tdd

11

Testing

12

Testing
Une vue de haut niveau

- System under test (SUT):

Le système testé.

- Dépendance : Une classe utilisée

par le système testé.

- Unit test : Un test qui vérifie le

-

comportement de petites unités de
manière isolée et rapide.
Integration test : Un test qui vérifie
le comportement de composants
assemblés les uns avec les autres.
- End-to-end test : Un test qui vérifie
le comportement du système en
conditions (presque) réelles.

Testing
La pyramide des tests

Tests de
bout en bout

Tests d’intégration

Tests unitaires

- Les tests unitaires devraient être
nombreux car ils sont faciles à
implémenter et rapides à exécuter.

- Les tests d’intégration sont

généralement moins nombreux car
difficiles à implémenter et un peu
plus lent à exécuter.

- Les tests de bout en bout sont
souvent peu nombreux car très
difficiles à implémenter et
exécuter.

Testing
Qu’est-ce qu’un test unitaire?

Un test unitaire est un test automatisé qui :

1. Vérifie un petit morceau de code (appelé unité),

2. S'exécute rapidement,

3. S'exécute de manière isolée (ne se base pas sur l’état créé par un autre test)

Les notions d’unité et d’isolation sont souvent interprétées de manières différentes:

- Classical School : Une unité testée est une unité de comportement et non une unité de code ; les tests unitaires
doivent être isolés les uns des autres; Il est permis d’utiliser de vraies dépendances dans les tests unitaires.

-

London School : Une unité testée est une unité de code correspondant généralement une classe ou une
méthode ; Les classes testées doivent être isolées les unes des autres; Un test qui ne simule pas les
dépendances du système testé est un test d’intégration.

Mon avis: J’ai écrit 12 tests pendant que les autres débattaient ;-)

Testing
Pourquoi écrire des tests unitaires?

But principal : Assurer une croissance durable du projet logiciel.
Effet secondaire : Peut améliorer la conception du code.
Qualité du Code et Tests Unitaires
•
•

Indicateur négatif : Code difficile à tester = mauvaise qualité (couplage fort).
Indicateur positif : Code facile à tester ≠ bonne qualité garantie.

Croissance du Projet
• Sans tests : Démarrage rapide, ralentissement à cause de

l’entropie (désordre croissant).

• Avec tests : Démarrage moins rapide, maintien de

la fonctionnalité, stabilité et fiabilité accrues, même avec des
changements et des nouvelles fonctionnalités.

Testing
Comment écrire un test unitaire avec le pattern AAA?

Le pattern AAA préconise de structurer les tests en trois parties :
- Arrange :  Arranger et amener le système testé et ses dépendances à l’état souhaité.
- Act :
- Assert :  Vérifier les valeurs de sortie, l’état final du système testé.

Appeler les méthodes du système testé et capturer les valeurs de sortie.

Quelques bonnes pratiques à considérer lors de l’écriture des tests :

- Un test devrait généralement être une simple séquence d'étapes sans branchement ou boucle.

-

-

Il est préférable de ne pas partager des parties entre tests pour éviter un couplage fort et conserver une bonne
lisibilité des tests. Lorsque c’est nécessaire on utilise des méthodes de création d’objet.

La longueur de chaque partie peut varier en fonction de la nature du test.
Une section Act longue indique néanmoins une mauvaise encapsulation des opérations.

- Au lieu de mettre plusieurs sections Act dans le même test, il est préférable de créer un nouveau test.

-

-

Les noms des tests devraient être expressif et décrire le scenario testé.

Il est bien d’établir une convention de nommage, mais il faut rester flexible.

Testing
Comment isoler le système testé?

On isole le système testé en remplaçant les
dépendances par des doubles de test.

Quelques avantages:
- La granularité des tests est plus fine.
-

Il est plus facile de savoir quelle partie du
système échoue.

- Le graph d’objet est plus simple, moins

profond, et ne contient pas de dépendances
circulaires.

- Une dépendance simulée est généralement

plus rapide qu’une vraie dépendance.

Testing
Comment simuler les dépendances ?

Les mocks et les stubs sont des objets simulés utilisés dans des tests
unitaires.

• Un mock vérifie les interactions entre objets, y compris les appels et
paramètres. Il est utilisé pour valider des comportements spécifiques.

• Un stub fournit des réponses prédéfinies pour isoler le code à tester.

Il est utilisé pour tester sans dépendances externes.

Testcontainers
Simplifier les tests d’intégration et le mocking

Testcontainers est un système qui créé des instances de dépendances
externes à la demande

• Bases de données, bus de communication, serveurs Web, autres

serveurs (authentification, stockage, …)

Testcontainers
Exemple: créer une DB de test (Python)

from testcontainers.postgres import PostgresContainer

from sqlalchemy import create_engine, text

def fill_db(engine):

# ... Remplir la DB

with PostgresContainer("postgres:16") as postgres:

psql_url = postgres.get_connection_url()

engine = create_engine(psql_url)

fill_db(engine)

with engine.begin() as connection:

result = connection.execute(text("SELECT * from people")).fetchall()

print(result)

Démarrer un container
Docker avec PostgreSQL

Testcontainers
https://www.youtube.com/watch?v=-q7hLU2e2h4

Refactoring

24

Refactoring
Quand ?

• TDD refactoring:( Red - Green - Refactor )

• Litter-pickup: le nettoyage simple

• Comprehension refactoring: améliorer l’organisation et le rangement

• Preparatory refactoring: avant l’arrivée d’une nouvelle fonctionalité

• Planned refactoring: améliorer l’hygiene du code

• Long-term refactoring: l’investissement à long terme

https://martinfowler.com/articles/workflowsOfRefactoring/

25

Refactoring
Pourquoi ?

26

27

https://refactoring.com/catalog/

https://sourcemaking.com/refactoring

28

Code Smells
and anti-patterns

Bloaters
Long Method
Large Class
Primitive Obsession
Long Parameter List
Data Clumps

Object-Orientation
Abusers
incomplete or
incorrect application
of object-oriented
programming
principles.

Change Preventers
if you need to change
something in one
place in your code,
you have to make
many changes in
other places too.

Dispensables
Comments
Duplicate Code
Lazy Class
Data Class
Dead Code

https://sourcemaking.com/refactoring

29

Exemples de refactoring
Remplacer un chiffre magique par une constante symbolique

double potentialEnergy(double mass,

static final double GRAVITATION_CONST =

double height) {

9.81;

return mass * height * 9.81;

}

double potentialEnergy(double mass,

return mass * height * GRAVITATION_CONST;

double height) {

}

https://sourcemaking.com/refactoring

Exemples de refactoring
Reformuler des conditions complexes

if (date.before(SUMMER_START) ||
date.after(SUMMER_END)) {

charge = quantity * winterRate +

winterServiceCharge;

}
else {

charge = quantity * summerRate;

}

if (isSummer(date)) {

charge = summerCharge(quantity);

}
else {

charge = winterCharge(quantity);

}

https://sourcemaking.com/refactoring

Exemples de refactoring
Remplacer des listes de paramètres par un objet

https://sourcemaking.com/refactoring

Exemples de refactoring
Remplacer des constructeurs complexes par un Builder

public class Nutrition {

private final int servingSize; // required
private final int servings;    // required
private final int calories;    // optional
private final int fat;         // optional
private final int sodium;      // optional
private final int carbohydrate;// optional

public Nutrition(int servingSize, int servings,

int calories, int fat, int sodium,
int carbohydrate) {

this.servingSize = servingSize;
this.servings = servings;
this.calories = calories;
this.fat = fat;
this.sodium = sodium;
this.carbohydrate = carbohydrate;

} }

// Constructeurs
public Nutrition(int servingSize, int servings) {

this(servingSize, servings, 0, 0, 0, 0);

}

public class Nutrition {

private final int servingSize;
// ... autres attributs

public static class Builder {

public Builder(int servingSize, int servings) { … }
public Builder calories(int val) {

calories = val; return this; }

public Nutrition build() {

return new Nutrition(this); }

}
private Nutrition(Builder builder) {…}

}
...

public Nutrition(int servingSize, int servings, int calories) {

this(servingSize, servings, calories, 0, 0, 0);

}

… // tous les autres constructeurs

// Utiliser le builder
Nutrition cocaCola = new Nutrition.Builder(240, 8)

.calories(100).sodium(35).carbohydrate(27).build();

Effective Java (Joshua Bloch)


