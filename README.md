OBO to JSON: 20181103_HPOMod.pl

XML to JSON: 20181218_OD_XMLtoJSON.pl

Create `HPO` nodes: establish_4.cypher

Create `HPO hierarchical structure`: establish_5.cypher

Create `Rare disease nodes` and `disease-HPO relationships`: establish_7.cypher

Set all-disease-HPO relationship counts to disease nodes: establish_12-1.cypher

Set original disease-HPO relationship counts to disease nodes: establish_12-2.cypher

Set all-disease-HPO relationship counts to HPO nodes: establish_12-3.cypher

Set original disease-HPO relationship counts to HPO nodes: establish_12-4.cypher

Set `NDPR` score to disease nodes: establish_13-1.cypher

Set `NPDR` score to HPO nodes: establish_13-2.cypher

Set label `Phenotypic abnomality`: establish_14-1.cypher

Set label `Outer`: establish_14-2.cypher

Set label `Inner`: establish_14-3.cypher

Create `Normal group` simulated patient nodes: simulation_create_1.cypher

Create `Noise group` simulated patient nodes: simulation_create_2.cypher

Create `Phenotypic group` simulated patient nodes: simulation_create_3.cypher

Set simulation testing result to patient nodes: simulation_result_1.cypher

Calculate HPO count distribution: simulation_count_1.cypher

Calculate `Top20` error count: simulation_Top20_1.cypher

Return stacked simulation testing result: simulation_result_2.cypher

DPR(Disease-Phenotype Relationships): DPR.csv

PDR(Phenotype-Disease Relationships): PDR.csv