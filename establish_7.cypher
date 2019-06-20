//7. Create disease nodes with relationships to HPO terms using data from orphanet
with "FILE:///en_product4_HPO.json" as file
call apoc.load.json(file) yield value as orpha
create (d:Disease {OrphaID:orpha.OrphaID}) set d.DisorderName = orpha.DisorderName
with orpha, d
match (h:HPO) where h.HPO_Term_ID in orpha.HPO_ID
create (d)-[:Phenotype]->(h)
return d as Disease, h as HPO