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
#let title = "Formulaire - MAC"
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

=== Impedance Mismatch Objet-Relationnel
Disconnect between data layer and application layer

- Solutions: _ORM, NoSQL_

=== NoSQL
- Horizontal scaling
- No schema, fields can be added later
- Easy replication
- Simple API
- Not ACID

=== Column oriented
- Écriture à grande échelle
- Accès aux données co-localisé (pour la lecture et l’écriture)

=== Key-value
- Caches
- Domaine simple avec accès en lecture rapide
- Systèmes massivement concurrents
- Opaque value

#divider-dotted

=== Document oriented
- Suited for agile dev.
- When data modeling follows the structures of natural documents
- No need for migration schema
- No need for ORM layer
- Replicated, each document is independent
- Separation approach: normalized data
  - $+$ Data consistency through a single canonical source
  - $+$ Simpler queries (closer to relational databases)
  - $+$ Better cache efficiency and hardware utilization
  - $-$ Requires multiple lookups and joins
  - $-$ Forced consistency may be undesirable in some contexts
- Imbrication approach: unnormalized data
  - $+$ Faster access (no joins, single document retrieval)
  - $+$ Fewer failure points in distributed systems
  - $+$ Simpler application logic
  - $-$ Risk of data inconsistency due to redundancy
  - $-$ More complex queries on nested data
  - $-$ Larger, heavier documents

=== Models

- Represent n-to-m relations
  - document model: _difficult_
  - relation model: _easy_

- Optional fields
  - document model: _possible_
  - relations model: _not possible_

=== Couchbase

TODO Couchbase indexes

#divider-dotted

=== Graph
- Interconnected data
- When the domain can be represented by nodes and relations
- Social media, recommendation engines
- Relational DBs compute the relations during the query, graph DBs store them.
- Native: custom underlying storage
- Non-Native: underlying relational DB
- *Index-free adjacency*: the relations are stored


#divider-dotted


#divider

=== CAP Theorem

=== Partition Re-equilibration

=== Réplication maître-esclave

=== Réplication peer-to-peer

=== Index Free Adjacency
