# -----------------------------
# Base image: Ubuntu 22.04 LTS
# -----------------------------
FROM ubuntu:22.04

# -----------------------------
# Install system dependencies
# -----------------------------
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    nano \
    python3 \
    python3-pip \
    r-base \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
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
