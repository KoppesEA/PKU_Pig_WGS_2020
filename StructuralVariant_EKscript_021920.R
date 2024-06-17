##Erik Koppes  Feb 19th 2020
##Script to examin structural variants in PKU swine

library(readr)
library(dplyr)
library(tidyr)
library(forcats)
library(openxlsx)

MJ01_SV <- read_tsv("MJ01-116-1_SV.vcf", comment = "#", col_names = c("CHROM", "POS","ID", "REF", "ALT", "QUAL", "FILTER", "INFO"))
MJ02_SV <- read_tsv("MJ02-116-2_SV.vcf.gz", comment = "#", col_names = c("CHROM", "POS","ID", "REF", "ALT", "QUAL", "FILTER", "INFO"))
MJ03_SV <- read_tsv("MJ03-YucGFP_SV.vcf", comment = "#", col_names = c("CHROM", "POS","ID", "REF", "ALT", "QUAL", "FILTER", "INFO"))
MJ01_SV_annot <- read_tsv("MJ01-116-1_annotated_SV.vcf", comment = "#", col_names = c("CHROM", "POS","ID", "REF", "ALT", "QUAL", "FILTER", "INFO"))
MJ02_SV_annot <- read_tsv("MJ02-116-2_annotated_SV.vcf", comment = "#", col_names = c("CHROM", "POS","ID", "REF", "ALT", "QUAL", "FILTER", "INFO"))
MJ03_SV_annot <- read_tsv("MJ03-YucGFP_annotated_SV.vcf", comment = "#", col_names = c("CHROM", "POS","ID", "REF", "ALT", "QUAL", "FILTER", "INFO"))

MJ01_SV_PAH <- MJ01_SV %>% filter(CHROM == 5 & (81236096< POS  & POS < 81463452)) %>% mutate(Sample = "116-1")
MJ01_SV_PAH_ex6 <- MJ01_SV %>% filter(CHROM == 5 & (81435000< POS  & POS < 81445000)) %>% mutate(Sample = "116-1")
MJ02_SV_PAH <- MJ02_SV %>% filter(CHROM == 5 & (81236096< POS  & POS < 81463452)) %>% mutate(Sample = "116-2")
MJ02_SV_PAH_ex6 <- MJ02_SV %>% filter(CHROM == 5 & (81435000< POS  & POS < 81445000)) %>% mutate(Sample = "116-2")
MJ03_SV_PAH <- MJ03_SV %>% filter(CHROM == 5 & (81236096< POS  & POS < 81463452)) %>% mutate(Sample = "Yuc:GFP")
MJ03_SV_PAH_ex6 <- MJ03_SV %>% filter(CHROM == 5 & (81435000< POS  & POS < 81445000)) %>% mutate(Sample = "Yuc:GFP")

##combine samples to one tab
SV_PAH_combo <- bind_rows(MJ01_SV_PAH, MJ02_SV_PAH, MJ03_SV_PAH) %>% arrange(CHROM, POS) %>% select(Sample, everything())
SV_PAH_ex6_combo <- bind_rows(MJ01_SV_PAH_ex6, MJ02_SV_PAH_ex6, MJ03_SV_PAH_ex6) %>% arrange(CHROM, POS) %>% select(Sample, everything())


#Create Excel Table of SNVs
SV_Pig_PAH_summary <- createWorkbook("SV_Pig_PAH_summary")
addWorksheet(SV_Pig_PAH_summary, "MJ01_116-1_PAH")
writeData(SV_Pig_PAH_summary, "MJ01_116-1_PAH", MJ01_SV_PAH, rowNames = F, colNames = T)
addWorksheet(SV_Pig_PAH_summary, "MJ02_116-2_PAH")
writeData(SV_Pig_PAH_summary, "MJ02_116-2_PAH", MJ02_SV_PAH, rowNames = F, colNames = T)
addWorksheet(SV_Pig_PAH_summary, "MJ03_YucGFP_PAH")
writeData(SV_Pig_PAH_summary, "MJ03_YucGFP_PAH", MJ03_SV_PAH, rowNames = F, colNames = T)
addWorksheet(SV_Pig_PAH_summary, "All3_PAH")
writeData(SV_Pig_PAH_summary, "All3_PAH", SV_PAH_combo, rowNames = F, colNames = T)
saveWorkbook(SV_Pig_PAH_summary, "SV_Pig_PAH_summary.xlsx", overwrite = T)

SV_Pig_PAHex6_summary <- createWorkbook("SV_Pig_PAHex6_summary")
addWorksheet(SV_Pig_PAHex6_summary, "MJ01_116-1_PAHex6")
writeData(SV_Pig_PAHex6_summary, "MJ01_116-1_PAHex6", MJ01_SV_PAH_ex6, rowNames = F, colNames = T)
addWorksheet(SV_Pig_PAHex6_summary, "MJ02_116-2_PAHex6")
writeData(SV_Pig_PAHex6_summary, "MJ02_116-2_PAHex6", MJ02_SV_PAH_ex6, rowNames = F, colNames = T)
addWorksheet(SV_Pig_PAHex6_summary, "MJ03_YucGFP_PAHex6")
writeData(SV_Pig_PAHex6_summary, "MJ03_YucGFP_PAHex6", MJ03_SV_PAH_ex6, rowNames = F, colNames = T)
addWorksheet(SV_Pig_PAHex6_summary, "All3_PAHex6")
writeData(SV_Pig_PAHex6_summary, "All3_PAHex6", SV_PAH_ex6_combo, rowNames = F, colNames = T)
saveWorkbook(SV_Pig_PAHex6_summary, "SV_Pig_PAHex6_summary.xlsx", overwrite = T)


col_names = c("gene_ID", "gene_name","SRR7727978"), comment = "__") %>% select(-2)
##pig PAH coordinates
5:81236096-81463452