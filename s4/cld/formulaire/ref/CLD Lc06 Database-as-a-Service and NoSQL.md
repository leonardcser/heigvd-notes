Cloud Computing —
Database-as-a-Service and NoSQL

Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Which database to store my data?

PostgreSQL

Azure
SQL Database

Azure
Cosmos DB

2

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

How to make also the database scale?

HTTP

HTTP

VM

App
replica

App
replica

App
replica

read requests
write requests

VM

Database
software

Root
volume

Data volume

Users

Load balancer

App replicas

Database

3

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

What do we need to scale, exactly?

Dimensions in which a database may need to scale:

■ Storage capacity

■ Number of objects stored

■ Search engine: metadata of 2B pages of the world-wide-web

■ Social networks: user proﬁles of 1B users

■ Behavior tracking

■ Internet of Things

■ Read request throughput capacity

■ Number of read requests per second

■ E-commerce

■ Online games: up to 100k reads per second

■ Write request throughput capacity

■ Number of write requests per second

■ Online games: up to 100k writes per second

■ Internet of Things: up to 1M writes per second

4

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Let’s try vertical scaling

Server

Database software

Operating System

CPU

memory

network
adapter

OS & apps

data

Server

Database software

Operating System

CPU

memory

network
adapter

OS & apps

5

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

data

data

data

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Scaling a database vertically

■ We can scale a database vertically and use a more powerful server:

■ More CPU cores

■ More memory

■ More disks

■ Advantage: easy to do in the cloud, just change the type of VM and add more data volumes.

■ Disadvantage: costs increase more than linearly.

■ Example: AWS RDS MySQL

1 x db.m6g.xlarge (4 vCPU, 16 GiB memory): $222/month
1 x db.x2iedn.32xlarge (128 vCPU, 4096 GiB memory): $51’900/month, i.e. the same cost as 234 x
db.m6g.xlarge instances with 936 total vCPU

■ Can we scale a database horizontally instead? How can we distribute a database over several

machines?

■ This is much harder than scaling a stateless app, because a database is inherently stateful.

6

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Scaling a database horizontally

There are two common ways to distribute the
data of a database over several machines:

1. Replication: Keeping a copy of the same

data on several diﬀerent nodes, potentially in
diﬀer‐ ent locations. Replication provides
redundancy: if some nodes are unavailable,
the data can still be served from the
remaining nodes. Replication can also help
improve performance.

2. Partitioning/sharding: Splitting a big
database into smaller subsets called
partitions so that diﬀerent partitions can be
assigned to diﬀerent nodes (also known as
shards). Partitioning can also help improve
performance.

7

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Database replication

Single-leader replication

Write request
update users
set picture_url = ‘me-new.jpg’
where user_id = 1234

Data change
table:       users
primary key: 1234
column:      picture_url
old value:   me_old.jpg
new value:   me_new.jpg
transaction: 987654321

Read request
select * from users
where user_id = 1234

Leader replica
accepts reads and writes

Replication streams

Follower replica
accepts only reads

Follower replica
accepts only reads

Follower replica
accepts only reads

App instances

8

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Database replication

Single-leader replication

■ Replication means keeping a copy of the

same database on multiple machines
(replicas) that are connected via a network.

■ If the data does not change over time, you

simply copy the data to every replica, done.
The diﬃculty lies in handling changes to the
data.

■ With single-leader replication, one of the

replicas is designated the leader. Any write
requests have to be sent to the leader.

■ The other replicas are followers. Whenever

the leader writes new data to its local
storage, it also sends the data change to all
of its followers. The followers update the
local copy of the database accordingly.

■ When an app wants to read from the

database, it can contact either the leader or
one of the followers.

■ To increase robustness, leader and followers
should be in diﬀerent availability zones.

■ Alternate terminology

■ Leader = master, primary

■ Follower = slave, secondary, read replica, hot

standby

■ Single-leader replication = master-slave

replication

9

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Database replication

Single-leader replication

■ Single-leader replication has a mostly positive

impact on database performance.

■ Database slows down a bit with

synchronous replication:

■ With synchronous replication, the leader waits

for the followers to acknowledge the data
change before it returns a positive outcome of
the write request to the application. This slows
the database down.

■ With asynchronous replication, the leader
does not wait for followers. If the leader
crashes, some data may be lost. Most
databases choose this option.

■ Signiﬁcantly higher capacity for read

requests: Read requests can be distributed
over all replicas. The capacity for read requests
scales linearly with the number of replicas.

■ Use for example DNS as request router.

Write requests

Leader replica

Request
router

Read requests

Follower replica

Follower replica

Follower replica

10

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

■ With partitioning, also known as sharding, we
break up the storage space of the database
into zones. Each zone is assigned to a diﬀerent
machine.

■ The total storage capacity of the database is
the sum of the capacities of the individual
machines.

Sylvie

Iris

Sylvie

Iris

Fred

René

Louis

Alain

Alice

Fred

René

Louis

Alain

Alice

11

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

Instead of treating the database like a
monolithic container, it is broken into
shards.

Suppose the data is organized as key-
value pairs, for example user photos
(value) identiﬁed by their name (key).

The question is how to subdivide the key
space across machines to evenly spread
the load.

instead of a
single big
container ...

... many machines

<key>

<value>

Alice

Fred

<photo of
Alice>

<photo of
Fred>

elasticity: addition of new
machines ...

...

...

… or removal of
machines

Sylvie

Iris

Sylvie

Iris

Fred

René

Louis

Alain

Alice

Fred

René

Louis

Alain

Alice

12

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

Placement of objects

■ Client requests to store or

retrieve objects are received by
request routers. They determine
which machine is responsible for
storing the object.

■ The request routers have to

make a decision very quickly

■ They cannot talk to each other,
that would take too much time.

store object with key

Alice

retrieve object with key

Alice

Request router 1

Request router 2

assign the object to
which machine?

retrieve the object from
which machine?

machines

A

B

C

D

13

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

Placement of objects — Hashing

■ A hash table distributes objects

in a table with the help of a
hashing function that is
computed from the key.

■ A good hashing function
distributes the objects
uniformly and therefore
minimizes collisions.

hash table with
4 positions

position = hash(key) mod 4

0

1

2

3

14

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

Placement of objects — Hashing

■ The same principle can be
applied to the objects to
be stored on a machine.

■ Only problem: When a
machine is added the
positions of almost all
objects change. This
would cause an
unacceptable network
traﬃc to migrate the
objects!

Alice

hash(                 )

Alice

Fred

hash(                 )

Fred

Sylvie

Alain

hash(                 )

Sylvie

hash(                 )

Alain

position = hash(key) mod 4

0

1

2

3

4

...

A B C D A B C D A B C D A B C D A B C

A B C D E A B C D E A B C D E A B C D

15

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

Placement of objects — Consistent hashing

■ Consistent hashing avoids

moving objects when machines
are added or removed.

■ The keys are mapped by the
same hash function to a hash
value, but then the hash value is
mapped to a circle.

■ The machines are also mapped

into the circle by using their name
as key.

■ The following convention is
established: An object is
assigned to the machine that
follows it in the circle (clockwise
direction).

Alice

Fred

hash(                 )

Fred

hash(                 )

Alice

Sylvie

Alain

A

B

C

D

hash(                 )

Sylvie

hash(                 )

Alain

hash(          )A

hash(          )C

hash(          )D

hash(          )B

0

232

264

296

2128

Alice

A

B

Sylvie

Fred

D

C

Alain

16

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Partitioning/sharding

Placement of objects — Consistent hashing

Initial situation

Adding a machine only aﬀects the
objects that are between the new
machine and the preceding one.

Removing a machine only aﬀects the
objects that are between the machine

Alice

A

B

Sylvie

Fred

D

Alice

A

B

Sylvie

Fred

D

objects that will
leave D

Alice

A

Fred

B

Sylvie

C

Alain

C

E

Alain

C

E

Alain

objects that will
go into E

17

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Combining partitioning/sharding and replication

When using partitioning/
sharding, as more machines
are added to the database, it
becomes more fragile: when
only one machine fails, the
whole database becomes
unavailable. The probability
that (at least) one machine
fails increases linearly.

■ Solution: Replication. Store
the same data on diﬀerent
machines, for example 3
total copies for a replication
factor of 3. This allows for 2
machines to fail.

■ In general, databases that
use partitioning/sharding
replicate the data as well.

Data
to be stored

Partitioning/
sharding

Replication
(factor 3)

Paritionining/
sharding &
replication
(factor 3)

18

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Relational (SQL) databases

■ Relational databases were invented in 1970,

became popular in the 1980s and are since the
dominating type of database. Their strong
points are:

■ Relational algebra / SQL: Allows applications
to grab the pieces of data they need through
queries. Normalization avoids redundancy.

■ Concurrency control: Many users may access
and modify the same information at the same
time. Support for transactions.

■ (Mostly) standardized: SQL is a mostly
standard language and widely used and
understood.

■ Weak point: Relational databases only scale
well vertically. Relational algebra (joins) and
concurrency control are very hard to do when
the data is distributed over several machines.

Customer

1

*

name

1

*

1

*

Billing
Address

*

Order
Payment

cardNumber
transactionId

Order

1

1

1

*

Order Item

price

*

1

Product

name

*

1

Address

street
city
state
post code

1

shipping Address

Customer

Name

Anne

Bob

Claire

Product

Name

Garden chair

Cushion

Umbrella

Order

CustomerID

Shipping
AddressId

1

3

1

77

78

79

BillingAddress

CustomerID

AddressId

1

2

3

77

78

79

Id

99

100

101

Id

55

56

57

OrderItem

Address

OrderID

ProductId

Price

99

99

100

27

29

27

49.90

12.80

49.90

Id

77

78

79

City

London

Nice

Milano

OrderPayment

OrderID

CardNumber

Billing
AddressId

TransactionId

99

100

101

1000-1000

2000-2000

3000-3000

55

56

57

45fjhs63h8

934fjh34835

7hbj53sk845

Id

1

2

3

Id

27

28

29

Id

210

211

212

Id

383

384

385

19

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases

■ In the 2000’s, new applications produced data volumes that
could no longer be stored or processed easily in relational
databases.

■ For example the Google search engine needs to index a copy of
the world wide web. The Amazon e-commerce platform needs
to store and process orders from millions of customers.

■ Google Bigtable and Amazon Dynamo are databases that
run on a cluster, are horizontally scalable, and avoid the
complexities of the relational model. They inspired many
open source projects to develop so-called NoSQL
databases.

■ There is no standard deﬁnition of what NoSQL means. The
term began with a workshop organized in 2009, but there is
much argument about what databases can truly be called
NoSQL.

■ But while there is no formal deﬁnition, there are some

common characteristics of NoSQL databases

■ they don’t use the relational data model, and thus don’t use the

SQL language

■ they tend to be designed to run on a cluster

■ they don’t have a ﬁxed schema, allowing you to store any data

in any record

■ they tend to be Open Source (when oﬀered as software)

20

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases
Data models

2111

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases
Data models

Document

Wide column /

Column family

Graph

Key-value

2211

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases
Key-value data model

■ The database allows to store arbitrary objects
(a name, an image, a document, ...) and to
retrieve them with a key.

■ It's the principle of a hashmap, but stored

persistently on a disk.

■ Key-value stores are the simplest NoSQL data
stores to use from an API perspective. The
client can either get the value for the key, put a
value for a key, or delete a key from the data
store.

Keys

Values

837094

object1

071943

object2

812792

object3

23

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases
Wide column / Column-family data model

■ Row key

■ Unique key for each row.

■ A row contains several column

families.

■ Accessible via the key

■ Column family

■ A combination of columns that

go together.

■ Has a name.

Column key

Column value

Column family

name

"Martin"

proﬁle

billingAddress

data...

payment

data...

...

Row key

071943

■ Contains several column key /

column value pairs.

...

■ Column key / column value

■ Key/value pair containing the

data.

orders

OR1001

data

OR1002

data...

OR1003

data...

OR1004

data...

24

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases
Document data model

■ The database allows to store documents,
where each document is a complex data
structure.

■ Hierarchical structure (like an XML document)

■ Structure often represented in JSON

■ The developer can make queries over the data

structure

■ to extract pieces of data

■ to update pieces of data

{""id":"1001,
"""customer_id":"7231,
"""line8items":"[
""""{""product_id":"4555,""quantity":"8"},
""""{""product_id":"7655,""quantity":"4"},
""],
"""discount8code":"Y
}

{""id":"1002,
"""customer_id":"9831,
"""line8items":"[
""""{""product_id":"4555,""quantity":"3"},
""""{""product_id":"2155,""quantity":"4"},
""""{""product_id":"6384,""quantity":"1"},
""],
}

25

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

NoSQL databases
Graph data model

■ Structure of a graph with vertices and edges.

■ Can be oriented or not.

■ Well suited to following relations between

objects.

has friend

Fred

Alice

has friend

■ Relational databases don't work well in this

is daughter of

case. One has to make joins which may become
very complex.

■ The term "relational" comes from set theory.

■ Query language adapted to the graph

structure.

has friend

Anne

Yann

is married with

Marie

26

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

BigCo

employee of

employee of

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Anna

Carol

NoSQL databases
friend of
friend of
Graph data model — Query language

■ Example: Cypher query language of Neo4j

Barbara

Elizabeth

friend of

START%barbara%=%node:nodeIndex(name%=%"Barbara")
MATCH%(barbara)9[:FRIEND]9>(friend_node)
RETURN%friend_node.name,friend_node.location

BigCo

employee of

employee of

Anna

Carol

friend of

friend of

friend of

Barbara

Elizabeth

27

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

START%barbara%=%node:nodeIndex(name%=%"Barbara")
MATCH%(barbara)9[:FRIEND]9>(friend_node)
RETURN%friend_node.name,friend_node.location

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Introduction to cloud databases

■ A cloud database, also called Database-as-
a-Service, is a database managed by the
cloud provider.

■ The cloud provider provides the database

software, the operating system, the server(s)
and the storage.

■ The cloud client provides the data and the

schema.

■ The cloud provider regularly backs up the data.

■ The cloud provider keeps the database software

and operating system up-to-date.

■ There are two types of cloud databases,

depending on whether the database is shared
among cloud clients, also called tenants.

■ Single-tenant cloud databases: the database

is dedicated to a single cloud client.

■ Multi-tenant cloud databases: the database is

shared between several cloud clients.

28

Cloud Computing  |  Scaling apps on IaaS  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Single-tenant database

■ Single-tenant databases are typically based on

Virtual Machine

existing database software.

■ Mostly relational

■ Often Open Source

■ E.g., MySQL, MariaDB, PostgreSQL, Oracle,

SQL Server, DB2

■ When you request a new database, the cloud
provider typically creates a new VM and new
volumes for that database.

endpoint
for database
protocol

Database
software

Root
volume

Data volume

■ Pricing: you are charged for the time the
database is allocated and for the storage
capacity of the database.

AWS

Azure

Relational Database Service (RDS)

SQL Database

Google Cloud Cloud SQL

29

Cloud Computing  |  Scaling apps on IaaS  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Single-tenant database

■ To provide a single-tenant database to a client,

the cloud provider typically

■ creates a new VM from an image; the image

contains the operating system and the database
software;

■ adds a virtual disk to hold the ﬁles of the

database with the capacity deﬁned by the client;

■ launches the database software;

■ creates a root user for the database with the

password deﬁned by the client.

■ conﬁgures remote access on the database.

■ The client is not able to log into the VM or

access the ﬁles on the volumes.

30

Cloud Computing  |  Scaling apps on IaaS  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Multi-tenant database

■ Multi-tenant databases are typically based on

Database cluster

NoSQL database software.

■ Sometimes open source (Cassandra, MongoDB,

…)

■ Sometimes proprietary (DynamoDB,
CosmosDB, Firestore/Datastore, …)

■ There is one single database, distributed over
thousands of machines, that stores the data of
all the tenants. The database ensures isolation
between the tenants.

■ The database uses replication to ensure the
database keeps running when machines fail.

■ This also allows the cloud provider to do rolling
maintenance (e.g., software upgrades) without
stopping the database.

■ Pricing: you are charged for the volume of

data you store in the database.

Database
software

Database
software

Database
software

Database
software

AWS

Azure

DynamoDB and others

CosmosDB and others

Google Cloud Firestore/Datastore and others

31

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud databases: single-tenant vs multi-tenant databases

Single-tenant databases

Multi-tenant database

Virtual
Machine

Root
volume

Database cluster

Tenant A

Tenant B

Tenant C

Database
software

Database
software

Database
software

Data
volume

Data

Tenant A

Tenant B

Request
router

Tenant C

Database
software

Database
software

Database
software

Database
software

32

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Database as a Service (DBaaS)

Two example implementations

Amazon RDS

Google Cloud Firestore/
Datastore

Tenancy

Single-tenant

Multi-tenant

Data model

Scheduled downtime

SQL

Yes

NoSQL

No

Pricing — Data storage

Pay per instance running (instance
minutes)

and per GB capacity reserved per
month

Pay per GB stored per month

33

Cloud Computing  |  Database-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD


