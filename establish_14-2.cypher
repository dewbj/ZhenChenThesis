//14-2. Set label:Outer to Phenotypic abnormality HPOs excluded specific class in the list
with ["Abnormality of metabolism/homeostasis","Abnormality of the immune system","Abnormal cellular phenotype","Abnormality of blood and blood-forming tissues","Abnormality of the endocrine system"] as list
match (h:HPO)<-[:is_a]-(x:HPO)<-[:is_a*0..]-(y:HPO) where h.HPO_Term_Name = 'Phenotypic abnormality' and not x.HPO_Term_Name in list
set y:Outer