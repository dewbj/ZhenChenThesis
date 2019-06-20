//*Simulation test results returning
match (t:Test_I1) where exists(t.Res20)
with
sum(t.Res20[0]) as s0,
sum(t.Res20[0]+t.Res20[1]+t.Res20[2]) as s2,
sum(t.Res20[0]+t.Res20[1]+t.Res20[2]+t.Res20[3]+t.Res20[4]) as s4,
sum(t.Res20[0]+t.Res20[1]+t.Res20[2]+t.Res20[3]+t.Res20[4]+t.Res20[5]+t.Res20[6]+t.Res20[7]+t.Res20[8]+t.Res20[9]) as s9,
sum(t.Res20[0]+t.Res20[1]+t.Res20[2]+t.Res20[3]+t.Res20[4]+t.Res20[5]+t.Res20[6]+t.Res20[7]+t.Res20[8]+t.Res20[9]+t.Res20[10]+t.Res20[11]+t.Res20[12]+t.Res20[13]+t.Res20[14]+t.Res20[15]+t.Res20[16]+t.Res20[17]+t.Res20[18]+t.Res20[19]) as s19,
count(t) as c return s0, s2, s4, s9, s19, c