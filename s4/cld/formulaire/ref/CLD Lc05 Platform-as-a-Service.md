Cloud Computing —
Platform-as-a-Service

Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Platform-as-a-Service (PaaS)

■ Platform-as-a-Service (PaaS) allows

developers to deploy scalable applications in
the cloud, focusing on the application code
and delegating the rest to the cloud provider.

■ Typically PaaS are for web applications, but

there are also PaaS for IoT or AI.

■ Compared to IaaS, PaaS shifts even more

responsibility to the cloud provider, including

Infrastructure
as a Service

Platform
as a Service

Application

Runtime

Middleware

Application

Runtime

Middleware

■ automatic provisioning of VMs

■ operating system maintenance

Operating System

Operating System

Virtualization

Virtualization

Network

Storage

Server

Network

Storage

Server

■ installation and maintenance of web application

server

■ installation of app and roll out of app updates

■ provisioning of load balancers, health check of

VMs

■ auto scaling with adaptive scaling

■ managed databases and data stores

2

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Some PaaS providers

Azure App Service

Services

Open Source software

3

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

PaaS providers based on Open Source software

■ PaaS are much more diverse than IaaS.

Architectures and APIs are often proprietary.

■ → Danger of vendor lock-in

■ Exception: PaaS based on open source

software projects, such as Cloud Foundry or
OpenShift.

■ Cloud Foundry: IBM Cloud Foundry, SAP Cloud
Platform, SUSE Cloud Application Platform, …

■ OpenShift: Red Hat OpenShift on IBM Cloud,
Microsoft Azure Red Hat OpenShift, Red Hat
OpenShift Service on AWS, …

■ PaaS based on the same software are

compatible and allow cloud customers to
change cloud providers with low friction.

4

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine

■ Google App Engine is a PaaS designed for

web apps and mobile back-ends.

■ You provide

■ the app’s code

■ some conﬁguration info, for example the
mapping between URLs and endpoints

■ Google is responsible for running the app on

its servers and scaling it automatically.

■ Launched in April 2008

■ Supported programming languages and

runtimes:
■ Go

■ PHP

■ Java

■ Python

■ Node.js

■ .NET

■ Ruby

■ …

5

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine architecture

Request handlers

Services

HTTP

HTTP

Front ends

Application servers

Datastore

Google Cloud
Storage

Users

HTTP

Static ﬁle
servers

Memcache

deploy app
conﬁgure

App master

URL fetch

Images

Mail

XMPP

Channel

Task queue

Users

...

6

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine architecture

■ Multi tenancy: Google’s platform automatically deploys your app’s code on its servers. It is able to scale
it automatically to adapt to a changing load. This is done using load balancers and auto scaling groups.

■ However unlike in an IaaS, you don’t control the servers, load balancers or auto scaling groups.

■ Instead, they are controlled by the platform and shared among all of the platform's tenants: the platform provides
a multi-tenant service. At any point in time the platform runs apps from hundreds of thousands of tenants in
millions of replicas (app instances).

■ Frontend: Receives HTTP requests from users.

■ Identiﬁes the tenant and app, routes the request to a server that has the app deployed.

■ Performs health checks on the app instances.

■ Performs load balancing when there are several app instances.

■ Application servers: Run the app’s code in app instances.

■ App instance is a container (standard environment) or a virtual machine (ﬂexible environment).

■ The platform provides the operating system and runtime (Java runtime environment, Python interpreter, etc.).

■ App master: Manages the app instances.

■ Receives app code from the tenants and deploys it in app instances.

■ Kills unhealthy app instances and replaces them with new ones.

■ Automatically scales number of app instances up and down based on diﬀerent scaling policies.

7

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine

Request Handler

■ A Request Handler is the piece of code

responsible for creating an HTTP
response to an HTTP request.

■ E.g., Java servlet

■ In App Engine, a Request Handler has

a life cycle:

1. A request arrives.

1
request

2
request

Request Handler

2. The Request Handler is created. It

receives the request.

3. The Request Handler creates the

response. To do this it can use other
cloud services and cloud storage.

3
request

4. When the response has been sent,
App Engine is free to remove the
Request Handler from memory.

■ For this life cycle to work, the Request
Handler needs to be stateless (except
you use manual scaling).

Services and
storage

Services and
storage

4

response

response

Request Handler

Services and
storage

Services and
storage

8

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine

Request Handler

When the number of requests increases, App Engine allocates additional Request Handlers. All
Request Handlers process the requests in parallel (auto scaling).

Request Handler

Request Handler

Request Handler

9

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

Services and storage

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine

App instance

Where does a Request Handler live? Inside an instance!

■ An instance is a container (standard environment) or a virtual machine (ﬂexible environment).

Server 1

Instance

Server 2

Instance

Server 3

Instance

Local memory

Local memory

Local memory

Request Handler

Request Handler

request

response

request

response

Services and storage

10

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine

App Engine’s management of app instances

■ The Request Handler life cycle may be

■ If necessary App Engine allocates new

satisfying, but instantiating and destroying a
program for each request would not make
sense in practice.

■ The initialization of a program is expensive (=

takes time).

■ Especially the initialization of local memory.

■ Instances are containers in which the

Request Handlers live.

■ An instance keeps the initialized local

memory that will be reused for subsequent
requests.

■ At any point in time an application has a
certain number of instances allocated to
process requests.

■ The front-end distributes the requests among

the available instances.

instances.

■ If an instance is not used during a certain
time interval (idle), App Engine frees the
instance.

Server 1

Instance

Local memory

Request Handler

request

response

Services and storage

11

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine

App Engine’s management of app instances

■ You can see the allocated app instances in the management console.

■ Pricing: you are charged per time an instance is allocated (among other charges).

12

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine
Scaling types

When you upload an application, you specify the scaling type in a conﬁguration ﬁle. The scaling
type controls how the platform creates instances.

■ Manual Scaling — You speciﬁy manually the number of instances to instantiate. With manual
scaling, instances run continuously, allowing the application to perform complex initialization
and rely on the state of its memory over time (they can be stateful).

■ Basic Scaling — With basic scaling, the platform starts with zero instances. It will create an
instance when the application receives a request. The instance will be turned down when the
app becomes idle. The application has to be stateless. The developer has direct control by
specifying two parameters: the maximum number of instances and the idle timeout to delete
instances.

■ Automatic Scaling — With automatic scaling the platform decides when to create and delete
instances using predictive algorithms based on request rate, response latencies, and other
application metrics. The developer has only indirect control by tweaking certain parameters. The
application has to be stateless. This is the default scaling type.

13

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine
Scaling types

Manual scaling

Basic scaling

Automatic scaling

Request timeout

24 hours

24 hours

10 minutes

Background threads

Allowed

Allowed

Not allowed

Residence

Instances remain in
memory and memory is
preserved

Instances are shut down
automatically

Instances are shut down
automatically

14

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine automatic scaling

With automatic scaling, App Engine takes into account diﬀerent metrics to decide when to scale
in or out. With default settings, automatic scaling works as follows:

■ CPU utilization:

■ When CPU utilization reaches 70%, App Engine starts a new instance.

■ When an instance is idle (CPU utilization 0%) for 15 minutes, App Engine shuts it down.

■ Queue latency: Each app instance has its own queue for incoming requests. When the instance

is busy processing requests, new requests wait in the queue before the instance processes
them. When the wait time reaches 500 ms, App Engine starts a new instance.

■ Number of concurrent requests (throughput): When the number of requests that are treated

in parallel by an instance reaches 6, App Engine starts a new instance.

15

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine scaling to zero

■ When requests become very infrequent, App Engine can scale your app to zero instances

(“scale to zero”).

■ Advantage: no compute cost when there is no traﬃc

■ Disadvantage: Cold Start — The ﬁrst HTTP request after scale to zero will get very high latency,

because starting the ﬁrst app instance takes time (4-6 seconds).

16

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine automatic scaling

Automatic scaling is always a trade-oﬀ between desired performance and incurred cost. You can
set certain parameters to inﬂuence how automatic scaling behaves (if you do not specify a
parameter, default values are used):

■ max_instances and min_instances: The maximum number of instances App Engine may

create (useful to control cost), and the minimum number of instances it should keep running,
even if there is no traﬃc (useful to avoid cold start).

■ target_cpu_utilization (default 0.6): CPU usage threshold at which new instances will be

started to handle traﬃc.

■ target_throughput_utilization (default 0.6) and max_concurrent_requests (default 10):

Speciﬁes when to start a new instance due to concurrent requests. When the number of
concurrent requests reaches a value equal to max_concurrent_requests times
target_throughput_utilization, App Engine starts a new instance.

17

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine automatic scaling

■ max_pending_latency (default automatic (= 10 s)) and min_pending_latency (default 500
ms): Speciﬁes when to start a new instance based on the time requests wait in an instance’s
pending queue.

■ Less than min_pending_latency: do not create new instances.

■ More than max_pending_latency: create a new instance.

■ Between min_pending_latency and max_pending_latency: try to use an instance with a small

pending queue. If none would provide a latency below max_pending_latency, create a new instance.

■ min_idle_instances: The number of idle instances to keep around, in addition to the number

of instances calculated by App Engine to be needed. The number of instances is always
numTotalInstances =
max(min_instances, min_idle_instances + needed_instance_count)

18

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine automatic scaling

Scaling parameters are speciﬁed in the app.yaml conﬁguration ﬁle.

Example:

automatic_scaling:

  target_cpu_utilization: 0.65

  min_instances: 5

  max_instances: 100

  min_pending_latency: 30ms

  max_pending_latency: automatic

  max_concurrent_requests: 50

19

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud build

■ Suppose you have written the source code of your app and you want to deploy it on App

Engine.

■ Your source code needs to be compiled and packaged, i.e. built, before it can be installed on

Google’s servers.

■ Normally you build your app locally to test it locally.

■ Google provides a cloud build service for building your application: Cloud Build. When you

deploy your app in the cloud, by typing on the command line

gcloud app deploy

the following happens:

■ The CLI uploads your source ﬁles to Google Cloud Storage.

■ The Google cloud build service instantiates a container in the cloud with Java and Maven installed. It

executes Maven to build your app.

■ The resulting packaged binaries (jar ﬁle) are stored in Google Cloud Storage.

■ Whenever GAE creates a new app instance, it downloads the packaged binaries to the app instance.

20

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deployment units: Applications, Services, Versions, Instances

■ Conceptually an Application is made up of one

or more Services.

■ Services can be conﬁgured to use diﬀerent

runtimes and to operate with diﬀerent
performance settings.

■ Enables developer to factor

a large application into
logical components.

■ A deployed Service behaves

like a microservice.

■ If the developer does not specify a Service

explicitly, App Engine creates a default Service.

■ Diﬀerent Services can be rolled out in diﬀerent

Versions.

■ Independent life-cycles

■ GAE runs a particular Service Version in one

more more Instances.

21

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data storage services

■ Most web apps need to store data in ﬁles or in a database. Google’s cloud platform oﬀers many

services for storing data. Among them:

■ Google Cloud Storage: Persistent object (= ﬁle) storage (similar to AWS S3)

■ Google Cloud SQL: Persistent data storage in a single-tenant relational database that is MySQL-

compatible (similar to AWS RDS)

■ Google Cloud Datastore: Persistent data storage in a multi-tenant NoSQL database

■ Additionally the application is able to use caching of database requests by using Memcache,

an in-memory data caching service

22

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google Datastore

■ The Datastore is a multi-tenant data storage service (Database-as-a-Service)

■ It is not a database dedicated to one tenant, but it is a gigantic scalable database that contains the

data from all tenants.

■ Runs on a cluster of servers (distributed architecture). Behind the scenes Google manages the

distribution and replication of data and load balancing of database queries automatically.

■ No scheduled downtime with 99.95% availability guarantee

■ The application calls simply an API,

■ without caring where the data is stored;

■ without caring about the capacity of the database: virtually unlimited.

■ Datastore has a NoSQL data model diﬀerent from the relational (SQL) model.

■ No need to declare a schema before writing data

■ Aggregate-oriented data model

■ Transaction guarantees are diﬀerent from SQL databases.

■ Relaxed consistency guarantees

23

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google Datastore history

■ 2008: First release of App Engine by Google. The Datastore is integrated into App Engine as its

main storage service.

■ At that time, the Google Cloud platform with its multitude of other services does not exist yet.

■ 2011: First release of Firebase by the startup Envolve. Firebase is a collection of back-end cloud

services for mobile applications. It includes Firebase Realtime Database, a database that
synchronizes data between mobile devices and the cloud.

■ 2014 Google acquires Firebase.

■ 2017 Google announces Cloud Firestore, an evolution of Firebase Database.

■ 2021Google merges Datastore into Firestore: “Firestore in Datastore mode”.

24

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Datastore data model

Key

bookstore

"Book"

837094

Entity

Property

"title"

"The Grapes of
Wrath"

"author"

"John Steinbeck"

"copyrightYear"

1939

Application ID

Kind

Entity ID

Ancestor path

"authorBirthdate"

1902-02-27

Name

Value

25

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Datastore data model

The data model of the Datastore is organized along three major concepts:

■ Entity: An object in the Datastore containing several properties. Each object has a unique key.

■ Kind: The "type" of an entity, for example an e-commerce application would have the kinds

client, article, order.

■ Used in queries to ﬁnd the stored entities.

■ Does not imply the presence of properties.

■ Property: A property contains one piece of data of an entity, for example customer name, article

price.

■ An entity may have several properties.

■ Each property has a name and at least one value.

26

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Datastore entity key

■ The keys of the entities in the datastore have to be unique — even across App Engine clients.

■ A key is composed of several parts

■ The application identiﬁer

■ Ensures that there are never collisions with keys from other applications.

■ Is automatically managed by App Engine. Cannot be modiﬁed by the application.

■ The entity kind

■ Contributes to the uniqueness of the key.

■ Is used by the Datastore in queries

■ The entity identiﬁer. This part may be …

■ speciﬁed by the application. In this case this part is called key name.

■ automatically generated by the Datastore. In this case this part is called ID.

■ (Optional) The ancestor path: a path composed of the entity's ancestors

■ Allows to locate the entity in a hierarchical structure.

■ NB: When the key of an entity has been created, it can no longer be changed!

27

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Datastore

Mapping datastore concepts to relational and object-oriented concepts

The Datastore concepts of Kind, Entity, and Property can be mapped to similar concepts in
object-oriented programming languages and relational databases. Be careful, the concepts are
not equivalent!

Datastore

Relational

Object-oriented

Kind

Entity

Table

Row

Class

Object

Property

Column

Attribute

28

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Datastore low level API

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.KeyFactory;

    // accessor for the Datastore service
    private final Datastore datastore =
        DatastoreOptions.getDefaultInstance().getService();

    // ...
        KeyFactory keyFactory = datastore.newKeyFactory().setKind("book");
        Key key = datastore.allocateId(keyFactory.newKey());
        Date authorBirthdate =
                new GregorianCalendar(1902, GregorianCalendar.FEBRUARY, 27).getTime();
        Entity entity = Entity.newBuilder(key)
                .set("title", "The grapes of wrath")
                .set("author", "John Steinbeck")
                .set("copyrightYear", 1939)
                .set("authorBirthdate", Timestamp.of(authorBirthdate))
                .build();

       datastore.put(entity);

29

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Datastore high-level API — Java Persistence API (JPA)

A class that we want to store in the Datastore:

The code that will store this class:

import java.util.Date;

import myapp.Book;  // our data class

import javax.persistence.Entity;

import javax.persistence.Id;

// ...

@Entity(name = "Book")

public class Book {

    @Id

EntityManager em = null;

try {

    em = emf.createEntityManager();

    Book book = new Book();

    private String isbn;

    book.setTitle("The Grapes of Wrath");

    private String title;

    private String author;

    private int    copyrightYear;

    private Date   authorBirthdate;

    // ... constructors, accessors

    // ...

    em.persist(book);

} finally {

    if (em != null)

        em.close();

}

}

30

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine pricing and free limit

Free limit per day Price above free limit

Instances

28 instance hours

$0.05-0.30 per instance hour

Data transfer in

free

Data transfer out

1 GB

$0.12/GB

Datastore stored data

1 GiB

$0.150/GiB/month

Datastore entity reads

50’000 reads

$0.030 per 100,000 entities

Datastore entity writes

20’000 writes

$0.090 per 100,000 entities

Datastore entity deletes 20’000 deletes

$0.010 per 100,000 entities

NB: The free usage is not limited in time. It is possible to host small projects indeﬁnitely for free.

All prices given for region us-central1 (Iowa)

31

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google App Engine pricing

Pricing of instance hours depends on
the instance’s memory and CPU.

Instance
class

Memory
limit

CPU limit

Cost per hour
per instance

F1

F2

F4

384 MB

600 MHz

$ 0.05

768 MB

1.2 GHz

$ 0.10

1536 MB

2.4 GHz

$ 0.20

F4_1G

3072 MB

2.4 GHz

$ 0.30

32

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Snapchat

An App Engine case study

■ 2011 At U Stanford three students work on a class project to design a
photo sharing app. New idea: the photos disappear after being viewed

■ 2011-09 First public release of Snapchat, built on Google App Engine

■ 2012-01 3’000 monthly users

■ 2012-05 30’000 monthly users, 1 million snaps a day

■ 2012-11 20 million snaps a day

■ 2012-12 Introduction of videos

■ 2013-09 Snapchat rejects Facebook oﬀer for $3 billion

■ 2014 400 million snaps a day

■ 2015-05 2 billion videos a day

■ 2015-11 6 billion videos a day

■ 2017-03 Snapchat goes public

■ $28 billion valuation, 2’000 employees

■ Snapchat is Google App Engine’s biggest customer, spending at least

$400 million a year

33

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google Cloud

Conceptual model of Google Cloud account compared to AWS account

Credit
card

User A

User B

…

IAM user A

IAM user B

…

AWS account

Cloud resource

AWS API

EC2

S3

RDS

…

User

Credit
card 1

Credit
card 2

…

Billing
account B1

Billing
account B2

…

Google account

Cloud resource

Project P1

Compute
Engine API

Cloud
Storage API

Project P2

Dataproc API

…

AWS account

Google account

■ Resources can be created directly

■ Resources have to be created inside a project

■ One credit card for billing

■ All services accessible in one API

■ Project needs to be linked to billing account

■ Separate APIs for services that need to be enabled

before use

project linked to
billing account

API enabled

34

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google Cloud

Regularly verify how
much credit is left in
your billing account.

35

Cloud Computing  |  Platform-as-a-Service  |  Academic year 2024/25

 © 2025 HEIG-VD


