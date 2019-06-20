//12-4. Set original-disease-hpo relationship counts to HPO
call apoc.periodic.iterate('match p=(h:HPO)<-[r]-(d:Disease) where not exists(r.source) return h.HPO_Term_Name as HPO, count(distinct p) as Ori_DH_rel','match (h:HPO) where h.HPO_Term_Name = HPO set h.Ori_DH_rel = Ori_DH_rel', {batchSize:1,parallel:False})