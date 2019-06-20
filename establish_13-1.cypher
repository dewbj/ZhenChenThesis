//13-1. Set NADPR, NODPR, NDPR to disease nodes
match(d:Disease)
with d.All_DH_rel as A, d.Ori_DH_rel as O
with max(A) as MaxA, min(A) as MinA, max(O) as MaxO, min(O) as MinO
match (d:Disease)
set d.NADPR = (toFloat(d.All_DH_rel-MinA))/(toFloat(MaxA-MinA)), d.NODPR = (toFloat(d.Ori_DH_rel-MinO))/(toFloat(MaxO-MinO)), d.NDPR =
((toFloat(d.All_DH_rel-MinA))/(toFloat(MaxA-MinA)))*((toFloat(d.Ori_DH_rel-MinO))/(toFloat(MaxO-MinO)))