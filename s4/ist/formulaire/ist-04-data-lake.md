IST — Data lakes

Infrastructures pour le stockage et le traitement de données  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Evolution of data management for analytics

■ 1990’s: Data warehouse

■ Companies make heavy use of relational database management systems
(RDBMS) to support business processes. Tens or hundreds of databases.

■ Online transaction processing (OLTP)

■ Data warehouse: Central repository of key data ingested from OLTP

systems. Used for analytic reports (“Which sales channel had the biggest
decline in the last quarter?”). Analytic RDBMS.

■ Online analytical processing (OLAP)

■ Data is well-integrated, highly structured, highly curated, and highly

trusted.

■  2006: Hadoop and Big Data

■ Exponential growth in semi-structured and unstructured data (mobile and
web applications, sensors, IoT devices, social media, and audio and video
media platforms).

■ Data has high velocity, high volume, high variety

■ Hadoop: open source framework for processing large datasets on clusters

of computers

2

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Evolution of data management for analytics

■ 2011: Data lake

■ Companies have lots of data, suspect that it may be valuable, but don’t

know yet how to extract the value. → Store everything, just in case.

■ Data lake: Company-wide repository for storing data. Store it in raw form.

Don’t try to optimise the storage.

■ Adoption of public cloud infrastructure, namely cloud object stores.

■ Data is unstructured, semi-structured, and structured.

■ 2020: Data lakehouse

■ Companies try to integrate the best ideas from data warehouses and data

lakes.

■ In addition to raw format, data is stored in optimised binary format such as

Parquet.

■ Concurrent reads/writes become possible with Delta Lake ﬁle format.

■ 2021: Data mesh

■ The company-wide data lake becomes too big and too complex to

manage. Instead, each division of the company creates its own data lake
that it manages independently.

3

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Enterprise data warehousing architecture

5

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Dimensional
modeling in data
warehouses

Dimension tables are
denormalised.

6

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

Dimension tables
are normalised. Less
duplication.

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Extract-Transform-Load pipelines

Feeding data into the warehouse

8

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google File System and MapReduce programming model

■ In the beginning of the 2000’s, Google
develops its search engine that quickly
dominates market thanks to superior
technology.

■ In 2003 Google engineers publish a paper

about the Google File System, the distributed
ﬁle system that is used to store the data for its
search engine.

Application

GFS client

(file name, chunk index)

GFS master

File namespace

/foo/bar
chunk 2ef0

(chunk handle,
chunk locations)

(chunk handle, byte range)

chunk data

Instructions to chunkserver

Chunkserver state

GFS chunkserver

GFS chunkserver

Linux file system

Linux file system

Figure 1: GFS Architecture

Legend:

Data messages
Control messages

■ In 2004 they follow with a paper on

MapReduce,  a new programming model for
parallel processing that Google uses for the
search engine processing (indexing,
ranking, …).

■ These papers were very inﬂuential and

launched the era of Big Data.

9

IST  |  Data Lakes  |  Academic year 2024/25

(1) fork

split 0

worker

and replication decisions using global knowledge. However,
we must minimize its involvement in reads and writes so
that it does not become a bottleneck. Clients never read
and write ﬁle data through the master. Instead, a client asks
the master which chunkservers it should contact. It caches
this information for a limited time and interacts with the
chunkservers directly for many subsequent operations.
(2)
assign
map

Let us explain the interactions for a simple read with refer-
ence to Figure 1. First, using the ﬁxed chunk size, the client
translates the ﬁle name and byte oﬀset speciﬁed by the ap-
plication into a chunk index within the ﬁle. Then, it sends
the master a request containing the ﬁle name and chunk
index. The master replies with the corresponding chunk
handle and locations of the replicas. The client caches this
(3) read
information using the ﬁle name and chunk index as the key.
The client then sends a request to one of the replicas,
most likely the closest one. The request speciﬁes the chunk
handle and a byte range within that chunk. Further reads
of the same chunk require no more client-master interaction
until the cached information expires or the ﬁle is reopened.
In fact, the client typically asks for multiple chunks in the
same request and the master can also include the informa-
tion for chunks immediately following those requested. This
extra information sidesteps several future client-master in-
teractions at practically no extra cost.

Map
phase

Input
files

(4) local write

worker

worker

split 1

split 2

split 3

split 4

2.5 Chunk Size

User
Program

(1) fork

Master

tent TCP connection to the chunkserver over an extended
period of time. Third, it reduces the size of the metadata
stored on the master. This allows us to keep the metadata
in memory, which in turn brings other advantages that we
will discuss in Section 2.6.1.

(1) fork

(6) write

(2)
assign
reduce

On the other hand, a large chunk size, even with lazy space
allocation, has its disadvantages. A small ﬁle consists of a
small number of chunks, perhaps just one. The chunkservers
storing those chunks may become hot spots if many clients
are accessing the same ﬁle. In practice, hot spots have not
been a major issue because our applications mostly read
large multi-chunk ﬁles sequentially.
worker

However, hot spots did develop when GFS was ﬁrst used
by a batch-queue system: an executable was written to GFS
as a single-chunk ﬁle and then started on hundreds of ma-
chines at the same time. The few chunkservers storing this
executable were overloaded by hundreds of simultaneous re-
quests. We ﬁxed this problem by storing such executables
with a higher replication factor and by making the batch-
queue system stagger application start times. A potential
long-term solution is to allow clients to read data from other
clients in such situations.

output
file 0

output
file 1

worker

(5) remote read

Intermediate files
(on local disks)

Reduce
phase
2.6 Metadata

Output
files

Figure 1: Execution overview

The master stores three major types of metadata: the ﬁle
and chunk namespaces, the mapping from ﬁles to chunks,
and the locations of each chunk’s replicas. All metadata is
kept in the master’s memory. The ﬁrst two types (names-

 © 2025 HEIG-VD

Chunk size is one of the key design parameters. We have

chosen 64 MB, which is much larger than typical ﬁle sys-

Inverted Index: The map function parses each docu-

large clusters of commodity PCs connected together with

paces and ﬁle-to-chunk mapping) are also kept persistent by

tem block sizes. Each chunk replica is stored as a plain

ment, and emits a sequence of

word, document ID

switched Ethernet [4]. In our environment:

logging mutations to an operation log stored on the mas-

!

"

Linux ﬁle on a chunkserver and is extended only as needed.

pairs. The reduce function accepts all pairs for a given

Lazy space allocation avoids wasting space due to internal

word, sorts the corresponding document IDs and emits a

!

fragmentation, perhaps the greatest objection against such

word, list(document ID)

pair. The set of all output

a large chunk size.

pairs forms a simple inverted index. It is easy to augment

A large chunk size oﬀers several important advantages.

this computation to keep track of word positions.

First, it reduces clients’ need to interact with the master

"

because reads and writes on the same chunk require only

one initial request to the master for chunk location informa-

Distributed Sort: The map function extracts the key

tion. The reduction is especially signiﬁcant for our work-

from each record, and emits a

key, record

pair. The

loads because applications mostly read and write large ﬁles

reduce function emits all pairs unchanged. This compu-

!

"

sequentially. Even for small random reads, the client can

tation depends on the partitioning facilities described in

comfortably cache all the chunk location information for a

Section 4.1 and the ordering properties described in Sec-

multi-TB working set. Second, since on a large chunk, a

tion 4.2.

client is more likely to perform many operations on a given

chunk, it can reduce network overhead by keeping a persis-

3 Implementation

Many different implementations of the MapReduce in-

terface are possible. The right choice depends on the

environment. For example, one implementation may be

suitable for a small shared-memory machine, another for

a large NUMA multi-processor, and yet another for an

even larger collection of networked machines.

ter’s local disk and replicated on remote machines. Using

(1) Machines are typically dual-processor x86 processors

a log allows us to update the master state simply, reliably,

running Linux, with 2-4 GB of memory per machine.

and without risking inconsistencies in the event of a master

(2) Commodity networking hardware is used – typically

crash. The master does not store chunk location informa-

either 100 megabits/second or 1 gigabit/second at the

tion persistently. Instead, it asks each chunkserver about its

machine level, but averaging considerably less in over-

chunks at master startup and whenever a chunkserver joins

all bisection bandwidth.

the cluster.

(3) A cluster consists of hundreds or thousands of ma-

2.6.1 In-Memory Data Structures

chines, and therefore machine failures are common.

Since metadata is stored in memory, master operations are

(4) Storage is provided by inexpensive IDE disks at-

fast. Furthermore, it is easy and eﬃcient for the master to

tached directly to individual machines. A distributed ﬁle

periodically scan through its entire state in the background.

system [8] developed in-house is used to manage the data

This periodic scanning is used to implement chunk garbage

stored on these disks. The ﬁle system uses replication to

collection, re-replication in the presence of chunkserver fail-

provide availability and reliability on top of unreliable

ures, and chunk migration to balance load and disk space

hardware.

(5) Users submit jobs to a scheduling system. Each job

consists of a set of tasks, and is mapped by the scheduler

to a set of available machines within a cluster.

3.1 Execution Overview

This section describes an implementation targeted

The Map invocations are distributed across multiple

to the computing environment in wide use at Google:

machines by automatically partitioning the input data

To appear in OSDI 2004

3

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google File System and MapReduce programming model

■ The Google File System and MapReduce

programming model had several innovations
over existing high-performance computing
systems:

■ The system is built on inexpensive commodity

hardware. It scales to hundreds or thousands of
machines.

■ The programming model is much simpler than

the shared memory or message passing models.

y
r
o
m
e
M

P1

P2

P3

P4

P5

P1

P2

P3

P4

P5

Shared memory (pthreads)

Message

passing

10

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Apache Hadoop

■ In 2005 engineers at Yahoo!, Doug Cutting and

Mike Cafarella, develop a system similar to
Google’s.

■ In 2006 they launch the Apache Hadoop open

source project.

■ A Hadoop installation consists mainly of

Data analysis applications

■ a cluster of machines (physical or virtual)

■ the distributed ﬁle system HDFS (Hadoop

Distributed File System)

■ the NoSQL database HBase

■ the distributed computing framework

MapReduce

■ the data processing applications written by the

developer.

■ Hadoop is the name of the toy elephant of

Cutting’s son.

MapReduce

HBase
database

Hadoop Distributed File System
(HDFS)

A cluster of machines

11

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Distribution of data in HDFS

■ When downloading a big ﬁle to a MapReduce cluster, the ﬁle is distributed over the machines of

the cluster.

■ The ﬁle system takes care of dividing the ﬁle into pieces (chunks of 64 MB) which are managed

by diﬀerent machines of the cluster.

■ This is a form of sharding.

A big ﬁle

… is divided into
pieces

… and the pieces are
distributed over the
machines of the
cluster.

HDFS node 1

HDFS node 2

HDFS node 3

HDFS node 4

■ (Additionally the chunks are replicated, there are always three copies in the cluster.)

12

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Data processing — Main concept

■ One wishes to process a big volume of data which is distributed over several machines.

■ Traditional approach: move the data to the processing

Node 1

Node 2

Node 3

Node 4

Processing

Result

■ Problem:

■ Data volumes keep growing faster than the performance of data storage.

■ Hard-disks have a relatively low read speed (currently ~100 MB/second magnetic, ~550 MB/second

SSD)

■ Reading a copy of the Web (> 400 TB) would need more than a week (SSD)!

13

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Data processing — Main concept

■ MapReduce approach: move the processing to the data

■ Each machine which stores data executes a piece of the processing.

■ Partial results are collected and aggregated.

Node 1

Partial
result

Node 2

Node 3

Node 4

■ Advantages

Result

■ Less movement of data on the network.

■ Processing takes place in parallel on several machines.

■ Process a copy of the Web using 1'000 machines: < 3 hours

14

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Distributed computing platform

■ The MapReduce concept is a simple data processing model that can be applied to many

problems:

■ Google: compute PageRank which determines the importance of a Web page.

■ Last.fm: compute charts of the most listened songs and recommendations (music you might like).

■ Facebook: compute usage statistics (user growth, visited pages, time spent by users) and

recommendations (people you might know, applications you might like).

■ Rackspace: indexing of infrastructure logs to determine root cause in case of failures.

■ ...

■ To implement the model one needs to

■ parallelize the compute tasks

■ balance the load

■ optimize disk and memory transfers

■ manage the case of a failing machine

■ ...

■ A distributed computing platform is needed!

15

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model

Map and Reduce functions — Origin of the terms

■ The terms Map and Reduce come from Lisp

■ When you have a list you can apply at once the
same function to every element of the list. You
obtain another list.

■ For example the function x → x2

■ You can also apply at once a function which

reduces the elements of a list to a single value.

■ For example the sum function

■ In Hadoop, the functions Map and Reduce are

more general.

input list

1

2

3

4

5

6

7

8

Map function

output list

1

4

9

16

25

36

49

64

input list

1

2

3

4

5

6

7

8

Reduce
function

output value

36

16

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Example: Processing of meteorological data

■ The National Climatic Data Center of the

United States publishes meteorological data

■ Captured by tens of thousands meteorological

stations

■ Measures: temperature, humidity, precipitation,

wind, visibility, pression, etc.

■ Historical data available since the beginning of

meteorological measurements

■ The data is available as text ﬁles.

■ Example ﬁle:

0067011990999991950051507004+68750+023550FM-12+038299999V0203301N00671220001CN9999999N9+00001+99999999999

0043011990999991950051512004+68750+023550FM-12+038299999V0203201N00671220001CN9999999N9+00221+99999999999

0043011990999991950051518004+68750+023550FM-12+038299999V0203201N00261220001CN9999999N9-00111+99999999999

0043012650999991949032412004+62300+010750FM-12+048599999V0202701N00461220001CN0500001N9+01111+99999999999

...

17

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Example: Processing of meteorological data

■ Each ﬁle contains the measures of a year.

■ One line represents a set of observations of a station a certain point in time.

■ Example line with comments (distributed over several lines for better legibility):

0057
332130			#	USAF	weather	station	identifier
99999				#	WBAN	weather	station	identifier
19500101	#	observation	date
0300					#	observation	time
4
+51317			#	latitude	(degrees	x	1000)
+028783		#	longitude	(degrees	x	1000)	FM-12
+0171				#	elevation	(meters)
99999
V020
320						#	wind	direction	(degrees)
1								#	quality	code
N
0072
1

00450				#	sky	ceiling	height	(meters)
1								#	quality	code
C
N
010000			#	visibility	distance	(meters)
1								#	quality	code
N
9
-0128				#	air	temperature	(degrees	Celsius	x	10)
1								#	quality	code
-0139				#	dew	point	temperature	(degrees	Celsius	x	10)
1								#	quality	code
10268				#	atmospheric	pressure	(hectopascals	x	10)
1								#	quality	code

Source: Tom White, Hadoop: The Deﬁnitive Guide

18

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Example: Processing of meteorological data

■ Problem: One wishes to calculate for each year the maximum temperature

■ Classical approach

■ Bash / Awk script

#!/usr/bin/env	bash

for	year	in	all/*

do

				echo	-ne	`basename	$year	.gz`"\t"

				gunzip	-c	$year	|	\

				awk	'{	temp	=	substr($0,	88,	5)	+	0;	q	=	substr($0,	93,	1);

											if	(temp	!=9999	&&	q	~	/[01459]/	&&	temp	>	max)	max	=	temp	}

									END	{	print	max	}'

done

■ Computing time for the data from 1901 to 2000: 42 minutes

%	./max_temperature.sh

1901	317

1902	244

1903	289

1904	256

1905	283

...

Source: Tom White, Hadoop: The Deﬁnitive Guide

19

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

MapReduce programming model
Example: Processing of meteorological data

■ MapReduce approach

106

0043011990999991950051512004...9999999N9+00221+99999999999...

■ The developer writes two functions

■ The Mapper which is responsible for extracting

the year and the temperature from a line.

■ The Reducer which is responsible for calculating

the maximum temperature.

■ Hadoop is responsible for

■ Dividing the input ﬁles into pieces,

■ Instantiating the Mapper on each machine of the

cluster an run the instances,

■ Collecting the results of the Mapper instances,

■ Instantiating the Reducer on each machine of the
cluster and run the instances by giving them as
input the data produced by the Mapper
instances.

■ Store the results of the Reducer instances.

Mapper

1950

22

1950

0

22

-11

Reducer

1950

22

20

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

0

0067011990999991950051507004...9999999N9+00001+99999999999...

106

0043011990999991950051512004...9999999N9+00221+99999999999...

212

0043011990999991950051518004...9999999N9-00111+99999999999...

The meteorological data is divided
into lines.

318

0043012650999991949032412004...0500001N9+01111+99999999999...

424

0043012650999991949032418004...0500001N9+00781+99999999999...

Mapper

Mapper

Mapper

Mapper

Mapper

1950

0

1950

22

1950

-11

1949

111

1949

78

The Mapper extracts the year and
the temperature and writes a key-
value pair (year, temperature) as
output.

Shufﬂe and sort

The intermediate data is grouped
by key (the year) and sorted.

1949

111

78

1950

0

22

-11

Reducer

Reducer

1949

111

1950

22

The Reducer reads the year and all
temperatures of that year. It
calculates the maximum and writes
a key-value pair (year, maximum
temperature) as output.

■ Processing time for the data from 1901 to 2000 using 10 machines: 6 minutes

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Anatomy of a Hadoop cluster
Distributed ﬁle system HDFS

■ HDFS design decisions:

■ Files stored as chunks

■ Fixed size (64MB)

■ Reliability through

replication

Application

File namespace

/foo/bar

HDFS namenode

HDFS client

block 3d2f

...

...

■ Each chunk replicated across 3+ nodes

■ Single master to coordinate access, keep

metadata

■ Simple centralized management

■ No data caching

HDFS datanode

HDFS datanode

■ Little beneﬁt due to large datasets, streaming

Linux ﬁle system

Linux ﬁle system

reads

■ Simplify the API

■ Push some of the issues onto the client (e.g., data

layout)

...

...

22

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Anatomy of a Hadoop cluster
Namenode responsibilities

■ Managing the ﬁle system namespace:

■ Holds ﬁle/directory structure, metadata, ﬁle-to-

block mapping, access permissions, etc.

■ Coordinating ﬁle operations:

■ Directs clients to datanodes for reads and writes

■ No data is moved through the namenode

■ Maintaining overall health:

■ Periodic communication with the datanodes

■ Block re-replication and rebalancing

■ Garbage collection

23

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Anatomy of a Hadoop 1.x cluster
Putting everything together

■ Per cluster:

■ One Namenode (NN): master

node for HDFS

■ One Jobtracker (JT): master
node for job submission

■ Per slave machine:

■ One Tasktracker (TT):

contains multiple task slots

■ One Datanode (DN): serves

HDFS data blocks

master node

jobtracker

namenode

Web UI at
http://hostname:50030/

Web UI at
http://hostname:50070/

Server

MapReduce

HDFS

slave node

tasktracker

slave node

tasktracker

slave node

tasktracker

datanode

datanode

datanode

24

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Apache Hadoop ecosystem

The most important projects

■ HDFS (2006) — Distributed ﬁle system for

big data

■ MapReduce (2006) — Framework

implementing MapReduce programming
model for parallel processing

■ ZooKeeper (2007) — Distributed key-value

store for the coordination of distributed
applications

■ Hive metastore — RDBMS for storing

schema information and other metadata

■ YARN (2012)— Generic cluster manager

■ Impala (2013) — Massively parallel
processing (MPP) SQL query engine

■ Spark (2014) — Analytics engine for large-
scale data processing written in Scala.
Oﬀers multiple programming models:

■ HBase (2008) — NoSQL database on top of

■ Scala Resilient Distributed Datasets (RDDs)

HDFS

■ Pig (2008) — Programming model for

parallel processing that is higher-level than
MapReduce

■ Hive (2010) — Software project for data

warehouses that gives an SQL-like interface
for querying data. Uses Pig.

■ Scala DataFrames

■ Python DataFrames

■ SQL

■ Ozone (2020) — HDFS-compatible object
store optimised for billions of small ﬁles

25

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data lake logical architecture

27

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

File formats

Many ﬁle formats exist for storing data sets:

■ CSV

■ JSON

■ Avro

■ Parquet

■ ORC

■ …

What are the properties of each ﬁle format? Which one to choose?

28

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

File formats

Use-case: Analysis of all ﬂights in the US between 2004-2008 using Apache Spark

File format

File size

Processing time

CSV

JSON

3'400 MB 8m 45s

12'000 MB 37m 25s

Hadoop sequence ﬁle

3'700 MB 29m 5s

Parquet

550 MB 1m 40s

29

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

File formats

Text-based formats

■ The most important text-based formats are

■ Comma-Separated Values (CSV)

■ CSV

■ JSON

■ YAML

■ XML

■ Advantage:

■ Readable by humans

■ Drawbacks:

■ High storage footprint

■ Very low read performance

■ Good for storing data organized as a single

table

■ Names of columns given in the ﬁrst row

■ No hierarchical structure

■ JSON / YAML / XML

■ Support for hierarchical structures

■ Powerful tools for transforming the structure:

■ jq for JSON

■ yq for YAML

■ XSLT for XML

■ Very verbose, large footprint

30

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

JSON ﬁle format

■ Built on two structures:

■ To store tabular data, two possibilities:

■ A collection of name/value pairs (also

■ Store the whole table in a single JSON

known as object, record, struct, dictionary,
hash table, keyed list, or associative array).

■ An ordered list of values (also known as

array, vector, list, or sequence).

value.

[
  { record 1 },
  { record 2 },
  { record 3 },
  ...
]

■ Store each row in a separate JSON value,

separated by newline.

{ record 1 }
{ record 2 }
{ record 3 }
...

This format is called JSON Lines, ﬁle
extension .jsonl.

31

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

JSON and YAML

YAML (Yet Another Markup Language) is
structurally equivalent to JSON, but easier for
humans to read and write.

--- !<tag:clarkevans.com,2002:invoice>
invoice: 34843
date   : 2001-01-23
bill-to: &id001
    given  : Chris
    family : Dumars
    address:
        lines: |
            458 Walkman Dr.
            Suite #292
        city    : Royal Oak
        state   : MI
        postal  : 48046
ship-to: *id001
product:
    - sku         : BL394D
      quantity    : 4
      description : Basketball
      price       : 450.00
    - sku         : BL4438H
      quantity    : 1
      description : Super Hoop
      price       : 2392.00
tax  : 251.42
total: 4443.52
comments:
    Late afternoon is best.
    Backup contact is Nancy
    Billsmer @ 338-4338.

{
  "invoice": 34843,
  "date": "2001-01-23T00:00:00Z",
  "bill-to": {
    "given": "Chris",
    "family": "Dumars",
    "address": {
      "lines": "458 Walkman Dr.\nSuite #292\n",
      "city": "Royal Oak",
      "state": "MI",
      "postal": 48046
    }
  },
  "ship-to": {
    "given": "Chris",
    "family": "Dumars",
    "address": {
      "lines": "458 Walkman Dr.\nSuite #292\n",
      "city": "Royal Oak",
      "state": "MI",
      "postal": 48046
    }
  },
  "product": [
    {
      "sku": "BL394D",
      "quantity": 4,
      "description": "Basketball",
      "price": 450
    },
    {
      "sku": "BL4438H",
      "quantity": 1,
      "description": "Super Hoop",
      "price": 2392
    }
  ],
  "tax": 251.42,
  "total": 4443.52,
  "comments": "Late afternoon is best. Backup
contact is Nancy Billsmer @ 338-4338."
}

32

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

File formats

Binary encoding formats

■ Examples:

■ Avro (Hadoop)

■ Thrift (Facebook)

■ Protocol Buﬀers (Google)

■ …

■ Idea:

■ Describe the data using a schema.

■ Pack all ﬁelds describing an item (a row) in a

binary format.

■ Advantages: Can lead to huge space

reduction.

■ Column-oriented binary formats:

■ Parquet (Twitter & Cloudera)

■ ORC (Hadoop)

33

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Introduction

■ Column-based format - ﬁles are organized by

column, rather than by row, which saves
storage space and speeds up analytics
queries.

■ Started in 2012 by Cloudera & Twitter

■ 2013-07 ﬁrst release

■ 2015-04 Apache Open Source project

■ Language agnostic

■ Used for analytics (OLAP) use cases, typically

in conjunction with traditional OLTP databases.

■ Built on the record shredding and assembly

algorithm described in Google's Dremel paper.

34

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Hybrid row/column storage layout

Good for
WHERE predicates
(when sorted)

Good for
SELECT
projection

Good for
both

Source: https://towardsdatascience.com/demystifying-the-parquet-ﬁle-format-13adb0206705

35

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Storage layout

■ Data are stored in ﬁles.

Parquet Overview

Column Chunk

■ A ﬁle consists of one or more row groups.

Host

URL

Response

Bytes

Referrer

p
u
o
r
G
w
o
R

p
u
o
r
G
w
o
R

B
G
1
~

B
G
1
~

■ A set of rows

■ A row group contains exactly one column

chunk per column.

■ A column chunk is contiguous in the ﬁle.

■ Metadata are stored at the end of the ﬁle.

■ Position of each column chunk

■ Statistics about each chunk:

■ Min/Max statistics for numbers

■ Dictionary ﬁltering for other columns (as long as

less than 40k diﬀerent values)

■ About sorting:

■ Rows can be sorted based on one speciﬁc

column.

20

36

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Example

■ Imagine a table with customer information where one of the columns is Country and we have

the query:

SELECT * FROM Customers WHERE Country=’Mexico’;

■ Let’s say we have 10M rows, 10k rows per row group, and 1% of the customers are from

Mexico.

■ Amount of data to read to answer the query:

■ With a row-based format: All data

■ With an unsorted Parquet ﬁle:

■ Probability of a row group with no customer from Mexico is 0.9910000 = 2.25 × 10−44

■ → All row groups

■ With a sorted Parquet ﬁle: 1% of the row groups (10)

■ When writing the Parquet ﬁle, I can only sort on one column. Which one?

■ It depends on the query pattern. Do it on the column that you’re going to be ﬁltering on most often.

37

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Encoding algorithms

■ Parquet supports several encoding algorithms:

■ Plain (no particular encoding)

■ Dictionary encoding

■ Run-Length Encoding (RLE) / Bit-packing hybrid

■ Delta encoding

■ Parquet chooses the encoding automatically

based on the data.

■ On top of the encoding algorithms, Parquet

can apply compression to the encoded data:

■ gzip

■ Snappy

■ LZO

Source: https://dataninjago.com/2021/12/07/databricks-deep-dive-3-parquet-encoding/

38

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Dictionary encoding

■ Dictionary encoding builds a dictionary of
values encountered in a given column.

■ The dictionary is stored in a dictionary page per

column chunk.

■ The values are then replaced by indexes into

the dictionary table.

Source: https://dataninjago.com/2021/12/07/databricks-deep-dive-3-parquet-encoding/

39

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Run-Length Encoding

■ Run Length Encoding (RLE) replaces repeating

values in a column with

■ how many values are repeated

■ the value.

Source: https://dataninjago.com/2021/12/07/databricks-deep-dive-3-parquet-encoding/

40

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Delta encoding

■ Delta encoding stores the

diﬀerences (deltas) between
sequential data instead of the
whole form of data.

■ Works particularly well for time-
series data. A DateTime value is
typically stored as 64 bit value
(milliseconds since the epoch).
The deltas occupy much fewer
bits.

Source: https://dataninjago.com/2021/12/07/databricks-deep-dive-3-parquet-encoding/

41

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Data types

■ Parquet distinguishes between physical types, simply called types, and logical types. The

designers of Parquet kept the number of physical types as small as possible.

■ (Physical) types:

■ BOOLEAN: 1 bit boolean

■ INT32: 32 bit signed ints

■ INT64: 64 bit signed ints

■ INT96: 96 bit signed ints

■ FLOAT: IEEE 32-bit ﬂoating point values

■ DOUBLE: IEEE 64-bit ﬂoating point values

■ BYTE_ARRAY: arbitrarily long byte arrays

■ Logical types extend the physical types by specifying how the physical types should be

interpreted.

■ For Parquet, specifying a type that is too big will not waste storage space, as it automatically

chooses the most compact encoding. However an application that reads the data into memory
may waste memory space after decoding.

Source: https://github.com/apache/parquet-format

42

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Logical types

■ String types

■ STRING

■ ENUM

■ UUID

■ Numeric types

■ Signed and unsigned integers with bit width

8, 16, 32, and 64 bit.

■ DECIMAL

■ Temporal types

■ DATE

■ TIME

■ TIMESTAMP

■ Embedded types

■ JSON

■ BSON

■ Nested types

■ LIST

■ MAP

■ UNKNOWN (always null)

Source: https://github.com/apache/parquet-format/blob/master/LogicalTypes.md

43

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Parquet ﬁle format

Command-line tool

■ pqrs is a command-line tool to inspect

parquet ﬁles.

■ Use it to see

■ the ﬁle content

■ the table schema

■ the metadata (e.g., statistics)

■ Convert data to JSON and CSV

$	pqrs	schema	data/cities.parquet
Metadata	for	file:	data/cities.parquet

version:	1
num	of	rows:	3
created	by:	parquet-mr	version	1.5.0-cdh5.7.0	(build	${buildNumber})
message	hive_schema	{
		OPTIONAL	BYTE_ARRAY	continent	(UTF8);
		OPTIONAL	group	country	{
				OPTIONAL	BYTE_ARRAY	name	(UTF8);
				OPTIONAL	group	city	(LIST)	{
						REPEATED	group	bag	{
								OPTIONAL	BYTE_ARRAY	array_element	(UTF8);
						}
				}
		}
}

$	pqrs	cat	data/simple.parquet	--csv
foo,bar
1,2
10,20

44

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Hive Metastore

■ Hive Metastore was initially developed for

the Apache Hive data warehouse software. It
is a database for metadata that supports
two features:

■ Data abstraction: On the relational layer, it
stores table deﬁnitions, column names and
data types. On the ﬁle layer, it stores the
location of the ﬁle(s) containing the table and
the format.

■ Data discovery: It enables users to discover

which data is available in the warehouse.

Apache Hive architecture

45

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Hive Metastore

■ Metastore stores the following metadata

objects:

■ Database: A namespace for tables. The

database 'default' is used for tables with no
user-supplied database name.

■ Table: List of columns, owner, storage

location and serialisation/deserialisation
(SerDe) information.

■ Partition: A table may be stored in several

ﬁles, which are called partitions. Each
partition can have its own schema, location,
and SerDe.

46

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Hive Metastore

Serialiser/deserialiser (SerDe)

■ To read a table from a ﬁle, or to write a table

into a ﬁle using a particular format, Hive
uses a serialiser/deserialiser (SerDe).

■ Built-in SerDes (in package

org.apache.hadoop.hive.serde2):

■ Avro

■ ORC

■ RegEx

■ Thrift

■ Parquet

■ CSV

■ JsonSerDe

■ Developers can write their own custom

SerDe.

47

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS Glue Data Catalog

■ AWS uses a Hive Metastore-compatible data

catalog for its data lake / warehouse service, which
it calls AWS Glue Data Catalog.

■ Each AWS account has one Data Catalog per

Region.

■ The Data Catalog is shared by AWS services, so

you need to deﬁne a database / table only once and
use it in Athena, Glue, Glue Studio, Databrew,
Quicksight, etc.

■ The Data Catalog can point to data stored in

diﬀerent AWS services, such as S3, RDS, RedShift,
HDFS, OpenSearch Service, etc.

■ To populate the Data Catalog with deﬁnitions, you

can

■ Write SQL DDL statements by hand in the Athena

console.

■ Use the Glue console UI.

■ Set up a crawler that automatically scans data,
classiﬁes it, and extracts schema information.

48

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS Glue Data Catalog

49

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data catalog convention: a table is stored in a folder

■ An important convention in the data catalog is that the location of a table is deﬁned by a folder,

and not an individual ﬁle. The data of a table can be spread over several ﬁles.

■ This makes it easy to add new data to the table by simply adding new ﬁles to the folder, without

updating the data catalog.

■ But what happens when the ﬁles have diﬀerent schemas?

■ The schema is deﬁned by what is written in the data catalog.

■ If a ﬁle is missing a column that is deﬁned in the catalog, the corresponding data appears as null.

50

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deﬁning a table with Data Deﬁnition Language (DDL)

2016,1,1,6,3,2016-01-06,"AA",19805,"AA","N4YBAA","43",11298,1129804,30194,"DFW","Dallas/Fort
Worth\, TX","TX","48","Texas",74,11433,1143302,31295,"DTW","Detroit\,
MI","MI","26","Michigan",43,"1100","1057",-3.00,0.00,0.00,-1,"1100-1159",15.00,"1112","1424",8.00
,"1438","1432",-6.00,0.00,0.00,-1,"1400-1459",0.00,"",0.00,158.00,155.00,132.00,1.00,986.00,4,,,,
,,"",,,0,,,,,"",,,"",,,"","","",,,"",,,"","","",,,"",,,"","","",,,"",,,"","","",,,"",,,"","",

CREATE EXTERNAL TABLE flight_delays_csv (
    yr INT,
    quarter INT,
    month INT,
    dayofmonth INT,
    dayofweek INT,
    flightdate STRING,
    uniquecarrier STRING,
    ...
)
    PARTITIONED BY (year STRING)
    ROW FORMAT DELIMITED
      FIELDS TERMINATED BY ','
      ESCAPED BY '\\'
      LINES TERMINATED BY '\n'
    LOCATION ‘s3://athena-examples-us-east-1/flight/csv/';

■ This table consists of several CSV

ﬁles.

■ In this example the CSV ﬁles do
not have headers. Even if there
were headers, the columns of the
table must be explicitly speciﬁed in
the DDL.

■ The location of the ﬁles is given as
a folder. When you make a query
on the table, the query engine
automatically scans all ﬁles in the
folder.

51

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deﬁning a table with Data Deﬁnition Language (DDL)

LazySimpleSerDe vs OpenCSVSerDe

■ AWS Athena supports two SerDes for CSV data:

■ LazySimpleSerDe: Default SerDe (see previous example)

■ OpenCSVSerDe: Supports data enclosed in double quotes “ and UNIX numeric timestamp values.

OpenCSVSerDe example

"unixvalue creationdate 18276 creationdatetime 1579059880000","18276","1579059880000"

CREATE EXTERNAL TABLE IF NOT EXISTS testtimestamp1(
 `profile_id` string,
 `creationdate` date,
 `creationdatetime` timestamp
 )
 ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
 LOCATION 's3://DOC-EXAMPLE-BUCKET'

52

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deﬁning a table with Data Deﬁnition Language (DDL)

Parsing a text ﬁle with a regular expression

2014-07-05  20:00:00 LHR3 4260 10.0.0.15
Mozilla/5.0%20(MacOS;%20U;%20Windows%20NT%205.1;%20en-US;%20rv:1.9.0.9)%20Gecko/2009040821%20IE/3.0.9
2014-07-05  20:00:00 MIA3 10  10.0.0.15
304  -
Mozilla/5.0%20(Linux;%20U;%20Windows%20NT%205.1;%20en-US;%20rv:1.9.0.9)%20Gecko/2009040821%20Chrome/3.0.9

GET  eabcd12345678.cloudfront.net  /test-image-1.jpeg

GET  eabcd12345678.cloudfront.net  /test-image-1.jpeg

200  -

CREATE EXTERNAL TABLE IF NOT EXISTS cloudfront_logs (
    `Date` Date,
    Time STRING,
    Location STRING,
    Bytes INT,
    RequestIP STRING,
    Method STRING,
    Host STRING,
    Uri STRING,
    Status INT,
    Referrer STRING,
    OS String,
    Browser String,
    BrowserVersion String
) ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
"input.regex" = "^(?!#)([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\
\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\
\s+[^\(]+[\(]([^\;]+).*\%20([^\/]+)[\/](.*)$"
) LOCATION 's3://athena-examples-MyRegion/cloudfront/plaintext/';

■ Creates a table for the log

ﬁles of a Content
Distribution Network.

■ The log is a text ﬁle. Each
line is a log entry. A log
entry has several ﬁelds of
variable length separated
by whitespace.

■ The RegexSerDe parses
the text ﬁle with a regular
expression. Each ﬁeld is
identiﬁed with a pair of
brackets (…).

53

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Creating table deﬁnitions automatically with crawlers

■ Crawlers are a component of the AWS Glue service. A crawler automatically scans data, infers
its logical schema (columns and their types) with classiﬁers, and writes the metadata it found to
the data catalog.

■ For data feeds that constantly add new data, crawlers can be run periodically to discover new

ﬁles and update the data catalog.

■ Triggered by a ﬁxed schedule or by an event generated by the storage service when new data arrives.

Source: https://aws.amazon.com/blogs/big-data/identify-source-schema-changes-using-aws-glue/

54

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Creating table deﬁnitions automatically with crawlers

Classiﬁers

■ A classiﬁer determines the schema of the data. Glue comes with built-in classiﬁers for popular

data formats (see next slide). You can write a custom classiﬁer and point to it from Amazon
Glue.

■ The crawler has a list of classiﬁers that it runs on the data. Each classiﬁer tries to recognise the format

for which it has been written. It returns a certainty value in percent.

■ The ﬁrst classiﬁer to successfully recognize the data format (certainty 100%) is used to create a

schema for the table.

■ If no classiﬁer returns 100% certainty, the crawler chooses the one with the highest certainty.

■ Glue automatically detects and decompresses the following compression algorithms:

■ ZIP (for archives containing a single ﬁle)

■ BZIP

■ GZIP

■ LZ4

■ Snappy

55

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Creating table deﬁnitions automatically with crawlers

CSV classiﬁer

■ The built-in CSV classiﬁer parses CSV ﬁle contents to determine the schema for an AWS Glue

table. This classiﬁer checks for the following delimiters:

■ Comma (,)

■ Pipe (|)

■ Tab (\t)

■ Semicolon (;)

■ Ctrl-A (\u0001)

Ctrl-A is the Unicode control character for Start Of Heading.

■ To be classiﬁed as CSV, the table schema must have at least two columns and two rows of

data.

■ The classiﬁer tries to infer the column names from the headers in the CSV ﬁles.

57

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Creating table deﬁnitions automatically with crawlers

Inferring the schema

■ To infer the schema, the crawler reads either the ﬁrst 1,000 records or the ﬁrst megabyte of each

ﬁle.

■ The crawler compares the schemas inferred from all the subfolders and ﬁles, and then creates

one or more tables. When a crawler creates a table, it considers the following factors:

■ Data compatibility to check if the data is of the same format, compression type, and include path.

■ Schema similarity to check how closely similar the schemas are in terms of partition threshold and the

number of diﬀerent schemas.

■ For schemas to be considered similar, the following conditions must be true:

■ The partition threshold is higher than 0.7 (70%).

■ The maximum number of diﬀerent schemas (also referred to as "clusters" in this context) doesn't

exceed 5.

■ To conﬁgure the crawler to ignore the schema similarity and create only one schema, use the

option Create a single schema for each S3 path.

58

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Horizontal table partitioning

■ When deﬁning a table in the data catalog that

is located in S3, the location is given as a
folder, not an individual ﬁle.

■ A query on the table will scan all the ﬁles in the

folder.

■ When a table contains a lot of rows, one would

like to avoid to always scan all the rows.
→ Split the ﬁles of the table by row (horizontal
partitioning)

■ Store the ﬁles in sub-folders.

■ Register each sub-folder with the data catalog.

In this example the data of the sales table is partitioned by
year, by month, and by day.

59

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Horizontal table partitioning

When a crawler crawls the data in the example
on the right,

■ it creates three partition keys which it adds to

the schema:

CREATE EXTERNAL TABLE `sales`(
    ...
PARTITIONED BY (
  `year` string,
  `month` string,
  `day` string)
...

■ it detects that in total there are 4 partitions:

■ sales/year=2019/month=Jan/day=1/

■ sales/year=2019/month=Jan/day=2/

■ sales/year=2019/month=Feb/day=1/

■ sales/year=2019/month=Feb/day=2/

60

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Horizontal table partitioning

The partition keys are like virtual columns that
are added to the table.

To avoid scanning all the ﬁles in a query, you
must use the partition keys in a WHERE clause:

SELECT * FROM sales
WHERE year = 2019 AND month = Jan
      AND ...

This query will only scan the ﬁles in the folder
sales/year=2019/month=Jan/

61

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Horizontal table partitioning

Hive-style partitions

■ In the previous example we named the folders using a particular format key=value, which is

called Hive-style partitions.

■ In many cases we don’t control the folder structure and we may encounter a structure similar to

sales/2019/Jan/1/
sales/2019/Jan/2/
sales/2019/Feb/1/
sales/2019/Feb/2/

■ In this case the crawler names the partition keys partition_1, partition_2, etc. You can rename

them manually in the Glue console.

■ Best practice: Whenever you control the folder structure, use Hive-style partitions.

62

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

Data engineering pipelines

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

A typical data pipeline

To design a data pipeline, work backwards from the data consumers and their requirements:

1. Understand the business objectives and who the data consumers are and their requirements.

2. Determine the types of tools that data consumers will use to access the data.

3. Understand which potential data sources may be available.

4. Determine the types of toolsets that will be used to ingest data.

5. Understand the required data transformations at a high level to take the raw data and prepare

it for data consumers.

64

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data consumers

A company has diﬀerent types of data consumers

■ Business users: Want no-code, graphical tool to visualise data and do high-level queries.

■ Business applications: The data pipeline may be used to power an application, like Spotify

Wrapped that provides users with a summary of their listening habits.

■ Data analyst: Tasked with doing more complex data analysis, digging deeper into large
datasets to answer speciﬁc questions. Generally uses query languages such as SQL.

■ Data scientist: Tasked with creating machine learning models that can identify non-obvious

patterns in large datasets, or make predictions about future behavior based on historical data.
Requires large quantities of diverse datasets that they may reﬁne further.

65

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data consumers

Examples

66

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data sources

To design a pipeline, the data engineer needs to know the following information about a data
source:

■ What source system contains the data (database, ﬁles on a server, existing ﬁles on Amazon S3,

from a streaming source)?

■ If this is internal data, who is the owner of the source system? Who is the owner of the data?

■ What frequency does the data need to be ingested on (continuous streaming/replication,

loading data every few hours, loading data once a day)?

■ What are potential tools that could be used for data ingestion?

■ What is the raw/ingested format of the data (CSV, JSON, native database format, and so on)?

■ Does the data source contain PII or other types of data that is subject to governance

controls? If so, what controls need to be put in place to protect the data?

67

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data sources

Examples

68

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data transformations

Transformation of data may involve:

■ File format optimisations: E.g., convert text ﬁles into a compact format such as Parquet.

■ Data standardisation: E.g., the date of birth of a person may be called DOB, dateOfBirth,

birth_date, etc. The format of the birth date may be stored as mm/dd/yy, dd/mm/yyyy, or in a
multitude of other formats. Standardise column names, types, and formats

■ Data quality checks: Verify data quality (ﬁnd missing values, values that do not conform to

type, implausible values, etc.

■ Data partitioning: Group the data at the physical storage layer by a ﬁeld that is often used in

queries.

■ Data denormalisation: Improve OLAP query performance by pre-joinining tables.

■ Data cataloging: Ensure all the datasets in the data lake are referenced in the data catalog and

add additional business metadata to make them discoverable.

69

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data transformations

Examples

70

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Example high-level architecture of a data pipeline

71

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Services for data ingestion

Two types of data ingestion:

■ Batch ingestion: A set of data is collected over time at the source and then ingested in a batch

job.

■ One-time ingestion

■ Repeated batch ingestion, e.g., every night at 3:00

■ Initial full load

■ Subsequent load of new records only

■ Streaming ingestion: The data is a continuous stream of events that is ingested in real-time.

■ Data source is a publish-subscribe stream processing system.

■ The ingestion tool is another subscriber.

72

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS Database Migration Service (DMS)

■ AWS Database Migration Service (DMS) is a managed migration and replication service.

■ Assesses, converts, and migrates data from a variety of databases.

■ Target may be another database or a data lake in S3.

■ Steps:

1. Create a target database

2. Migrate the database schema

3. Set up the data replication process

4. Initiate a full load

5. Subsequently perform change data capture (CDC) and apply

■ Change data capture: Determine which data that has changed and only transfer the changed

data.

■ Read the database’s transaction log.

■ If the transaction log is not available, add a column to the source data that has an increasing value on

each insert or modiﬁcation.

73

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS Database Migration Service (DMS)

Change data capture (CDC)

■ When we want to ingest data from a database into Parquet ﬁles using CDC, we need to apply
the row-level changes (insert row, update row, delete row) to the existing Parquet ﬁle. In other
words we need a database engine that inserts, updates and deletes rows from Parquet ﬁles.
This is called upsert (from update/insert).

■ Apache Hudi is a software tool that allows us to do that. We can run Hudi on a cluster in the

cloud by using Amazon Elastic MapReduce (EMR).

74

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Amazon Kinesis for streaming data ingestion

There are several Kinesis services that can be used for data ingestion:

■ Kinesis Data Firehose: Ingests streaming data, buﬀers for a conﬁgurable period, then writes
out to a limited set of non-streaming targets (S3, Redshift, Elasticsearch, Splunk, and others).

■ Kinesis Data Streams: Ingests real-time data streams, processing the incoming data with a

custom application and low latency (stream processing).

■ Kinesis Data Analytics: Reads data from a streaming source and uses SQL statements or

Apache Flink code to perform analytics on the stream over a rolling time period (e.g., 5 minute
interval).

■ Kinesis Video Streams: Processes streaming video or audio streams, as well as other time-

serialised data such as thermal imagery and RADAR data.

75

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Amazon Kinesis Data Firehose

76

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Services for transforming data

■ AWS Lambda for light transformations

■ Serverless execution of code (functions)

■ Execution triggered by events or on a schedule

■ AWS Glue Databrew for no-code transformations

■ AWS Glue for serverless processing

■ Python shell (single node)

■ Spark engine (cluster)

■ Amazon EMR for Hadoop ecosystem processing

■ The service launches a cluster of speciﬁed size with preinstalled Hadoop ecosystem software

(Hadoop, Flink, Ganglia, HBase, Hive, Audi, Hue, JupyterHub, Livvy, Mahout, MXNet, OOzie, Phoenix,
Pig, Presto(DB), PrestoSQL, Spark, Sqoop, TensorFlow, Tez, Zeppelin, Zookeeper)

77

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS Glue

1. Create a Glue crawler
that discovers the
schema of the data
source and writes it to
the data catalog.

2. Create a Glue job to
perform the Extract-
Transform-Load.

■ Python script

■ Spark script

■ Visual editor

3. Run the job

■ On demand

■ Triggered by event

■ On a schedule

78

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Services for consuming data

■ AWS Athena for ad-hoc SQL queries in the data lake

■ Amazon Redshift and Redshift Spectrum for data warehousing and data lakehouse

architectures

■ Amazon QuickSight for visualising data

■ Amazon Sagemaker for designing and training machine learning models

79

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS Athena

■ AWS Athena is a service for making ad hoc queries in a data lake using SQL.

■ Relies on Hive SerDes for reading and writing data. Supports CSV, TSV, JSON, Ion, Parquet,

ORC, Avro, Apache WebServer logs, CloudTrail logs, Logstash logs.

■ Data can be written with a CREATE TABLE AS SELECT (CTAS) statement. This supports data

transformations, with the possibility to write the data in a format diﬀerent from the source format.

■ Is based on Presto open source software.

■ Requires that the data ﬁles are registered in the AWS Data Catalog as table.

■ Is a serverless service.

■ Behind the scenes AWS runs a pool of servers that execute queries submitted by users.

■ Users are billed for the amount of data scanned. Price as of 2022-12 is $5.00 per TB of data scanned.

■ Athena console supports

■ Writing SQL Data Manipulation Language (DML) queries.

■ Writing SQL Data Deﬁnition Language (DDL) statements that modify the metadata in the data catalog.

■ Viewing table content and table metadata.

80

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Presto / Trino SQL query engine

■ Around 2012 Facebook had a 300 PB data

warehouse built on Hadoop/HDFS. It used Hive
to make SQL queries on the data, but it was
too slow.

■ Three engineers in the Data Infrastructure
group created Presto, a query engine that
could be used interactively at petabyte scale.

■ 2013-11 Facebook open sources Presto.

■ 2014 Netﬂix reveals that they use Presto on

10 PB of data stored in S3.

■ 2016 Amazon releases Athena service based

on Presto.

■ 2019-01 original Presto developers leave

Facebook, found Starburst. Starburst forks
Presto, calls the fork PrestoSQL. 2020
rebranded to Trino.

Martin Traverso, Dain Sundstrom, David Phillips, and Eric Hwang

at Facebook (left) and Starburst (right)

81

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Trino architecture

■ Written in Java

■ Two types of nodes, a coordinator

and several worker nodes.

■ Coordinator receives query from

client and parses, analyses,
optimises, plans and schedules it.

■ Workers execute the tasks in

parallel. Results are returned to the
coordinator which returns them to
the client.

■ In the AWS Athena service, AWS

continuously runs a server pool with
coordinator and worker nodes.
Servers are fully managed by AWS
and invisible to the user.

82

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Data versioning

Overview

■ When preparing data for analytics or for training of machine learning models, the data may be

transformed many times.

■ There will be many versions of the data with only small diﬀerences.

■ Data engineers want the ability to go back to a previous version of the data.

■ Storing a full copy of the data for each transformation can be prohibitive.

■ Need a possibility to snapshot the data before each transformation step and store only the

deltas.

■ Possible solutions:

■ The backing store in which the data is stored oﬀers snapshot support. E.g., S3 bucket versioning.

■ Store the data in a format that allows to store deltas.

83

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Delta Lake storage framework

■ Delta Lake is a convention for storing relational tables as Parquet ﬁles in an object store where

several versions of a table are stored as deltas.

■ Builds on Hive data lake architecture and conventions.

■ Open Source

■ Developed by DataBricks, the company behind Apache Spark.

■ Supported by Spark, PrestoDB, Flink, Trino, Hive, and libraries for Scala, Java, Rust, Ruby and

Python (works with pandas).

■ Supported features:

■ Diﬀerent versions of a table are stored as deltas, not full copies.

■ Time travel: An application can read any previous version of the table.

■ Concurrent access: Multiple readers and writers of a given table are able to all work on the table at the

same time.

84

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Delta Lake storage framework

How it works

■ Like Hive, the Delta Lake framework

stores data for a table in one or
more Parquet ﬁles in a folder on an
object store (e.g., S3).

■ Optionally the data may be

partitioned into several folders.

■ The Delta Lake frameworks adds a
special folder called _delta_log/
that contains one more more
commit ﬁles.

■ A commit ﬁle is a JSON ﬁle that

contains metadata about a particular
version (=commit) of the table.

■ The commit ﬁles are named

00000.json, 00001.json, 00002.json,
etc.

■ Together, the commit ﬁles form the

transaction log.

85

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Delta Lake storage framework

How it works

■ The transaction log is an ordered record of

every transaction that has ever been performed
on a table since its inception.

■ When a user performs a transformation on a
table, Delta Lake breaks that operation down
into a series of discrete steps composed of
one or more actions. Actions include:

■ Add ﬁle - adds a data ﬁle.

■ Remove ﬁle - removes a data ﬁle.

■ Update metadata - Updates the table’s

metadata (e.g., changing the table’s name,
schema or partitioning).

■ A commit ﬁle contains a series of actions.  and

ﬁnishes always with Commit info. This
contains information around the commit, which
operation was made, from where and at what
time.

{
  "remove": {
    "path": "1.parquet",
    "deletionTimestamp": 1669287503633,
    "dataChange": true,
    "extendedFileMetadata": true,
    "partitionValues": {},
    "size": 2454
  }
}
{
  "add": {
    "path": “2.parquet",
    "partitionValues": {},
    "size": 2454,
    "modificationTime": 1669287505000,
    "dataChange": true,
    "stats": “{\"numRecords\":116, ...}”
  }
}
{
  "commitInfo": {
    "timestamp": 1669287504176,
    "operation": "UPDATE",
    ...
}

86

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Delta Lake storage framework

How it works

■ When a user deletes or overwrites data, Delta

lake adds the description of the deleted data to
the transaction log, but does not delete the
ﬁles containing the data.

■ In the example on the right, after the commit
000001 the root folder still contains the ﬁles
1.parquet and 2.parquet.

■ This allows an application to “time travel” back
to the version of the table before the deletions.

■ If the data is no longer needed, an application

can execute the VACUUM command.

87

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Delta Lake storage framework

How it works

■ Every 10 commits, Delta

Lake saves a checkpoint ﬁle
in Parquet format that
contains the complete state
of the table at that point in
time.

■ This oﬀers applications a

shortcut that avoid
reprocessing all the commits
since the creation of the
table.

■ The applications skips to the
nearest checkpoint and only
processes the commits
made since the checkpoint.

88

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

References

Joe Reis, Matt Housley

Fundamentals of Data Engineering

2022-06

O'Reilly Media

Gareth Eagar

Data Engineering with AWS

2021-12

Packt Publishing

89

IST  |  Data Lakes  |  Academic year 2024/25

 © 2025 HEIG-VD

