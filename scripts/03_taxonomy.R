library(dada2)

seqtab <- readRDS("seqtab.rds")

tax <- assignTaxonomy(seqtab, "silva_nr99_v138.fa.gz")
saveRDS(tax, "taxonomy.rds")

