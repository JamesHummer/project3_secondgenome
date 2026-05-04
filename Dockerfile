# -----------------------------
# Base image: Ubuntu 22.04 LTS
# -----------------------------
FROM ubuntu:22.04

# -----------------------------
# Install system dependencies
# -----------------------------

# Use a reliable mirror for Codespaces
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://azure.archive.ubuntu.com/ubuntu/|g' /etc/apt/sources.list
RUN sed -i 's|http://security.ubuntu.com/ubuntu/|http://azure.archive.ubuntu.com/ubuntu/|g' /etc/apt/sources.list

# Add CRAN repo for R
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common dirmngr gnupg ca-certificates
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 'E298A3A825C0D65DFD57CBB651716619E084DAB9'
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/'


# Install system packages needed for R, Python, and bioinformatics tools
RUN apt-get update && apt-get install -y \
    wget \                # command-line file downloader (used for grabbing databases, references)
    curl \                # flexible data transfer tool (API calls, downloading resources)
    git \                 # version control (needed for pulling code, installing some R packages)
    nano \                # simple terminal text editor (optional but useful for debugging)
    python3 \             # Python interpreter (needed for QIIME2 CLI and helper scripts)
    python3-pip \         # Python package manager (installs QIIME2 and other Python tools)
    r-base \              # core R installation (required for DADA2, phyloseq, DESeq2)
    libxml2-dev \         # XML parsing library (required by several R/BioC packages)
    libssl-dev \          # SSL/TLS crypto library (needed for secure downloads + R packages)
    libcurl4-openssl-dev \# cURL dev headers (required for R packages that download data)
    && rm -rf /var/lib/apt/lists/*


# -----------------------------
# Install QIIME2 (2024 version)
# -----------------------------
RUN pip install qiime2==2024.2

# -----------------------------
# Install R packages for DADA2 pipeline
# -----------------------------
RUN R -e "install.packages('BiocManager', repos='https://cloud.r-project.org')"
RUN R -e "BiocManager::install('dada2')"
RUN R -e "BiocManager::install('phyloseq')"
RUN R -e "install.packages('vegan', repos='https://cloud.r-project.org')"
RUN R -e "install.packages('tidyverse', repos='https://cloud.r-project.org')"

# -----------------------------
# Copy analysis scripts into container
# -----------------------------
COPY scripts/ /opt/scripts/

# -----------------------------
# Add scripts to PATH
# -----------------------------
ENV PATH="/opt/scripts:${PATH}"

# -----------------------------
# Default command
# -----------------------------
CMD ["bash"]
