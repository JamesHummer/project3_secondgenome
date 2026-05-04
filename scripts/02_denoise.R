library(dada2)

path <- "data/"
fnFs <- sort(list.files(path, pattern="_R1.fastq.gz", full.names=TRUE))
fnRs <- sort(list.files(path, pattern="_R2.fastq.gz", full.names=TRUE))

# Filtered output
filtFs <- file.path("filtered", basename(fnFs))
filtRs <- file.path("filtered", basename(fnRs))

out <- filterAndTrim(fnFs, filtFs, fnRs, filtRs,
                     truncLen=c(240,200),
                     maxN=0, maxEE=c(2,2), truncQ=2)

# Learn errors
errF <- learnErrors(filtFs)
errR <- learnErrors(filtRs)

# Denoise
dadaFs <- dada(filtFs, err=errF)
dadaRs <- dada(filtRs, err=errR)

# Merge
mergers <- mergePairs(dadaFs, filtFs, dadaRs, filtRs)

seqtab <- makeSequenceTable(mergers)
saveRDS(seqtab, "seqtab.rds")

