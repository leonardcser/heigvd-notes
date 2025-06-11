Cloud Computing — Container cluster
management and orchestration

Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Software containers

Containers vs Virtual Machines

■ Public Infrastructure-as-a-Service clouds typically rely on Hypervisors.

■ On the servers in its datacenter the cloud provider creates Virtual Machines. VMs provide isolated

compute resources that the provider can resell to diﬀerent customers.

■ Recently Software Containers (e.g., Docker) have emerged as an alternative to Virtual Machines.

■ They provide isolation similar to Virtual Machines but are much more eﬃcient. Economically very

attractive for cloud providers.

2

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Containers

OS-level virtualization

■ In OS-level virtualization, a process or a set of processes is called a container.

■ A container is run directly on the Host OS and has the following characteristics:

■ Access to resources (CPU/RAM/IO) is:

■ Limited and prioritized → How much CPU can be used right now?

■ Accounted → How much CPU was used over the past hour?

■ Visibility of available resources is limited → How many CPUs are in the System?

■ Root ﬁlesystem is independent of other containers and Host OS. → Each container has its own “/”.

■ Containers are isolated from each other securely, no communication between them is possible

(unless per conﬁguration).

■ A common container technology: Docker

3

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Software containers

Containers vs Virtual Machines

App X

App Y

App Z

Libs A

Libs B

Libs B

App X

App Y

App Z

Guest OS

Guest OS

Guest OS

Libs A

Libs B

Virtual machine 1

Virtual machine 2

Virtual machine 3

Container 1

Container 2

Container 3

Hypervisor

Host OS

Hardware

Container Engine

Host OS

Hardware

Three VMs running on a single host

Three containers running on a single host

4

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Software containers

Building a container image and uploading it to a container registry

Container registry

■ Docker Hub

■ GitHub Container

Registry

■ Amazon Elastic

Container Registry

■ Azure Container

Registry

■ Google Artifact

Registry

Source: http://blog.octo.com/en/docker-registry-ﬁrst-steps/

5

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Container cluster management

Introduction

Why container cluster management?

■ Suppose you have implemented an application in a number of containers. You want to go into

production.

■ Need to create containers and connect them between each other.

■ Putting all containers on a single host is not robust: when the host fails all containers fail.

→ Want to deploy on many hosts with communication between the containers.

■ Want to be able to deploy a new version without service interruption.

■ Want to be able to take a host down for maintenance without service interruption.

■ Want to make sure that containers are healthy at all times.

→ Need to monitor containers for good health and relaunch if failing: container failure
management

■ And if you are a big company you want to be clever about the placement of containers on hosts

to use as few hosts as possible while still giving enough resources to each application.

6

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Container cluster management

Container scheduling

■ The placement of application containers on cluster nodes is called scheduling.

■ Containers have diﬀerent resource requirements (CPU, memory, disk, …)

■ Containers that cooperate tightly need to be placed on the same node (aﬃnity)

■ Containers of an app that uses redundancy need to be placed on diﬀerent nodes (anti-aﬃnity)

■ Goals:

■ Increase cluster utilization.

■ Still meet the application constraints.

An ocean of user containers

Container
scheduling

Scheduled and packed dynamically
onto nodes

7

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Introduction

■ Platform for automating deployment, scaling and

management of containerized applications.

■ Open Source project, initially written and

designed by Google

■ Kubernetes v. 1.0 released 2015

■ At the same time Google and the Linux Foundation
create the Cloud Native Computing Foundation
(CNCF) and transfer Kubernetes to it.

■ Borrows heavily from Google’s long experience

with managing containers, namely Google’s Borg
System.

■ Has received lots of support from other

companies and become the industry standard for
container cluster management and orchestration.

■ Used by companies to build a private cloud and

by cloud providers to oﬀer a public service.

■ Reduces problem of vendor lock-in for cloud

customers.

Kubernetes (κυβερνήτης): Greek
for "helmsman" or "pilot",
pronounced 'koo-ber-nay'-tace'

AWS

Azure

Elastic Kubernetes Service

Managed Kubernetes Service

Google Cloud Kubernetes Engine

8

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deploying an app: IaaS vs Kubernetes

IaaS

■ Launch a virtual machine.

■ Connect to the VM via SSH.

■ Install application on VM.

■ Create VM image from VM.

■ Create load balancer.

■ To launch more VMs from VM image create a
Launch Template and an Autoscaling Group.

■ Connect VMs to load balancer.

Kubernetes

■ On local machine, create container image for

app using Docker and Dockerﬁle.

■ Upload container image to a container

registry.

■ Write a Kubernetes manifest ﬁle in YAML
that describes a Pod that will contain your
container.

■ Launch the Pod (with the container) using

the command line:
kubectl create -f pod.yaml

■ To launch multiple replicas of your container,

write a Deployment manifest.

■ For load balancing, write a Service manifest.

9

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Console

10

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

Large-scale cluster management at Google with Borg

Abhishek Verma†

Luis Pedrosa‡ Madhukar Korupolu

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

David Oppenheimer

Eric Tune

John Wilkes

Container orchestration

Google Borg

Google Inc.

Abstract

■ In 2015 Google publishes a paper on their Borg

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

■ Needs to place new tasks at a rate of 10’000

■ Uses 10-14 CPU cores and up to 50 GB RAM

cluster manager

Google’s Borg system is a cluster manager that runs hun-
dreds of thousands of jobs, from many thousands of differ-
ent applications, across a number of clusters each with up to
■ Borgmaster

tens of thousands of machines.

■ Used internally since around 2005

■ Manages 10’000 machines

It achieves high utilization by combining admission con-
trol, efﬁcient task-packing, over-commitment, and machine
tasks per minute

sharing with process-level performance isolation. It supports
high-availability applications with runtime features that min-
imize fault-recovery time, and scheduling policies that re-
duce the probability of correlated failures. Borg simpliﬁes
life for its users by offering a declarative job speciﬁcation
language, name service integration, real-time job monitor-
ing, and tools to analyze and simulate system behavior.

We present a summary of the Borg system architecture
and features, important design decisions, a quantitative anal-
ysis of some of its policy decisions, and a qualitative ex-
amination of lessons learned from a decade of operational
experience with it.
11

1.

Introduction

The cluster management system we internally call Borg ad-

mits, schedules, starts, restarts, and monitors the full range

of applications that Google runs. This paper explains how.

Borg provides three main beneﬁts: it (1) hides the details

of resource management and failure handling so its users can

focus on application development instead; (2) operates with

very high reliability and availability, and supports applica-

tions that do the same; and (3) lets us run workloads across

tens of thousands of machines effectively. Borg is not the

ﬁrst system to address these issues, but it’s one of the few op-

erating at this scale, with this degree of resiliency and com-

pleteness. This paper is organized around these topics, con-

† Work done while author was at Google.

‡ Currently at University of Southern California.

Permission to make digital or hard copies of part or all of this work for personal or

classroom use is granted without fee provided that copies are not made or distributed

for proﬁt or commercial advantage and that copies bear this notice and the full citation

on the ﬁrst page. Copyrights for third-party components of this work must be honored.

For all other uses, contact the owner/author(s).

EuroSys’15, April 21–24, 2015, Bordeaux, France.

Copyright is held by the owner/author(s).

ACM 978-1-4503-3238-5/15/04.

http://dx.doi.org/10.1145/2741948.2741964

Figure 1: The high-level architecture of Borg. Only a tiny fraction
> 100’000 jobs

of the thousands of worker nodes are shown.

>10’000 machines

> 1’000 types of applications

cluding with a set of qualitative observations we have made
from operating Borg in production for more than a decade.

 © 2025 HEIG-VD

2. The user perspective

Borg’s users are Google developers and system administra-

tors (site reliability engineers or SREs) that run Google’s

applications and services. Users submit their work to Borg

in the form of jobs, each of which consists of one or more

tasks that all run the same program (binary). Each job runs

in one Borg cell, a set of machines that are managed as a

unit. The remainder of this section describes the main fea-

tures exposed in the user view of Borg.

2.1 The workload

Borg cells run a heterogenous workload with two main parts.

The ﬁrst is long-running services that should “never” go

down, and handle short-lived latency-sensitive requests (a

few µs to a few hundred ms). Such services are used for

end-user-facing products such as Gmail, Google Docs, and

web search, and for internal infrastructure services (e.g.,

BigTable). The second is batch jobs that take from a few

seconds to a few days to complete; these are much less sen-

sitive to short-term performance ﬂuctuations. The workload

mix varies across cells, which run different mixes of applica-

tions depending on their major tenants (e.g., some cells are

quite batch-intensive), and also varies over time: batch jobs

web browsersBorgMasterlink shardUI shardBorgMasterlink shardUI shardBorgMasterlink shardUI shardBorgMasterlink shardUI shardCellSchedulerborgcfgcommand-line toolsweb browsersschedulerBorgletBorgletBorgletBorgletBorgMasterlink shardread/UI shardconfig filepersistent store (Paxos)HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Anatomy of a cluster

Source: Wikipedia

12

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Anatomy of a cluster

■ Components in the Master node

(aka Control Plane)

■ etcd — Key/value store keeping the

conﬁguration data of the cluster, representing
the overall state of the cluster at any given
point of time.

■ API Server — Serves the K8s API using

JSON/HTTP (external and internal).

■ Scheduler — Selects which node an

unscheduled Pod should run on based on
resource availability (pluggable).

■ Controller Manager — Process in which
core controllers run, such as Replication
Controller and DaemonSet Controller.

13

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Anatomy of a cluster

■ Components in the Worker nodes
(aka Kubernetes nodes, Minions)

■ Kubelet — Responsible for the running state
of each node, i.e. ensuring that all containers
on the node are healthy.

■ Kube-proxy — A network proxy and load

balancer. Responsible for routing traﬃc to the
appropriate container based on IP and port
number of the incoming request.

■ cAdvisor — Agent that monitors and gathers
resource usage and performance metrics of
the containers.

■ Overlay network — Responsible to connect

containers on diﬀerent nodes on a ﬂat
network. Not part of K8s, pluggable (e.g.,
Flannel, Calico, Weave, …)

14

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Main concepts

■ High-level summary: Kubernetes sits atop of

■ Replication Controller — Handles

a cluster of machines (physical or virtual)
and provides an abstraction of a single
machine.

■ Cluster — Set of machines where Pods are

deployed, managed and scaled.

■ Nodes are connected via a “ﬂat" network.

■ Typical cluster sizes range from 1-200 nodes.

■ Pod — A Pod consists of one or more

containers that are guaranteed to be co-
located on the same machine.

■ Share storage volumes and a networking

stack.

■ A Pod is the basic unit of scheduling.

■ Controller — A controller is a reconciliation
loop that drives actual cluster state toward
the desired cluster state.

replication and scaling by running a speciﬁed
number of copies of a pod across the cluster.

■ Service — Set of Pods that work together,
such as one tier of a multi-tier application.
Kubernetes provides:

■ Service discovery

■ Request routing by assigning a stable IP

address and DNS name

■ Load balancing

■ Label — The user can assign key-value

pairs (called labels) to any API object in the
system (e.g., Pods, nodes).

■ Label selector — A query against a label that

returns matching objects.

15

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Common concepts

■ Kubernetes has a consistent object API

■ The operator can create K8s objects with the
command line or he can describe the objects
in manifest ﬁles.

■  kubectl create -f file.yaml

■ File format is JSON, which can also be written

as YAML

apiVersion:	v1
kind:	Pod
metadata:
		name:	redis
		labels:
				component:	redis
				app:	todo
spec:
		containers:
		-	name:	redis
				image:	redis
				ports:
				-	containerPort:	6379
				resources:
						limits:
								cpu:	100m
				args:
				-	redis-server
				-	--requirepass	ccp2
				-	--appendonly	yes

16

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

YAML

Overview

■ YAML (Yet Another Markup Language) is a ﬁle

format similar in intent to JSON.

■ Only two basic data structures: arrays and

dictionaries, which can be nested

■ YAML is a superset of JSON

■ Easier for humans to read and write than JSON

■ Indentation is signiﬁcant

■ Speciﬁcation at http://yaml.org/

---
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

17

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

YAML

YAML vs JSON

YAML

apiVersion:	v1
kind:	Pod
metadata:
		name:	redis
		labels:
				component:	redis
				app:	todo
spec:
		containers:
		-	name:	redis
				image:	redis
				ports:
				-	containerPort:	6379
				resources:
						limits:
								cpu:	100m
				args:
				-	redis-server
				-	--requirepass	ccp2
				-	--appendonly	yes

JSON

{
				"apiVersion":"v1",
				"kind":"Pod",
				"metadata":	{
								"name":"redis"
								"labels":	{
												"component":"redis"
												"app":"todo",
								},
				},
				"spec":	{
								"containers":	[	{
												"name":"redis",
												"image":"redis",
												"ports":	[
																{
																				"containerPort":6379
																}
												],
												"resources":	{
																"limits":	{
																				"cpu":"100m"
																}
												},
												"args":	[
																"redis-server",
																"--requirepass	ccp2",
																"--appendonly	yes"
												]
								}	]
				}
}

18

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Common concepts

■ Every Kubernetes object description begins

with two ﬁelds:

■ kind: a string that identiﬁes the schema this

object should have

■ apiVersion: a string that identiﬁes the version

of the schema the object should have

■ Every object has two basic structures: Object

Metadata and Speciﬁcation (or Spec).

■ The Object Metadata structure is the same for

all objects in the system

■ name: uniquely identiﬁes this object within the

current namespace

■ labels: a map of string keys and values that

can be used to organize and categorize objects

■ Spec is used to describe the desired state of

the object

apiVersion:	v1
kind:	Pod
metadata:
		name:	redis
		labels:
				component:	redis
				app:	todo
spec:
		containers:
		-	name:	redis
				image:	redis
				ports:
				-	containerPort:	6379
				resources:
						limits:
								cpu:	100m
				args:
				-	redis-server
				-	--requirepass	ccp2
				-	--appendonly	yes

19

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Common concepts

■ When Kubernetes creates the object, it adds

some ﬁelds to the description:

■ uid: unique identiﬁer

■ resourceVersion: an object version number (for

optimistic concurrency control)

■ Status provides read-only information about the

current state of the object

apiVersion:	v1
kind:	Pod
metadata:
		name:	redis
		labels:
				component:	redis
				app:	todo
		resourceVersion:	"439780"
		uid:	145f56fd-ad1b-11e7-9[…]
spec:
		containers:
		-	name:	redis
				image:	redis
				ports:
				-	containerPort:	6379
				resources:
						limits:
								cpu:	100m
				args:
				-	redis-server
				-	--requirepass	ccp2
				-	--appendonly	yes
status:
		hostIP:	172.20.52.100
		phase:	Running
		podIP:	100.96.3.9
		qosClass:	Burstable
		startTime:	2017-10-09T17:55:47Z

20

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Pods

■ The atomic unit of deployment in Kubernetes is

Unit of deployment in Docker: Container

the Pod.

■ A Pod contains one or more containers. The

common case is a single container.

■ If a Pod has multiple containers

■ Kubernetes guarantees that they are scheduled

on the same cluster node.

■ The containers share the same Pod

environment

■ IPC namespace, shared memory, storage

volumes, network stack, etc.

■ IP address

■ If containers need to talk to each other within
the Pod, they can simply use the localhost
interface.

Container

App

172.17.0.3
eth0

lo

cgroups,
namespaces,
...

Unit of deployment in Kubernetes: Pod

Pod

cgroups,
namespaces,
...

Container

Supporting
Container

App

App

172.17.0.3
eth0

lo

21

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Pods

■ The Pod abstraction enables the user to

choose between loosely coupled or tightly
coupled containers.

■ Some example use-cases for tightly coupled

containers:

■ A web container supported by a helper

container that ensures the latest content is
available to the web server.

■ A web container with a log scraper sending the

logs oﬀ to logging service somewhere else.

Tightly-coupled containers

Pod

Container

Container

Loosely-coupled containers

Pod

Pod

Container

Container

22

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Pods

■ Pod deployment atomicity

■ Pods are the minimum unit of scaling.

■ The deployment of  Pod is all or nothing: Either

Pending

the entire Pod comes up and gets put into
service, or it doesn’t and fails.

loss of communication
with the Pod

■ Pod lifecycle

■ When a Pod dies (e.g., a container of the Pod

crashes or the cluster node containing the Pod
crashes) one does not bother to bring it back to
life.

■ Instead Kubernetes starts another one in its place

(new Pod ID and IP address).

■ In the pets vs. cattle model, Pods are treated as

cattle.

Running

all containers
terminated
with success

all containers
terminated,
at least one failure

Succeeded

Failed

Unknown

may trigger
restart of a new Pod

23

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Pod Deﬁnition

apiVersion:	v1
kind:	Pod
metadata:
		name:	www
spec:
		containers:
		-	name:	nginx
				image:	nginx
				volumeMounts:
				-	mountPath:	/srv/www
						name:	www-data
						readOnly:	true
		-	name:	git-monitor
				image:	kubernetes/git-monitor
				env:
				-	name:	GIT_REPO
						value:	http://github.com/some/repo.git
				volumeMounts:
				-	mountPath:	/data
						name:	www-data
		volumes:
		-	name:	www-data
				emptyDir:	{}

Name of Pod

Internal name of the container

in the Pod

Container image name

Environment variable name
and value for the container

(docker run -e
GIT_REPO=... ...)

Volume name and type

24

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Pod usage examples

■ Create a Pod declaratively from a ﬁle

■  kubectl	create	-f	docs/user-guide/walkthrough/pod-nginx.yaml

■ List all Pods

■  kubectl	get	pods

■ Delete Pod by name

■  kubectl	delete	pod	nginx

25

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Environment variables

■ Container images are typically generic images

■ e.g., an unconﬁgured web server or database

■ To conﬁgure a container Docker allows the operator (the user starting
a container from an image) to set environment variables in a new
container

■ By default some variables are automatically added:

■ HOME: as the default user within a container is root, the default homedir is /

■ HOSTNAME: hostname associated with the container

■ PATH: by default includes /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/

sbin:/bin

■ TERM: xterm if the container is allocated a pseudo terminal entry point

(interactive mode only)

■ All the user-speciﬁed variables are added to this list, e.g. “LAB=Docker”

■ Can only be done at container startup time

■ Kubernetes allows setting environment variables in the description of

a Pod

apiVersion:	v1
kind:	Pod
metadata:
		name:	api
		labels:
				component:	api
				app:	todo
spec:
		containers:
		-	name:	api
				image:	icclabcna/ccp2-
k8s-todo-api
				ports:
				-	containerPort:	8081
				resources:
						limits:
								cpu:	10m
				env:
				-	name:	REDIS_ENDPOINT
						value:	redis-svc
				-	name:	REDIS_PWD
						value:	ccp2

26

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

(Pod) Volumes

■ A Pod can have Volumes. A Volume is a ﬁle system in which the application(s) can read/write

ﬁles. A Volume may be persistent or not.

■ Volumes are shared between containers in the same Pod.

■ Lifetime: same as Pod (outlive containers if restarted) unless using persistent volume solutions

from underlying infrastructure

■ Supported types:

■ emptyDir: an empty directory the app can put ﬁles into, erased at Pod deletion

■ hostPath: path from host machine, persisted with machine lifetime

■ gcePersistentDisk, awsElasticBlockStore, azureFileVolume: cloud vendor volumes, independent

lifecycle

■ secret: used to pass sensitive information, such as passwords, to Pods. You can store secrets in the
Kubernetes API and mount them as ﬁles for use by Pods without coupling to Kubernetes directly.
secret volumes are backed by tmpfs (a RAM-backed ﬁlesystem) so they are never written to non-
volatile storage

■ nfs: network ﬁle system, persisted

■ Many more: iscsi, ﬂocker, glusterfs, rbd, gitRepo ...

27

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Persistent Volumes

■ K8S supports mounting (existing or dynamically provisioned) persistent volumes to Pods in two

ways:

■ Directly

■ Through PersistentVolumeClaim (PVC)

apiVersion:	v1
kind:	Pod
metadata:
		name:	test-ebs
spec:
		containers:
		-	image:	icclab/test-webserver
				name:	test-container
				volumeMounts:
				-	mountPath:	/test-ebs
						name:	test-volume
		volumes:
		-	name:	test-volume
				#	This	AWS	EBS	volume
				#	must	already	exist.
				awsElasticBlockStore:
						volumeID:	<volume-id>
						fsType:	ext4

kind:	Pod
apiVersion:	v1
metadata:
		name:	mypod
spec:
		containers:
				-	name:	myfrontend
						image:	dockerfile/nginx
						volumeMounts:
						-	mountPath:	"/var/www/html"
								name:	mypd
		volumes:
				-	name:	mypd
						persistentVolumeClaim:
								claimName:	myclaim

kind:	PersistentVolumeClaim
apiVersion:	v1
metadata:
		name:	myclaim
spec:
		accessModes:
				-	ReadWriteOnce
		resources:
				requests:
						storage:	8Gi
		#	The	cluster	must	have
		#	a	configured	storage
		#	class
		storageClassName:	default

28

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Replication Controller

■ Instead of manual deployment, Pods can also
be deployed via a Replication Controller.

■ A Replication Controller takes a Pod deﬁnition
and deploys a desired number of replicas of it.

■ Instantiates a background loop that checks to

make sure the right number of replicas is always
running (desired state vs. actual state).

Desired number
of replicas

Actual number
of replicas

Replication
Controller

Scaling
instructions

■ However Replication Controllers are slowly

being replaced by Deployments.

d
o
P

d
o
P

d
o
P

d
o
P

d
o
P

Pod replicas

29

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Service

■ When replacing, scaling or upgrading
Pods they receive new IP addresses
every time.

■ Suppose a two-tier app with a front-
end Pods talking to back-end Pods.
The front-end Pods cannot rely on the
IP addresses of the back-end Pods.

■ Services provide a reliable networking

endpoint for a set of Pods.

■ The front-end talks to the reliable IP of

the service.

■ The service also has a domain name

which is identical to the service name.

■ The Service load-balances all requests

over the back-end Pods behind it.

■ The Service keeps track of which Pods

are behind it.

Pod

Pod

Pod

Pod

Front-end

Front-end

Front-end

Front-end

10.0.0.12

10.0.0.83

10.0.0.25

10.0.0.39

Service

IP: 10.0.0.60
DNS: db.myservice

Pod

db:v1

Pod

db:v1

10.0.0.91

10.0.0.44

30

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Service deﬁnition

■ Service Type can be:

■ ClusterIP: use a cluster-internal IP only - this is
the default. Choosing this value means that you
want this service to be reachable only from
inside of the cluster.

■ NodePort: on top of having a cluster-internal IP,
expose the service on a port on each node of
the cluster (the same port on each node). You’ll
be able to contact the service on any
<NodeIP>:NodePort address.

■ LoadBalancer: on top of having a cluster-

internal IP and exposing service on a NodePort
also, ask the cloud provider for a load balancer
which forwards to the Service exposed as a
<NodeIP>:NodePort for each Node.

apiVersion:	v1
kind:	Service
metadata:
		name:	zurmo-apache
spec:
		ports:
				-	port:	80
						protocol:	TCP
						targetPort:	80
		selector:
				name:	apache.zurmo
		type:	LoadBalancer

31

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Service usage examples

■ List all services:

■  kubectl get svc

$	kubectl	get	svc
NAME											CLUSTER-IP							EXTERNAL-IP								PORT(S)								AGE
api-svc								100.68.144.177			<none>													8081/TCP							1d
frontend-svc			100.70.91.125				a02d8179aaaa1...			80:31484/TCP			1d
redis-svc						100.68.15.141				<none>													6379/TCP							1d

IP address
inside the
cluster

IP address
outside the
cluster

Service port
number

Service name.

At the same time
this is the domain
name apps can use
to connect to the
service.

32

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Connecting Pods to a Service via Labels

■ To specify which Pods belong to a service one

uses Labels.

■ Labels are key-value pairs attached to a

Kubernetes object.

■ Key and value can be freely chosen.

■ An object may have several labels. The same

label may be attached to several objects.

■ When deﬁning the Service one speciﬁes a

Label Selector which is a set of conditions on
the label key-values.

Service

IP: 10.0.0.60
DNS: db.myservice

Label selector:
  env=prd
  tier=back
  v=1.3

■ Pods matched by the Label Selector are

connected to the Service.

Pod

db

env=prd

tier=back

v=1.4

Pod

db

env=prd

tier=back

v=1.3

Pod

db

10.0.0.87

10.0.0.91

10.0.0.44

Not selected by Service
because label v
does not match.

Labels

env=prd

tier=back

v=1.3

33

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Deployments

■ Deployments add features and

functionality compared to
Replication Controllers to enable
updating the deployed software
without interrupting the service.

■ Rolling updates

■ Rollbacks

■ Deployments make use of Replica

Sets, which implement control
loops similar to Replication
Controllers.

■ A Deployment may have several
Replica Sets active at the same
time when performing updates or
rollbacks.

Deployment

Deployment Controller

Replica
Set

Replica
Set

d
o
P

v
=
1
.
3

d
o
P

v
=
1
.
3

d
o
P

v
=
1
.
3

d
o
P

v
=
1
.
4

d
o
P

v
=
1
.
4

34

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Deployments

■ Deployments work according to the principle of

Desired State Conﬁguration.

■ The user describes the desired state in a

Deployment object.

■ The Deployment Controller compares the

desired state to the actual state.

■ The Deployment Controller changes the actual
state towards the desired state at a controlled
rate.

■ When the deployment of a new version fails it

is very simple to rollback to a previous working
version.

35

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

In depth: Deployments

■ In a rolling update the service is never

interrupted.

■ To trigger a rolling update the user simply

updates the desired state of the Deployment.

■ For example specify a diﬀerent version of the

Pod image.

■ The Deployment creates a new ReplicaSet.

■ The Deployment Controller creates a new Pod in

the new ReplicaSet, and when successful
terminates a Pod in the old ReplicaSet.

■ This is repeated until no old Pods are left.

Desired state:
3 Pods using
image v.1

Pod
v.1

Pod
v.1

Pod
v.1

Deployment
complete

Change of
desired state:
use image v.2

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.2

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.1

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.1

Pod
v.1

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Pod
v.2

Deployment
progressing

Deployment
complete

36

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Deployment deﬁnition example

apiVersion:	apps/v1beta1
kind:	Deployment
metadata:
		name:	nginx-deployment
spec:
		replicas:	3
		template:
				metadata:
						labels:
								app:	nginx
				spec:
						containers:
						-	name:	nginx
								image:	nginx:1.7.9
								ports:
								-	containerPort:	80

Labels to be applied to
created Pods

37

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Deployment usage examples

■ View Deployment:

■  kubectl get deployments

■ Output:

Number of total replicas running

Number of updated replicas
running (latest spec)

Number of replicas
available to users

NAME															DESIRED			CURRENT			UP-TO-DATE			AVAILABLE			AGE
nginx-deployment			3									0									0												0											1s

■ Check rollout status:

■  kubectl rollout status deployment/nginx-deployment

■ Update by setting a new image version:

■  kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1

■ Update by editing the deployment deﬁnition in an editor:

■  kubectl edit deployment/nginx-deployment

38

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Multi-host networking

Source: https://github.com/coreos/ﬂannel/blob/master/README.md#theory-of-operation

39

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

Multi-host networking

■ On a single machine Docker places all containers are in a private subnet that is bridged with the

host.

■ Every container can talk to each other container directly (no NAT).

■ In a cluster of machines, one wants the containers to be able to move freely without

complicated port forwarding.

■ Still want every container be able to talk to each other container without NAT.

■ → Create an overlay network in software (Software-Deﬁned Network, SDN) that provides a ﬂat

network. Use packet encapsulation.

■ Docker delegates assignment of IP addresses to the SDN.

■ Many options available: Contiv , Flannel , Nuage Networks, OpenVSwitch, OVN , Project Calico,

Romana, Weave Net, …

Source: https://github.com/coreos/ﬂannel/blob/master/README.md#theory-of-operation

40

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes

High-Availability deployment

■ To protect the Kubernetes
cluster from failures of the
Master Node, the Master
Node can be replicated.

■ For example three-way

replication

■ Stateful data store etcd
replicates data on each
node

■ Three load-balanced

instances of stateless API
Server

■ One elected leader instance

of Scheduler

■ One elected leader instance

of Controller Manager

■ kubelet used as monitor to restart any

failing process

■ monit monitors and restarts kubelet

41

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes on IaaS

■ When Kubernetes runs on IaaS it interacts with

IaaS for

■ Load balancing

■ (Dynamic) volume mounting → requires

introduction of persistent volumes

42

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Kubernetes on IaaS

For example Kubernetes on OpenStack

kubectl

Load Balancer

Kube-API

kube-proxy

kube-proxy

kube-proxy

etcd

Controller manager

pod

pod

pod

pod

pod

mount

Volumes

Virtual

VM

VM

VM

VM

kubelet

kubelet

kubelet

Physical

Host

Host

Host

Host

Host

Host

Host

Host

Compute Nodes (Nova)

Block Storage Nodes (Cinder)

43

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Appendix

44

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Container cluster management

Public cloud services

■ As of October 2017 there are three major

public cloud services for container deployment

■ AWS EC2 Container Service

■ Google Container Service

■ Azure Container Service

45

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS EC2 Container Service

Introduction

■ Launched as preview 2014-11, General

Availability 2015-04

■ Creates a cluster out of EC2 instances (virtual

machines)

■ Choose instance type

■ Dynamically scalable

■ Open container format: runs Docker containers

on the cluster.

■ Cluster management and scheduling is

proprietary and closed-source.

■ Cluster instances run Amazon ECS agent (and

Docker daemon)

■ Oﬀers a Web GUI.

■ Container images are stored in container

registry that may be public or private within
AWS (EC2 Container Registry).

46

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

AWS EC2 Container Service

Terminology

■ Cluster – Pool of EC2 instances in a

■ Task Deﬁnition – A JSON ﬁle that deﬁnes a

particular AWS Region, all managed by ECS.

Task as a set of containers. Speciﬁes:

■ One cluster can contain multiple instance

■ Container image

types and sizes, and can reside within one or
more Availability Zones.

■ Scheduler – Assigns containers to instances

in a way that respects any placement
constraints and simultaneously drives as
much parallelism as possible, while also
aiming for high availability.

■ Container – A packaged application

component. Each EC2 instance in a cluster
can serve as a host to one or more
containers.

■ Memory and CPU requirements,

■ Port mappings to enable containers to

communicate with each other.

■ Task – Instantiation of a Task Deﬁnition with

container instances.

■ Service — A service runs and maintains a

speciﬁed number of tasks simultaneously. A
load balancer can be associated with a
service to distribute load across tasks.

■ ECS-Enabled AMI – An Amazon Machine
Image (AMI) that runs the ECS Agent and
dockerd.

48

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google Container Engine

Introduction

■ Announced 2014-11

■ Creates a cluster out of Compute Engine virtual

machines

■ Choose instance type

■ Dynamically scalable

■ Open container format: runs Docker containers

on the cluster.

■ Open cluster management and scheduling:

Kubernetes

■ Container images are stored in container

registry that may be public or private within
Google Cloud (Google Container Registry).

■ Clusters from 0 to 5 nodes are free of charge.

49

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Google Container Engine

Introduction

50

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

References

Nigel Poulton

The Kubernetes Book

2017-07

Leanpub

Kelsey Hightower, Brendan Burns, Joe Beda

Kubernetes: Up and Running

2017-09

O'Reilly Media

51

Cloud Computing  |  Container cluster management and orchestration  |  Academic year 2024/25

 © 2025 HEIG-VD


