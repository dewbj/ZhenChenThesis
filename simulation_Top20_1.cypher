//*Calculating Top20 error distribution
match (t:Test_I1) where t.Res20 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] return distinct size(t.HPO_Term_Name) as Size, count(t) as Count order by Size