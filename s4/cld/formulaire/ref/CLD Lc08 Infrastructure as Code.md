HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud Computing —

Infrastructure as Code

Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication






Provisioning of complex cloud infrastructures































































 























Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25



      



       

       
         





        

     

       

         



   

  









      





 

     







2




         


 
     
      
         
















        


      


 © 2025 HEIG-VD





   

   

       





      



          



HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Provisioning of complex cloud infrastructures

Infrastructure as Code

■ You are a DevOps engineer tasked with

provisioning the infrastructure on the previous
slide.

■ Not only are you asked to provision this
infrastructure for production, but the
developers want a separate, but identical
infrastructure for integration testing and your
DevOps colleagues want another environment
for load and end-to-end testing.

■ Clicking through the AWS Management

console doesn’t cut it.

■ You start to write scripts. You quickly realise
you need to wait for resources to provision,
you need to manage dependencies, and the
scripts become really complex.

■ There must be a better way…

ec2.sh

#!/bin/bash

IP_ADDRESS="10.2.2.1"

EC2_INSTANCE=$(ec2-run-instances --instance-type
t2.micro ami-0edab43b6fa892279)

INSTANCE=$(echo ${EC2_INSTANCE} | sed 's/*INSTANCE //'
| sed 's/ .*//')

# Wait for instance to be ready
while ! ec2-describe-instances $INSTANCE | grep -q
"running"
do

echo Waiting for $INSTANCE is to be ready...

done

# Check if instance is not provisioned and exit
if [ ! $(ec2-describe-instances $INSTANCE | grep -q
"running") ]; then

echo Instance $INSTANCE is stopped.
exit

fi

ec2-associate-address $IP_ADDRESS -i $INSTANCE

echo Instance $INSTANCE was created successfully!!!

3

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Infrastructure as Code

Deﬁnition

■ Traditionally infrastructure has been provisioned and managed by manual conﬁguration, custom

shell scripts, machine images or interactive conﬁguration tools.

■ Infrastructure as Code (IaC) instead relies on deﬁnition ﬁles processed by conﬁguration

management tools.

■ Thus infrastructure is treated like software: as code that can be managed with the same tools

and processes software developers use

■ Version Control

■ Continuous Integration

■ Code Review

■ Automated testing

Source: https://www.crisp-research.com/wp-content/uploads/2016/07/Infrastructure-as-Code.png

4

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Infrastructure as Code

Tools

5

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Infrastructure as Code

Tools

Cloud provisioning tools

Server templating
tools

Conﬁguration management tools

6

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deploying infrastructure for an application

Availability zone a

HTTP

Browser

7

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

Availability zone b

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deploying infrastructure for an application

Provisioning of cloud resources

Availability zone a

Instance 1

HTTP

Browser

Load balancer

Database
primary

Database
secondary

Instance 2

Availability zone b

8

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deploying infrastructure for an application

Deployment of software

Availability zone a

HTTP

Browser

Load balancer

Instance 1

Drupal

Apache

Logstash

Drupal

Apache

Logstash

Instance 2

Database
primary

Database
secondary

9

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

Availability zone b

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Infrastructure as Code

Categories of tools

■ Cloud Provisioning tools

■ These tools deploy cloud resources from description ﬁles

■ Some tools support a single provider, some support multiple providers

■ Conﬁguration Management tools

■ These tools install and conﬁgure software on physical or virtual machines

■ Are able to maintain a deﬁned state

■ Use concept of Desired State Conﬁguration and are idempotent

■ Server Templating tools

■ These tools create machine or container images for pre-installed software and dependencies

■ Images are stored in image repositories (e.g., AWS AMI registry, DockerHub)

■ Images are a form of software packaging

10

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud provisioning
Ways to create cloud resources

The management
console of a cloud is
just a web application
in front of the REST
API of the cloud’s
control plane.

Web
interface

REST API

Control plane

create, start, stop, attach, delete, ...

Cloud resources:
virtual machines,
virtual disks,
load balancers,
...

11

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud provisioning
Ways to create cloud resources

As a principle all
functions of the web
interface are also
available directly in
the API. This enables

■ Command-line
interface (CLI)

■ Scripts by using

libraries

■ Cloud provisioning

tools

CLI
Scripts
Cloud
provisioning
tools

Web
interface

REST API

Control plane

create, start, stop, attach, delete, ...

Cloud resources:
virtual machines,
virtual disks,
load balancers,
...

12

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud provisioning
Ways to create cloud resources

Most cloud providers
also provide cloud
provisioning as a
service in their
management console
(e.g., AWS
CloudFormation)

CLI
Scripts
Cloud
provisioning
tools

Web
interface

Cloud
provisioning
service

REST API

Control plane

create, start, stop, attach, delete, ...

Cloud resources:
virtual machines,
virtual disks,
load balancers,
...

13

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud provisioning
AWS CloudFormation

Concepts:

■ Template — Text ﬁle containing a description of

cloud resources in JSON or YAML. Multiple
resources can be deﬁned in a single ﬁle and the
resources can be conﬁgured to work together via
references.

■ Stack — A stack is a set of related resources

managed as a unit (create/update/delete). All the
resources in a stack are deﬁned by the stack’s
template. For example a stack may contain an Auto
Scaling Group, Load Balancer and RDS database.

■ Change set — If you need to make changes to the
running resources in a stack, you update the stack.
Before making changes to your resources, you can
generate a change set, which is a summary of your
proposed changes. Change sets allow you to see
how your changes might impact your running
resources, especially for critical resources, before
implementing them.

AWSTemplateFormatVersion: "2010-09-09"
Description: A sample template
Resources:
  MyEC2Instance:
    Type: "AWS::EC2::Instance"
    Properties:
      ImageId: "ami-0ff8a91507f77f867"
      InstanceType: t2.micro
      KeyName: testkey
      BlockDeviceMappings:
        -
          DeviceName: /dev/sdm
          Ebs:
            VolumeType: io1
            Iops: 200
            DeleteOnTermination: false
            VolumeSize: 20
  MyEIP:
    Type: AWS::EC2::EIP
    Properties:
      InstanceId: !Ref MyEC2Instance

14

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Cloud provisioning
Other cloud-speciﬁc tools

CloudFormation can only manage AWS resources. Other clouds have similar proprietary tools. Be
cautious of vendor lock-in!

Provisioning tool

Remarks

AWS

CloudFormation

JSON or YAML

Azure

Azure Resource Manager

Google Cloud Deployment Manager

YAML or Python

OpenStack

Heat

Compatible with CloudFormation

15

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Overview

■ Software tool for provider-independent cloud

provisioning created by HashiCorp

■ Open Source

■ Written in Go

■ Initial release 2014-07

■ Supported cloud providers:

■ AWS

■ Azure

■ Google Cloud Platform

■ Kubernetes

■ Oracle Cloud Infrastructure

■ Alibaba Cloud

■ OpenStack

■ VMware vSphere

■ …

16

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Introduction

Concepts:

■ Conﬁguration ﬁle — Describes cloud resources.

Terraform is able to manage low-level components
such as compute instance, storage and networking,
as well as high-level components such as DNS
entries and SaaS features. File extension .tf.
Proprietary format.

■ Execution plan — Terraform generates an

execution plan describing what it will do to reach
the desired state, and then executes it to build the
described infrastructure. As the conﬁguration
changes, Terraform is able to determine what
changed and create incremental execution plans
which can be applied.

■ Resource graph — Terraform builds a graph of all

resources, and parallelizes the creation and
modiﬁcation of any non-dependent resources.

General syntax of resources in conﬁguration ﬁle:

resource "<PROVIDER>_<TYPE>" "<NAME>" {
  [CONFIG ...]
}

Deﬁnition of an AWS EC2 instance:

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

Deﬁnition of a Security Group:

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

17

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Introduction

Concepts (continued):

■ Backend — The cloud platform managed by

Terraform

■ Provider — Plugin that talks to a speciﬁc backend

through the backend API

■ Resource graph — Terraform builds a graph of all

resources, and parallelises the creation and
modiﬁcation of any non-dependent resources.

18

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Introduction

Terraform

Conﬁguration
ﬁle main.tf

Terraform state ﬁle
terraform.tfstate

Admin

calculate
diﬀerence

Diﬀerence

calculate
plan

Plan

l

n
i
-
g
u
p
r
e
d
v
o
r
P

i

Allocated
cloud resources

read

Cloud
provider
API

create
update
delete

19

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Principle of Desired State Conﬁguration

Infrastructure-as-Code tool

Description of
desired
state

Description of
current state

Admin

calculate
diﬀerence

Reconciliation
loop

■ Most Infrastructure-as-Code tools
work according to the principle of
Desired State Conﬁguration.

■ The admin does not tell the tool

what to do, but the desired state.

Diﬀerence

calculate
plan

List of change
operations

■ The tool determines the diﬀerence
between the desired state and the
current state. From that diﬀerence it
then determines what to do (the
necessary change operations).

Existing resources

read

create
update
delete

■ The tool implements a reconciliation
loop which is executed once. The
admin has to trigger it.

20

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Commands

Common commands:

■ terraform init

Prepares the working directory for other commands.

■ Creates .terraform directory to store plugins, the currently active workspace, the last known

backend conﬁguration, etc.

■ Downloads plugins

■ Accesses state in the backend

■ terraform validate

Checks whether the conﬁguration is valid.

■ terraform plan

Shows changes required by the current conﬁguration without executing them.

■ terraform apply

Executes changes to update infrastructure or creates infrastructure if it does not exist yet.

■ terraform destroy

Destroys previously-created infrastructure.

21

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Example

■ In a new directory create a template ﬁle main.tf that contains

provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

■ Run

$ terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (terraform-providers/aws) 2.10.0...
[...]
Terraform has been successfully initialized!

22

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Example

$ terraform plan
[...]
Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0c55b159cbfafe1f0"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      [...]
  }

Plan: 1 to add, 0 to change, 0 to destroy.

23

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Example

$ terraform apply
[...]
Terraform will perform the following actions:

  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                          = "ami-0c55b159cbfafe1f0"
      + arn                          = (known after apply)
     [...]
  }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.example: Creating...
aws_instance.example: Still creating... [10s elapsed]
aws_instance.example: Still creating... [20s elapsed]
aws_instance.example: Still creating... [30s elapsed]
aws_instance.example: Creation complete after 38s [id=i-07e2a3e006d785906]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

24

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Example

■ Modify the template ﬁle main.tf to give a name to the EC2 instance

provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = “t2.micro"

  tags = {
    Name = "terraform-example"
  }

}

25

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Terraform

Example

$ terraform apply

aws_instance.example: Refreshing state...
(...)

Terraform will perform the following actions:

  # aws_instance.example will be updated in-place
  ~ resource "aws_instance" "example" {
        ami                          = "ami-0c55b159cbfafe1f0"
        availability_zone            = "us-east-2b"
        instance_state               = "running"
        (...)
      + tags                         = {
          + "Name" = "terraform-example"
        }
        (...)
    }

Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:

26

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management

27

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management

■ You are a DevOps engineer tasked with

deploying several identically conﬁgured web
servers. Each server runs two web apps.

■ You need to install and conﬁgure Apache, two
Apache modules, the two apps (directly from
their GitHub repositories), numerous runtime
packages as well as packages for logging and
monitoring. In total more than 30 steps.

■ Manual installation becomes impractical.

■ Maybe shell scripts help?

Web server

Apache

mod_php

mod_passenger

Drupal

Discourse

php-common

ruby

php-mysql

php-…

mysql-client

logstash

monitoring-
plugins

28

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management

The problem of entropy

Machine life cycle

Build

Rebuild

Entropy

Initialize

Clean

Conﬁgured

Unknown

Debug

Retire

29

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management

The problem of entropy — multiplied

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

System
administrator

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

Server

30

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management

Why needed?

■ Deﬁnition of Conﬁguration Management: Managing the conﬁguration of (complex) server

software stacks: operating system, middleware, applications

■ Issues with manual conﬁguration

■ Too easy to make mistakes

■ Changes not guaranteed to be reproducible

■ Does not scale to many servers

■ No documentation of what was changed

■ Issues with shell scripts:

■ The script assumes that the machine is in a certain state. If that is not the case, the script breaks.

■ When a script breaks in the middle of execution, it leaves the machine in a semi-conﬁgured, undeﬁned

state. Need to manually restore a clean state before re-running the script.

■ Unix commands have very disparate sets of options (not a problem with PowerShell).

31

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Desired-State Conﬁguration

Deﬁnition

■ Desired-State Conﬁguration: You do not need to tell the tool what to do. Instead, you specify the
state in which you wish the system to be, and the tool will automatically decide the actions to
take to reach the desired state, or as close to it as possible.

■ In programming language terms, we say that the tool's policy language is declarative, as opposed to

imperative.

■ Real-world example: Suppose you move out of your apartment and you hire someone to repaint the

rooms.

■ Imperative: "I want you to take your paint roller, dip it in the paint, and then roll it across this area and this

area and this …”

■ Declarative: “I want all walls to be uniformly white.” The painter then reconciles what color your walls are now
(darker areas here and there), what color you want it to be (uniform white), and how to get there (open a paint
can, pour it in a tray, dip the roller in the paint tray, roll across the dark areas, etc.).

■ Examples of declarative conﬁguration:

■ "Make sure ﬁle /etc/ssh/sshd_config contains the line UseDNS	no"

■ "Make sure user mysql exists/does not exist"

■ "Make sure process httpd is (not) running”

32

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Idempotent commands

Deﬁnition

■ Commands that work according to desired state are idempotent. An idempotent command can

be run over and over again, and will always give the same result.

■ Most commands and scripts are not idempotent. They assume they are run once to set up a

system and afterwards the system is maintained manually.

■ Example: ssh-keygen for creating a public/private key pair for authentication in SSH

■ When run the ﬁrst time it will create a new key pair for the user. The user will then install the public key in

various servers to have password-less authentication.

■ When run a second time it will overwrite the existing key pair with a new one → authentication with the

servers is broken.

■ An idempotent command will

■ accept a desired state as input,

■ determine the current state of the system,

■ compare it with the desired state and determine the actions needed to bring it to the desired state,

■ carry out the actions.

33

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management

Tools overview

■ 1993 CFEngine

■ Written by Mark Burgess at Oslo University in
Norway to automate the conﬁguration of Unix
systems

■ 2002 CFEngine 2

■ Convergent conﬁguration

■ 2005 Puppet

■ Inspired by CFEngine 2

■ 2009 CFEngine 3

■ Promise theory

■ 2009 Chef

■ Inspired by Puppet

■ 2012 Ansible

■ 2016 SaltStack

34

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management Architectures

CFEngine 3: client/server, agent-based

Source: Diego Zamboni, Learning CFEngine 3, O’Reilly Media
35

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management Architectures

Puppet: client/server, agent-based

Control node

Puppetmaster

Puppet has a
client-server architecture:
Puppet agent = client
Puppetmaster = server

System
administrator

Puppet protocol

Managed node

Puppet agent

Managed node

Puppet agent

Load balancer

Web server

Managed node

Puppet agent

Application
server

Managed node

Puppet agent

Database

Managed nodes must be prepared by installing Puppet agent.

36

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Conﬁguration Management Architectures

Ansible: agentless

Control
node

Run ansible-playbook
command

System
administrator

There is no server or database

SSH protocol

Managed node

Ansible script

Managed node

Ansible script

Load balancer

Web server

Managed node

Ansible script

Application
server

Managed node

Ansible script

Database

No special software must be installed on managed nodes. No agents need to run.
Ansible injects Python scripts on the ﬂy.
Uses existing Python interpreter and SSH.

37

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deployment example

Introduction

■ The following example will be used to compare

manual deployment, shell scripts and
conﬁguration management tools

■ Deploy two simple websites on two servers

■ Both servers run Ubuntu 22.04 LTS

■ Web server is nginx

■ “Puppy" website shows HTML page with photo

of a puppy

■ On ﬁle system photo ﬁle must have owner:group

of puppy:puppy

■ “Kitty" website shows HTML page with photo of

a kitty

■ On ﬁle system photo ﬁle must have owner:group

of kitty:kitty

■ Photos and HTML pages are in a GitHub

repository.

38

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deployment example

Shell script for puppy server

#!/bin/bash
#
#	puppy.sh	-	Install	and	configure	puppy	server

#	Update	metadata	of	APT	packages
apt-get	update
#	Install	nginx	web	server	with	APT
apt-get	install	nginx	--assume-yes
#	Download	photo	to	the	web	server	document	root
wget	https://raw.github.com/nanobeep/tt/master/puppy.jpg	\
					--output-document=/usr/share/nginx/html/puppy.jpg
#	Create	the	puppy	user	and	puppy	group
useradd	--user-group	puppy
#	Change	the	photo's	ownership	and	permission
chown	puppy:puppy	/usr/share/nginx/html/puppy.jpg
chmod	664	/usr/share/nginx/html/puppy.jpg
#	Download	the	HTML	page
wget	https://raw.github.com/nanobeep/tt/master/index.html	\
					--output-document=/usr/share/nginx/html/index.html
#	Embed	the	photo	in	the	HTML	page
sed	--in-place	's/baby/puppy/'	/usr/share/nginx/html/index.html
#	Run	the	web	server
/etc/init.d/nginx	start

File index.html.j2

<html>
				<body	bgcolor="gray">
								<center>
												<img	src="/{{baby}}.jpg">
								</center>
				</body>
</html>

39

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deployment example

Shell script for kitty server

#!/bin/bash
#
#	kitty.sh	-	Install	and	configure	kitty	server

#	Update	metadata	of	APT	packages
apt-get	update
#	Install	nginx	web	server	with	APT
apt-get	install	nginx	--assume-yes
#	Download	photo	to	the	web	server	document	root
wget	https://raw.github.com/nanobeep/tt/master/kitty.jpg	\
					--output-document=/usr/share/nginx/html/kitty.jpg
#	Create	the	kitty	user	and	kitty	group
useradd	--user-group	kitty
#	Change	the	photo's	ownership	and	permission
chown	kitty:kitty	/usr/share/nginx/html/puppy.jpg
chmod	664	/usr/share/nginx/html/kitty.jpg
#	Download	the	HTML	page
wget	https://raw.github.com/nanobeep/tt/master/index.html	\
					--output-document=/usr/share/nginx/html/index.html
#	Embed	the	photo	in	the	HTML	page
sed	--in-place	's/baby/kitty/'	/usr/share/nginx/html/index.html
#	Run	the	web	server
/etc/init.d/nginx	start

40

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Deployment example

Ansible

Inventory ﬁle inventory

[puppy]
puppy.dev

[kitty]
kitty.dev

Playbook ﬁle puppykitty.yml

- name: Base layer common to puppy and kitty node
  hosts: all # apply the tasks below to all nodes

  tasks:
  - name: Ensure NGINX is installed.
    apt:
      name: nginx
      state: present
      update_cache: yes # update package catalog before install
...

41

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

- name: Configuration specific to puppy node
  hosts: puppy

  vars:
    baby: puppy # define variable named baby

  tasks:
  - name: Ensure puppy group is present.
    group:
      name: puppy
      state: present

  - name: Ensure puppy user is present and member of puppy group
    user:
      name: puppy
      state: present
      group: puppy

  - name: Ensure puppy.jpg is present.
    get_url:
      url: https://raw.github.com/nanobeep/tt/master/puppy.jpg
      dest: /usr/share/nginx/html/puppy.jpg
      owner: puppy
      group: puppy
      mode: 664

  - name: Run index.html.j2 through template engine to produce index.html.
    template:
      src: files/index.html.j2
      dest: /usr/share/nginx/html/index.html
...

- name: Configuration specific to kitty node
  hosts: kitty

  vars:
    baby: kitty # define variable named baby

  tasks:
  - name: Ensure kitty group is present.
    group:
      name: kitty
      state: present

  - name: Ensure kitty user is present and member of kitty group.
    user:
      name: kitty
      state: present
      group: kitty

  - name: Ensure kitty.jpg is present.
    get_url:
      url: https://raw.github.com/nanobeep/tt/master/kitty.jpg
      dest: /usr/share/nginx/html/kitty.jpg
      owner: kitty
      group: kitty
      mode: 664

  - name: Run index.html.j2 through template engine to produce index.html.
    template:
      src: files/index.html.j2
      dest: /usr/share/nginx/html/index.html

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible

Overview

■ Automation engine for cloud provisioning,

conﬁguration management and application
deployment

■ Open Source

■ Written in Python

■ Initially written by Michael DeHaan

■ 2012-02 Ansible Inc. releases initial version

■ 2015-02 Michael DeHaan leaves Ansible

■ 2015-10 Red Hat acquires Ansible Inc.

■ The name “Ansible" references a ﬁctional

instantaneous hyperspace communication
system.

44

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

Ansible will make SSH connections in parallel to web1, web2, and web3. It will exe‐

cute  the  first  task  on  the  list  on  all  three  hosts  simultaneously.  In  this  example,  the

first task is installing the nginx apt package (since Ubuntu uses the apt package man‐

ager), so the task in the playbook would look something like this:

- name: install nginx

  apt: name=nginx

Ansible will:

1. Generate a Python script that installs the nginx package.

2. Copy the script to web1, web2, and web3.

3. Execute the script on web1, web2, web3.

4. Wait for the script to complete execution on all hosts.

Ansible  will  then  move  to  the  next  task  in  the  list,  and  go  through  these  same  four
steps. It’s important to note that:

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

• Ansible runs each task in parallel across all hosts.

Ansible Playbooks

Example

• Ansible waits until all hosts have completed a task before moving to the next task.

• Ansible runs the tasks in the order that you specify them.

■ Example: Conﬁgure three servers with nginx

■ Ansible user Stacy writes a playbook called

webservers.yml

■ Contains four tasks: (1) install nginx, (2) generate

conﬁg ﬁle, (3) copy security certiﬁcate, (4)
(re)start nginx

■ Stacy runs

ansible-playbook	webservers.yml

■ Ansible makes SSH connections in parallel to

web1, web2 and web3

■ Executes each task in parallel across all hosts

■ Waits until each task has completed before

moving on to the next task

■ Runs the tasks in the order speciﬁed in the

playbook

45

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

Figure 1-1. Running an Ansible playbook to configure three web servers

4

|

Chapter 1: Introduction

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Example

■ Let’s zoom in on a task. The ﬁrst task in the playbook is

-	name:	install	nginx
		apt:	name=nginx

■ To execute this task, Ansible

■ generates a Python script that installs the nginx package (by using the apt package manager);

■ copies the script to web1, web2, and web3;

■ executes the script on web1, web2, web3;

■ waits for the script to complete execution on all hosts.

■ These four steps are repeated for all tasks in the playbook.

46

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Host inventory ﬁle

■ The collection of hosts that Ansible knows

File hosts

about is called the inventory.

■ The default way to describe hosts is to list
them in a text ﬁle, called inventory ﬁle.

■ Convention is to call the ﬁle hosts.

■ Hosts can be grouped and a conﬁguration can

be applied to a whole group.

■ Group names appear in brackets [	].

■ Hosts belonging to a group follow the group

name.

■ If needed, attributes can be added to a host

■ E.g., to tell SSH how to connect to the host (IP

address, port number, user account)

■ Or for any other info that can be used by a

playbook

ontario.example.com
newhampshire.example.com
maryland.example.com
...

File hosts with groups

[production]
delaware.example.com
georgia.example.com
[staging]
ontario.example.com
quebec.example.com
[loadbalancer]
delaware.example.com
[webservers]
georgia.example.com
newhampshire.example.com
newjersey.example.com

47

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Anatomy of a playbook

■ Plays

■ A playbook is a list of plays (in the

example a single play).

■ A play must contain:

■ A set of hosts to conﬁgure (hosts)

■ A list of tasks to execute (tasks)

■ Optionally it may contain

■ A comment that describes what

the play is about (name)

■ A ﬂag indicating whether tasks
should be run as sudo (sudo)

■ A list of variables and values

(vars)

k
o
o
b
y
a
P

l

1

y
a
P

l

2
y
a
P

l

3

y
a
P

l

- name: Base layer common to puppy and kitty node
  hosts: all
  tasks:
  - name: Ensure NGINX is installed.
    apt:
      name: nginx
      state: present
      update_cache: yes

- name: Configuration specific to puppy node
  hosts: puppy
  tasks:
  - name: Ensure puppy group is present.
    group:
      name: puppy
      state: present
  ...

- name: Configuration specific to kitty node
  hosts: kitty
  tasks:
  - name: Ensure kitty group is present.
    group:
      name: kitty
      state: present
  ...

48

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Anatomy of a playbook

■ Tasks

■ A task typically starts with a comment that
describes what the task is about (name)

■ Optional, but highly recommended

■ Every task must contain a key with the name of
a module and a value with the arguments to that
module.

■ In the example the module is apt and the

arguments are
name:	nginx
update_cache:	yes

■ Arguments are a dictionary.

- name: Install NGINX
  apt:
    name: nginx
    update_cache: yes

49

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Anatomy of a playbook

■ Modules

■ Modules are scripts that come packaged with Ansible and perform some kind of action on a host.

■ Some of the most-often used modules:

■ sdfsdf

■ apt - Installs or removes packages using the apt package manager.

■ yum - Installs or removes packages using the yum package manager.

■ copy - Copies a ﬁle from the control node to the managed node.

■ get_url - Downloads a ﬁle from the web to the managed node.

■ template - Generates a ﬁle from a template and copies it to the managed node.

■ lineinfile - Ensures a particular line is in a ﬁle.

■ replace - Replaces all instances of a particular string in a ﬁle using a back-referenced regular expression.

■ file - Sets the attribute of a ﬁle, symlink, or directory.

■ service - Starts, stops, or restarts a service.

■ user - Manages OS user accounts.

■ command - Executes command-line command on managed node. Avoid if possible.

■ debug - Prints statements during execution for debugging.

50

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Modules

■ There are currently over 3’000 modules.

■ Ansible is extensible: the user can write her

own modules.

■ Modules that ship with Ansible are written in
Python, but modules can be written in any
language.

■ Complete module reference at

http://docs.ansible.com/ansible/
modules_by_category.html

51

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

template

Generates a file from a template and copies it to the hosts.

Viewing Ansible Module Documentation

Ansible ships with the ansible-doc command-line tool, which shows documentation

about modules. Think of it as man pages for Ansible modules. For example, to show

the documentation for the service module, run:

$ ansible-doc service

If you use Mac OS X, there’s a wonderful documentation viewer called Dash that has

support  for  Ansible.  Dash  indexes  all  of  the  Ansible  module  documentation.  It’s  a

commercial tool ($19.99 as of this writing), but I find it invaluable.

Recall  from  the  first  chapter  that  Ansible  executes  a  task  on  a  host  by  generating  a
custom script based on the module name and arguments, and then copies this script
to the host and runs it.

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Anatomy of a playbook

There  are  over  200  modules  that  ship  with  Ansible,  and  this  number  grows  with
every release. You can also find third-party Ansible modules out there, or write your
own.

■ Summary:

■ A playbook contains one or more plays.

Putting It All Together
To sum up, a playbook contains one or more plays. A play associates an unordered set
of hosts with an ordered list of task_. Each task is associated with exactly one module.

■ A play associates an unordered set of hosts with

an ordered list of tasks.

■ Each task is associated with exactly one

Figure  2-3  is  an  entity-relationship  diagram  that  depicts  this  relationship  between
playbooks, plays, hosts, tasks, and modules.

module.

Figure 2-3. Entity-relationship diagram

52

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

Anatomy of a Playbook

|

35

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Modules

Manipulation of conﬁguration ﬁles — Templates

■ A powerful way to specify conﬁguration ﬁles is

File templates/ngingx.conf.j2

by using templates.

■ A template is just a text ﬁle that has some
special syntax for specifying variables that
should be replaced by values.

■ Places where variables are to be inserted are

marked by double braces {{	}}.

■ You probably know templates from web

programming.

■ Ansible uses the Jinja2 template engine

■ Similar to Mustache, ERB, or the Django

template system

■ Naming convention is to place templates in

directory called templates and add suﬃx .j2
to ﬁlename.

server {
    listen 80 default_server;
    listen [::]:80 default_server
ipv6only=on;

    root /usr/share/nginx/html;
    index index.html index.htm;

    server_name {{ server_name }};
    ssl_certificate {{ cert_file }};
    ssl_certificate_key {{ key_file }};

    location / {
        try_files $uri $uri/ =404;
    }
}

53

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Playbooks

Loops

■ Sometimes a task needs to be repeated to process several items. For example if we want to

install several packages with the apt module.

■ We can use a placeholder variable {{	item	}} for the package to install, and then add a list of

packages for which the task should be repeated (list must be called with_items).

■ Example:

■ Install a single package:

-	name:	Update	repositories	cache	and	install	"foo"	package
						apt:
								name:	foo
								update_cache:	yes

■ Install several packages:

-	name:	Update	repositories	cache	and	install	several	packages
						apt:
								name:	"{{	item	}}"
								update_cache:	yes
						with_items:
								-	package1
								-	package2
								-	package3

54

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

More info: Ansible Docs > Playbooks > Loops

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Roles

Modular Playbooks

■ Ansible Roles help a developer to decompose

Playbooks into independent, reusable
components.

■ Think, e.g., packages in Java or namespaces in

C++

■ To create a Role, create a directory roles and
inside, create a directory with the name of the
role.

■ Inside, create directories for ﬁles, templates,

tasks, handlers, variables and meta-information.

■ A Role can be included in a play. Example play
where the two roles common and webservers
are included:
---
-	hosts:	webservers
		roles:
		-	common
		-	webservers

(project root)

site.yml

webservers.yml

fooservers.yml

roles/

common/

ﬁles/

main.yml

other.yml

templates/

main.yml

tasks/

main.yml

handlers/

main.yml

vars/

main.yml

meta/

main.yml

webservers/

ﬁles/

templates/

tasks/

handlers/

vars/

meta/

55

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible Roles

Modular Playbooks

■ When a role is included in a play:

■ If there is a directory tasks/ with a ﬁle

main.yml the tasks listed in that ﬁle will be
added to the play.

■ If there is a directory handlers/ with a ﬁle

main.yml the handlers listed in that ﬁle will be
added to the play.

■ If there is a directory vars/ with a ﬁle main.yml
the variables listed in that ﬁle will be added to
the play.

■ If there is a directory meta/ with a ﬁle main.yml
any role dependencies listed in that ﬁle will be
added to the play.

■ Any copy, script, template or include tasks
in the role can reference ﬁles in the files/,
templates/or tasks/directory directly without
having to specify a path.

■ If any ﬁles are not present, they are just
ignored. So it’s ok to not have a vars/

(project root)

site.yml

webservers.yml

fooservers.yml

roles/

common/

ﬁles/

main.yml

other.yml

templates/

main.yml

tasks/

main.yml

handlers/

main.yml

vars/

main.yml

meta/

main.yml

webservers/

ﬁles/

templates/

tasks/

handlers/

vars/

meta/

56

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Ansible

Conclusion

■ Compared to other Conﬁguration Management tools:

■ Easy-to-read syntax

■ Nothing to install on the remote hosts (agentless)

■ Push-based

■ Simple conﬁgurations are simple, complex conﬁgurations are possible

■ Built-in modules with predeﬁned tasks

■ Modules are idempotent

■ Very thin layer of abstraction

57

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

Server management models
Pets vs. cattle

■ Model A: Servers are like pets

■ Model B: Servers are like cattle

■ Pets are given names like
pussinboots.acme.com

■ Cattle are given numbers like

vm0042.acme.com

■ They are unique, lovingly hand raised and

■ They are almost identical to other cattle

cared for

■ When they get ill, you nurse them back to

health

■ When they get ill, you get another one

Source: Gavin McCance, CERN, http://www.slideshare.net/gmccance/cern-data-centre-evolution, original idea @randybias at Cloudscaling
58

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

References

Lorin Hochstein, Rene Moser

Ansible: Up and Running, 2nd Edition

Automating Conﬁguration Management and
Deployment the Easy Way

2017-05

O’Reilly Media

Matt Jaynes

Taste Test — Puppet, Chef, SaltStack, Ansible

3d ed.

2015

https://valdhaus.co/books/taste-test-puppet-
chef-salt-stack-ansible.html

Kief Morris

Infrastructure as Code

Managing Servers in the Cloud

2016-06

O’Reilly Media

59

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD

HEIG-VD  |  TIC – Technologies de l’Information et de la Communication

References

Yevgeniy Brikman

Terraform: Up & Running

2nd ed.

2019-09

O'Reilly Media

60

Cloud Computing  |  Infrastructure as Code  |  Academic year 2024/25

 © 2025 HEIG-VD


