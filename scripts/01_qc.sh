 
#!/bin/bash

# Run FastQC on all FASTQ files
fastqc data/*.fastq.gz -o qc_reports/

# Example trimming (if needed)
# trimmomatic PE input_R1.fastq.gz input_R2.fastq.gz ...
