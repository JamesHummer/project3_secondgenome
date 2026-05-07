# README SecondGenome project for Genomic Data Visualization and Management

#Project Overview
This project outlines a fully reproducible, Dockerized 16S rRNA microbiome analysis pipeline designed for a hypothetical dataset of 100 Ulcerative Colitis patients sampled during both flare and remission. Each patient contributes two samples, making this a paired study design focused on identifying bacterial features associated with remission.

Because no real sequencing data were provided, this project focuses on building the computational environment, organizing the workflow, and demonstrating how each step would be executed on real FASTQ files.

#Pipeline Summary
The pipeline is structured into five major steps, each implemented as a standalone script inside the scripts/ directory:

1. Quality Control (FastQC)  
Would assess read quality and identify issues such as low‑quality tails or adapter contamination.

2. Denoising (DADA2)  
Would model sequencing errors, infer exact ASVs, and merge paired reads to produce high‑resolution features.

3. Taxonomic Assignment  
Would assign taxonomy to ASVs using a reference database such as SILVA or Greengenes2.

4. Phyloseq Object Construction  
Would integrate ASV counts, taxonomy, and metadata into a unified object for downstream analysis.

5. Paired Differential Abundance Testing  
Would use a DESeq2 model including patient ID as a blocking factor to identify remission‑associated taxa.

Utility functions used across scripts are stored in scripts/utils.R.

Reproducible Computational Environment
A fully documented Dockerfile defines the analysis environment, including:

Ubuntu 22.04 base image

R with DADA2, phyloseq, and supporting libraries

Python 3 and QIIME2

System dependencies required for R package compilation

Line‑by‑line comments explaining the purpose of each installed component

This ensures the entire workflow can be reproduced on any machine without dependency conflicts.


#Directory Structure
project3_secondgenome/
│
├── Dockerfile
├── README.md
├── data/
├── env/
└── scripts/
    ├── 01_qc.sh
    ├── 02_denoise.R
    ├── 03_taxonomy.R
    ├── 04_phyloseq_build.R
    ├── 05_stats_paired.R
    └── utils.R

#Building and Running the Docker Container
From inside the project directory (e.g., in GitHub Codespaces):

docker build -t uc16s .

docker run -it -v $(pwd):/work uc16s bash


Once inside the container, the pipeline scripts would be executed in order:
bash 01_qc.sh
Rscript 02_denoise.R
Rscript 03_taxonomy.R
Rscript 04_phyloseq_build.R
Rscript 05_stats_paired.R
