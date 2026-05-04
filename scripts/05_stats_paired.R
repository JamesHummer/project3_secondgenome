library(phyloseq)
library(DESeq2)

ps <- readRDS("phyloseq_object.rds")

# Convert to DESeq2 object with paired design
dds <- phyloseq_to_deseq2(ps, ~ patient_id + condition)

dds <- DESeq(dds)

res <- results(dds, contrast=c("condition","remission","flare"))
sig <- res[which(res$padj < 0.05),]

write.csv(sig, "remission_associated_features.csv")

