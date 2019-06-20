//4. Merge HPO nodes with data from hp.obo.json
with "FILE:///hp.obo.json" as url
call apoc.load.json(url) yield value as obo
with obo
merge (h:HPO {HPO_Term_ID:obo.id}) set h.HPO_Term_Name = obo.name, h.xref = obo.xref, h.def = obo.def, h.alt_id = obo.alt_id, h.is_a = obo.is_a, h.synonym = obo.synonym
return h