library(phyloseq)

seqtab <- readRDS("seqtab.rds")
tax <- readRDS("taxonomy.rds")

metadata <- read.csv("metadata.csv", row.names=1)

ps <- phyloseq(
  otu_table(seqtab, taxa_are_rows=FALSE),
  tax_table(as.matrix(tax)),
  sample_data(metadata)
)

saveRDS(ps, "phyloseq_object.rds")

