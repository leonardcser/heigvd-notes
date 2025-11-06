#set page(flipped: true, margin: 0.55cm, columns: 4)
#set columns(gutter: 2% + 0pt)

#set par(
  leading: 0.45em,
  spacing: 0.45em,
  first-line-indent: 1.8em,
  justify: true,
)
#set text(font: "New Computer Modern", size: 8pt)
#show raw: set text(font: "New Computer Modern Mono", size: 8pt)
#show heading.where(level: 2): it => (
  block(spacing: 0.5em) + box(strong(it.body) + [ ])
)
#show heading.where(level: 3): it => (
  block(spacing: 0.5em) + box(strong(it.body) + [ ])
)

// Params
#let title = "Forulaire - GOD"
#let author = "Leonard Cseres"
#let today = datetime.today().display("[month repr:long] [day], [year]")

// Custom function
#let divider = {
  h(1em)
  line(length: 100%, stroke: 0.2pt)
}
#let divider-dotted = {
  h(1em)
  line(length: 100%, stroke: (thickness: 0.5pt, dash: "dotted"))
}

#rect(width: 100%, stroke: 0.4pt, inset: (x: 0% + 6pt, y: 0% + 6pt))[
  #text(size: 12pt, weight: "semibold")[#title]\
  #text(size: 8pt, weight: "semibold")[#author | #today]
]


=== PI
L'ensemble des droits accordés à des créations intellectuelles

=== PI littéraire et artistique

- moraux
- partimoniaux

=== PI industrielle

1. nouveauté
2. caractère inventif
3. application industrielle

=== Brevet
Titre de PI

=== Copyleft
Allowed to use but must use the same original license


#divider-dotted

=== CC Properties
- BY: attribution (always)
- SA: share alike (derivatives) ($-$ combined licenses difficult)
- ND: no derivatives ($-$ data preprocessing friction)
- NC: no commercial use ($-$ not compatible Wikipedia)

=== CC Licenses
- BY (CC-BY 4.0)
- BY SA
- BY ND
- BY NC
- BY NC SA
- BY NC ND

CC licenses cannot be changed after creation for the same content under license

=== CC0

Fully open, for facts or data. (no attribution)

TODO public domain dedication and public domain mark

#divider

=== Cardre legal
Vaud (LRrD), Suisse (LPD, LRH), Europe (RGPD or GDPR in eng.)

- LRH: ...recheche sur l'être humain
- RGPD: ...règlemennt euro. sur la protection des données.

#divider-dotted

=== Data Management Plan (DMP)

=== 1. Plan
- gestion de projet
- responsable de données

=== 2. Collect
- is/how data is reused
- file formats
- how data is collected
- data integrity/reproducibility

=== 3. Organize/analyse
- filenames
- sorting
- languages

=== 4. Preserve/archive
- how long to preserve
- how is data saved
- rule:
  - 3: copies of data
  - 2: storage media
  - 1: copy stored offsite
  - 1: offline immutable
  - 0: errors/backup verification

=== 5. Publish/share

- FAIR (Easy to find, Accessible, Interoperable, Reusable)

=== 6. Reuse

- What do do with data after
- Who is responsible
- Does data need to be cleaned

#divider

=== Personal Data
- Information linked to a physical person identified or identifiable
- Direct identification (name, last name)
- Indirect identification (identification nb., phone, biometric data, physical
  info, ip, ...) data)

=== Sensible Data
Political opinions/religious/philo., health/biometric, sex, military, pregnancy,
condamnations

=== Non-sensible Data
Name/last name, birth date, address, banking data

=== Data Processing
Any type of data handling

=== Anonymise
Modify in an irreversible way

=== Pseudo-anonymise
Break the link between the person and their data without additional information

=== Préposé fédéral protection données transparence (PFPDT)
- Monitor data processing from federal admission, state companies and private
  firms
- Advises them for projects
- Has the names of the "conseillers à la protection des données" (Portail
  DPO/conseiller DPO)
- Investigates whether companies follow the rules
- Receives data breaches announcements

#divider-dotted

=== Registre des traitements (LPD)
1. qui est le responsable
2. quel est le but du traitement
3. qui sont les personnes concernées et les données personnelles traitées
4. qui sont les destinataires
5. combien de temps seront conservées les données
6. quelles mesures ont été prises pour garantir la sécurité des données
7. si transmission à l’étranger : dans quel état et quelles garanties il offre

=== Annonces de violation de sécurité
- Violation of high risk for the personality or fundamental rights of the
  concerned people
- Announce to PFPDT
- Concerned people need to be averted if it is necessary for their protection

#divider-dotted

=== Legal Basis
- Application of GDPR: CEPD ou EDPB (comité Européen de la Protection des
  Données)
- French speaking autorities
  - France: CNIL (commission nationale informatique et libertés)
  - Belgique: CPVP
  - Luxenbourg: CNDP
  - Suisse: le Préposé fournit un guide GDPR

=== GDPR conformity

1. Create a registry of our data processing
  - written medium
  - communicated to whoever asked if public sector, else not obligated
  - Tenir 2 registres (recommandation de la CNIL)
  - Forme:
    1. Objectif
    2. Data category
    3. Who has access
    3. How long are they processed, then archived
2. Sort our data
  - What data does the company really need?
  - Is sensible data processed, are they allowed?
3. Respect personal rights
  1. droit d'accès
  2. de rectification
  3. d'opposition
  4. d'effacement
  5. droit à la portabilité
  6. droit à la limitation du traitement
  - Transparency:
    - Why we collect
    - Why we can process
    - Who has access
    - How long are they conserved
    - How can we exert our right
    - What is the legal basis
4. Secure our data
  - Dépendent de la sensibilité des données et des risques pour les personnes



=== Analyse Impact Protection Données (AIPD)
- AIPD = PIA, Privacy Impact Assessment
- *Before* collecting data
- Why: identify risks

#v(0.5em)

At least 2 of the following points:
#v(0.5em)

1. Évaluation d’aspects personnels ou notation d’une personne (exemple : score
  financier)
2. Exclusion du bénéfice d’un droit, d’un service ou contrat (exemple : liste
  noire)
3. Prise de décision automatisée
4. Surveillance systématique de personnes (exemple : télésurveillance)
5. Traitement de données sensibles (exemples : santé, biométrie)
6. Traitement de données concernant des personnes vulnérables (exemple :
  mineurs)
7. Traitement à grande échelle de données personnelles
8. Croisements d’ensembles de données
9. Usages innovants ou nouvelles technologies (exemple : objet connecté)

High risk -> consult PFPDT or conseiller DPO

#divider

- *DSA* = Digital Services Act (août 2023)
  - obligations pour combattre la désinformation et la haine en ligne, protéger
    la liberté d’expression, limiter les recommandations, etc.
- *DMA* = Digital Markets Act (mars 2024)
  - assurer une concurrence équitable, ne pas enfermer les utilisateurs dans une
    plateforme
  - interdiction de croiser sans consentement des données collectées à travers
    différentes plateformes d’une même société pour le ciblage publicitaire
- Ce sont deux nouvelles législations européennes pour protéger les citoyens
  - concernent 20 à 25 très grandes entreprises
    - réseaux sociaux, places de marché, moteurs de recherche (inclus GAFAM)
    - liste évolutive selon le nombre d’utilisateurs dans l’UE (> 45 millions)

#divider

=== Formulaire de Collecte

Les informations recueillies sur ce formulaire sont enregistrées dans un fichier
informatisé par *[identité et coordonnées du responsable de traitement]* pour
*[finalités du traitement]*. La base légale du traitement est *[base légale du
traitement]*.

Les données collectées seront communiquées aux seuls destinataires suivants :
*[destinataires des données]*.

Les données sont conservées pendant *[« durée de conservation des données prévue
» ou « critères permettant de la déterminer »]*.

Vous pouvez accéder aux données vous concernant, les rectifier, demander leur
effacement ou exercer votre droit à la limitation du traitement de vos données.
*(en fonction de la base légale, mentionner : « Vous pouvez retirer à tout
moment votre consentement au traitement de vos données » ; « Vous pouvez
également vous opposer au traitement de vos données » ; « Vous pouvez également
exercer votre droit à la portabilité de vos données »)*

Consultez le site cnil.fr pour plus d’informations sur vos droits.

Pour exercer ces droits ou pour toute question sur le traitement de vos données
dans ce dispositif, vous pouvez contacter *(le cas échéant, « notre délégué à la
protection des données » ou « le service chargé de l’exercice de ces droits ») :
[adresse électronique, postale, coordonnées téléphoniques, etc.]*
