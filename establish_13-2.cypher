//13-2. Set NAPDR, NOPDR, NPDR to HPO nodes
match(h:HPO)
with h.All_DH_rel as A, h.Ori_DH_rel as O
with max(A) as MaxA, min(A) as MinA, max(O) as MaxO, min(O) as MinO
match (h:HPO)
set h.NAPDR = (toFloat(h.All_DH_rel-MinA+1))/(toFloat(MaxA-MinA+1)), h.NOPDR =
(toFloat(h.Ori_DH_rel-MinO+1))/(toFloat(MaxO-MinO+1)), h.NPDR =
((toFloat(h.All_DH_rel-MinA+1))/(toFloat(MaxA-MinA+1)))*((toFloat(h.Ori_DH_rel-MinO+1))/(toFloat(MaxO-MinO+1)))