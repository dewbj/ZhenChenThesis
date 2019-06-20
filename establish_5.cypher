//5. Creates HPO is_a relationships
match (n:HPO) where exists (n.is_a)
with n
match (h:HPO) where h.HPO_Term_ID in n.is_a
create (n)-[:is_a]->(h)
return *