//*Calculating HPO count distribution
match(t:Test_I1) return distinct size(t.HPO_Term_Name) as Size, count(t) as Count order by Size