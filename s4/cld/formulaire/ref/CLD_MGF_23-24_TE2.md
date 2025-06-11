Commencé le mardi 4 juin 2024, 13:19

État Terminé

Terminé le mardi 4 juin 2024, 14:04

Temps mis 44 min 59 s

Note 42,50 sur 50,00 (85%)

Feedback Pour calculer la note, diviser le nombre de points obtenus par 10 et ajouter 1.

QUESTION 11
Correct

Note de 2,00 sur 2,00

Ce cours

Quand on déploie une application sur Google App Engine standard environment avec automatic scaling, l'algorithme de scaling utilise un
certain nombre de métriques pour prendre ses décisions. Sélectionner lesquelles.

a. Le temps que les requêtes HTTP attendent dans une ﬁle d'attente avant d'être traîtées par une instance 

b. L'utilisation CPU des instances 

c. La consommation mémoire des instances

d. Le nombre de requêtes traîtées simultanément dans les instances 

Your answer is correct.

Les réponses correctes sont : L'utilisation CPU des instances, Le temps que les requêtes HTTP attendent dans une ﬁle d'attente avant d'être
traîtées par une instance, Le nombre de requêtes traîtées simultanément dans les instances

QUESTION 22
Terminé

Note de 10,00 sur 10,00

Carole a à sa disposition plusieurs serveurs avec des caractéristiques identiques et un logiciel de base de données NoSQL. Si elle installe le
logiciel sur un serveur elle obtient une base de données avec une capacité de stockage de 1 TO, une capacité de lecture de 1000 lectures/s (si
toutes les requêtes sont des lectures) et une capacité d’écriture de 1000 écritures/s (si toutes les requêtes sont des écritures).

Carole veut créer une base de données qui est capable de stocker au moins 2.5 TO de données.

(A) Combien de serveurs et quel mécanisme(s) de la base de données utilise-t-elle ?
(B) Quelle est la capacité de stockage effective de la base de données ?
(C) Combien de lectures par seconde sont possibles dans le meilleur des cas ? Dans le pire des cas ? Expliquer le meilleur et le pire des cas.

A) Comme Carole a une base de données NoSQL, elle peut faire du scaling horizontal. Comme les serveurs ne peuvent pas stocker plus de 1 TO
de données, la base de données va devoir être séparée en plusieurs parties, cela s'appelle du sharding. Carole a donc besoin de 3 serveurs, ce
qui fait 3TO en tout (> 2.5TO dont elle a besoin). La base de données va être coupée en plusieurs parties et chaque partie va être distribuée sur
un serveur. Cela s'apparente à un système d'encyclopédie où les déﬁnitions sont stockées dans des volumes différents, par exemple de A-C, de
D-F, ... Ici, on va utiliser une fonction de hachage pour déterminer comment séparer les données entre les différents serveurs.

B) Techniquement, la base de données a une capacité de stockage de 3TO (puisque 3 serveurs)

C) Dans le meilleur cas, les serveurs ne reçoivent aucune autre requête que des lectures et les requêtes sont distribuées entre tous les serveurs
de manière homogène. On a donc 3000 lectures par secondes possibles.

Dans le pire cas, toutes le requêtes concernent des données qui sont stockées sur le même  serveur et le nombre de lecture par seconde
possible est de 1000 lectures par seconde.

Solution:

• (A) 3 serveurs utilisant le partitionnement/sharding
• (B) 3 fois 1 To = 3 To
• (C)

◦ Meilleur cas 3000 lectures par seconde: les lectures sont uniformément distribuées entre les données et donc entre les serveurs
◦ Pire cas 1000 lectures par seconde: les lectures vont toutes vers la même donnée et donc vers le même serveur

Commentaire :

QUESTION 33
Correct

Note de 2,00 sur 2,00

Adèle a développé et déployé une application web en Java sur Google App Engine standard environment. Elle veut ajouter du code qui a besoin
d'une bibliothèque Java courante qui ne fait pas partie du JDK. Sélectionner les propos corrects.

a. Elle déclare la bibliothèque comme dépendance dans le ﬁchier app.yaml et Google App Engine se charge de télécharger la bibliothèque

et ses dépendances.

b. Elle n'a pas besoin de déclarer la bibliothèque comme dépendance car Google App Engine reconnaît automatiquement l'utilisation de la

bibliothèque dans le code et télécharge la bibliothèque et ses dépdendances.

c. Elle déclare la bibliothèque comme dépendance dans le ﬁchier pom.xml et Maven se charge de télécharger la bibliothèque et ses



dépendances.

d. Elle déclare la bibliothèque comme dépendance dans la console de Google App Engine et Google App Engine se charge de télécharger

la bibliothèque et ses dépdendances.

Your answer is correct.

La réponse correcte est : Elle déclare la bibliothèque comme dépendance dans le ﬁchier pom.xml et Maven se charge de télécharger la
bibliothèque et ses dépendances.

QUESTION 44
Partiellement correct

Note de 4,50 sur 6,00

Faire les correspondances entre les modèles de données de base de données NoSQL et les propos corrects. Avec "enregistrement" on entend
un objet composé de plusieurs informations, par exemple dans la vente en ligne un article, un client, une commande.>

Modèle
de
données
famille de
colonnes
Modèle
de
données
clé-valeur
Modèle
de
données
orienté
graphe
Modèle
de
données
orienté
document









Les informations d'un enregistrement sont opaques pour la base de données.

Les informations d'un enregistrement sont structurées en paires clé-valeur.

Le modèle de données prévoit non seulement des enregistrements, mais aussi explicitement des relations entre les enregistrements.

Les informations d'un enregistrement sont organisées dans une structure hiérarchique.

Your answer is partially correct.

Vous en avez sélectionné correctement 2.
J'ai manuellement ajouté 1.5 points si vous avez répondu à "Modèle de données clé-valeur" avec "Les informations d'un enregistrement sont
structurées en paires clé-valeur."

La réponse correcte est : Modèle de données famille de colonnes → Les informations d'un enregistrement sont structurées en paires clé-valeur.,
Modèle de données clé-valeur → Les informations d'un enregistrement sont opaques pour la base de données., Modèle de données orienté
graphe → Le modèle de données prévoit non seulement des enregistrements, mais aussi explicitement des relations entre les enregistrements.,
Modèle de données orienté document → Les informations d'un enregistrement sont organisées dans une structure hiérarchique.

Commentaire :

QUESTION 55
Correct

Note de 2,00 sur 2,00

Dans une entreprises Chloé et Diane sont deux ingénieures cloud responsables pour le déploiement et l'administration des applications de
l'entreprise sur AWS. Chloé utilise l'outil aws sur la ligne de commande et automatise les taches en écrivant des scripts simples. Diane utilise
l'outil Terraform et écrit des ﬁchiers .tf. Sélectionner les propos corrects.

a. La manière de travailler de Diane s'appelle approche impérative.

b. Diane utilise le principe de Desired State Conﬁguration et doit donc intervenir manuellement pour maintenir l'état désiré.

c. La manière de travailler de Chloé est plus adaptée à des infrastructures complexes.

d. Chloé doit indiquer dans les scripts comment arriver à un état désiré tandis que Diane déﬁnit l'état désiré sans indiquer comment y



arriver.

Your answer is correct.

La réponse correcte est : Chloé doit indiquer dans les scripts comment arriver à un état désiré tandis que Diane déﬁnit l'état désiré sans indiquer
comment y arriver.

QUESTION 66
Incorrect

Note de 0,00 sur 2,00

Sélectionner les propos corrects sur le déploiement d'applications Java sur Google App Engine standard environment avec automatic
autoscaling comme vu dans le laboratoire.

a.

Il y a deux processus de build: un sur la machine locale pour tester le code en local et un dans le cloud de Google pour créer les
binaires qui sont utilisés pour faire tourner l'application dans Google App Engine.



b. C'est Google App Engine qui fournit et met à jour le JDK sur lequel tourne l'application et c'est le développeur qui doit fournir et met à

jour le serveur d'application web.

c. On peut déployer des applications Java quelconques tant qu'elles peuvent être buildés avec Maven et un ﬁchier pom.xml. 

d. Quand le développeur ajoute une nouvelle fonctionnalité au code et veut déployer une nouvelle version il doit d'abord créer une nouvelle

image de machine virtuelle sur sa machine locale.

Your answer is incorrect.

Les réponses correctes sont : C'est Google App Engine qui fournit et met à jour le JDK sur lequel tourne l'application et c'est le développeur qui
doit fournir et met à jour le serveur d'application web., Il y a deux processus de build: un sur la machine locale pour tester le code en local et un
dans le cloud de Google pour créer les binaires qui sont utilisés pour faire tourner l'application dans Google App Engine.

QUESTION 77
Correct

Note de 2,00 sur 2,00

Sélectionner les propos corrects sur les bases de données distribuées qui utilisent single-leader replication.

a. Le leader et les followers sont toujours situés dans le même data center.

b. Les lectures peuvent seulement se faire sur le leader.

c. Toutes les opération d'écriture sont faites sur le leader et ensuite répliquées sur les followers. 

d. La base de données peut continuer de fonctionner même si un follower tombe en panne. 

Your answer is correct.

Les réponses correctes sont : Toutes les opération d'écriture sont faites sur le leader et ensuite répliquées sur les followers., La base de données
peut continuer de fonctionner même si un follower tombe en panne.

QUESTION 88
Correct

Note de 2,00 sur 2,00

Indiquer quelles manipulations peuvent être réalisées avec Terraform.

a. Création d'un nouveau compte Linux sur une instance EC2.

b. Attachement d'un volume AWS EBS à une instance EC2. 

c. Changement du type d'instance d'une instance EC2. 

d. Sur une instance EC2 contenant un serveur d'application web et une base de données, démarrer le serveur d'application et stopper la

base de données.

Your answer is correct.

Les réponses correctes sont : Changement du type d'instance d'une instance EC2., Attachement d'un volume AWS EBS à une instance EC2.

QUESTION 99
Partiellement correct

Note de 0,67 sur 2,00

Sur un cluster Kubernetes on peut déployer des objets Deployment. Sélectionner les propos corrects.

a. Grâce à un Deployment on peut mettre à jour le code d'une application sans interrompre le service pour les utilisateurs. 

b. Dans la spéciﬁcation d'un Deployment la partie template: contient une spéciﬁcation de Pod.

c. La création d'un objet Service nécessite que l'on ait créé un objet Deployment avant.

d. Un objet Deployment veille constamment que le nombre de Pods spéciﬁé soit en bonne santé.

Your answer is partially correct.

Vous en avez sélectionné correctement 1.
Les réponses correctes sont : Grâce à un Deployment on peut mettre à jour le code d'une application sans interrompre le service pour les
utilisateurs., Dans la spéciﬁcation d'un Deployment la partie template: contient une spéciﬁcation de Pod., Un objet Deployment veille
constamment que le nombre de Pods spéciﬁé soit en bonne santé.

QUESTION 1100
Correct

Note de 2,00 sur 2,00

Dans Google App Engine standard environment avec automatic scaling peut survenir un démarrage à froid (cold start). Sélectionner les propos
corrects.

a. C'est le délai que subit une requête quand une nouvelle instance d'application doit être démarrée. 

b. C'est quand la conﬁguration ininitale d'une application part à zéro au lieu d'utiliser un template.

c. C'est quand Google App Engine redémarre une machine virtuelle.

d. C'est quand Google App Engine arrête une instance d'application non utilisée.

Your answer is correct.

La réponse correcte est : C'est le délai que subit une requête quand une nouvelle instance d'application doit être démarrée.

QUESTION 1111
Correct

Note de 2,00 sur 2,00

Sélectionner les propos corrects sur une "entity" dans le Google Datastore.

a. Une entity est identiﬁée par une clé unique dans la base de données. 

b. Une entity est une collection de paires clé/valeurs où chaque clé est unique dans l'entity. 

c. Une entity est un schéma qui déﬁnit la structure des données dans la base de données.

d. Une entity est un identiﬁcateur unique pour chaque enregistrement dans la base de données.

Your answer is correct.

Les réponses correctes sont : Une entity est une collection de paires clé/valeurs où chaque clé est unique dans l'entity., Une entity est identiﬁée
par une clé unique dans la base de données.

QUESTION 1122
Correct

Note de 2,00 sur 2,00

Google App Engine standard environment dans sont mode automatic scaling est capable de passer à l'échelle zéro (scale to zero). Sélectionner
les propos corrects. Passer à l'échelle zéro, c'est ...

a. augmenter le nombre d'instances d'application pour assurer zéro temps d'arrêt.

b.

réduire le nombre d'instances d'application à zéro quand elles ne sont pas utilisées pour réduire les coûts. 

c. assurer zéro perte de donnés pendant la mise à l'échelle.

d. optionnel. Pour le désactiver on spéciﬁe le paramètre min_instances plus grand que zéro. 

Your answer is correct.

Les réponses correctes sont : réduire le nombre d'instances d'application à zéro quand elles ne sont pas utilisées pour réduire les coûts.,
optionnel. Pour le désactiver on spéciﬁe le paramètre min_instances plus grand que zéro.

QUESTION 1133
Correct

Note de 2,00 sur 2,00

On a trois serveurs que l'on veut conﬁgurer avec Ansible. On exécute la commande

ansible-playbook p.yml

avec un ﬁchier hosts qui contient

[webservers]
a
b
c

et un ﬁchier p.yml qui contient

- name: playbook
  hosts: webservers
  become: True
  tasks:
    - name: One
      apt: name=nginx
    - name: Two
      apt: name=mysql-server
    - name: Three
      apt: name=apache2

On suppose qu'Ansible ne rencontre pas d'erreurs.

Indiquer l'ordre d'exécution des tâches, x.y signiﬁant tâche y exécutée sur serveur x:

a. en parallèle a.One a.Two a.Three, puis en parallèle b.One b.Two b.Three, puis en parallèle c.One c.Two c.Three

b. en parallèle a.One b.One c.One, puis en parallèle a.Two b.Two c.Two, puis en parallèle a.Three b.Three c.Three 

c. séquentiellement a.One, puis a.Two, puis a.Three, puis b.One, puis b.Two, puis b.Three, puis c.One, puis c.Two, puis c.Three

d. en parallèle a.One a.Two a.Three b.One b.Two b.Three c.One c.Two c.Three

Your answer is correct.

La réponse correcte est : en parallèle a.One b.One c.One, puis en parallèle a.Two b.Two c.Two, puis en parallèle a.Three b.Three c.Three

QUESTION 1144
Partiellement correct

Note de 1,33 sur 2,00

Sur un cluster Kubernetes on peut déployer des objets Pod. Sélectionner les propos corrects.

a. Un Pod peut seulement communiquer avec les Pods qui se trouvent sur le même nœud, pour les autres nœuds il faut utiliser un Service.

b. Les conteneurs d'un Pod seront toujours placés sur le même nœud. 

c. Pour qu'un Pod qui est tué et relancé garde la même adresse IP on peut utiliser des adresses IP élastiques.

d. Un conteneur peut contenir un ou plusieurs Pods. 

Your answer is partially correct.

Vous avez sélectionné trop d’options.
La réponse correcte est : Les conteneurs d'un Pod seront toujours placés sur le même nœud.

QUESTION 1155
Correct

Note de 4,00 sur 4,00

Apparenter les modules Ansible avec les descriptions correctes.

Installe un paquetage de logiciel sur la machine gérée.

Démarre ou stoppe un programme en tache de fond sur la machine gérée.

Transfère un ﬁchier de la machine locale à la machine gérée.

Transfère un ﬁchier de la machine locale à la machine gérée et applique des substitutions de variables.

apt

service

copy

template









Your answer is correct.

La réponse correcte est : Installe un paquetage de logiciel sur la machine gérée. → apt, Démarre ou stoppe un programme en tache de fond sur
la machine gérée. → service, Transfère un ﬁchier de la machine locale à la machine gérée. → copy, Transfère un ﬁchier de la machine locale à la
machine gérée et applique des substitutions de variables. → template

QUESTION 1166
Terminé

Note de 4,00 sur 6,00

Ben veut déployer une application web (Wordpress) avec plusieurs Pods repliqués sur un cluster Kubernetes. Il a écrit plusieurs ﬁchiers manifest
(format YAML) pour déployer son application, dont le ﬁchier en bas, mais quand il essaie de se connecter à l'application avec le navigateur, il n'y
a pas de connexion.

apiVersion: v1
kind: Service
metadata:
  name: wordpress-service
spec:
  selector:
    app: wordpress
    tier: frontend
    v: 1.3
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
   type: LoadBalancer

Aider Ben dans le dépannage en supposant qu'il y a un souci dans les ﬁchiers manifest qu'il a écrit. Donner deux pistes prometteuses de choses
à vériﬁer.

-Il peut vériﬁer que ses pods fassent bien partie du service wordpress-service. Pour cela, il faut qu'ils aient les bons labels liés au service. Si ce
n'est pas le cas, le service ne redirigera pas les requêtes vers les pods, qui n'y réponderont donc pas.

-Il peut vériﬁer que les requêtes soient faites sur le bon port.

-Comme Ben veut répliquer des pods sur le cluster, il a, à priori, écrit un ﬁchier de deployment, il faut vériﬁer que celui-ci ne contiennent pas
d'erreurs (nombre d'instances voulues, ...)

Solution:

• Vériﬁer que les Pods ont les trois labels app: wordpress, tier: frontend et v: 1.3 spéciﬁés dans le selector du service.
• Vériﬁer que les Pods écoutent au port 9376 spéciﬁé dans le targetPort du service.

ou aussi à cause d'une coquille dans la donnée:

• Le paramètre type est mal indenté.

Commentaire :
détails sur les ports?

◄ TRAVAIL ÉCRIT 1, 23 AVRIL 2024 KOESTLI

Aller à…

TRAVAIL ÉCRIT 2, 4 JUIN 2024 KOESTLI, NASCIMENTO SANTOS, NAIMI ►


