#!/usr/bin/env bash

# Installs r devel on ubuntu, shiny, and shiny-examples
# Must install RStudio manually

# Initialize
sudo -E apt update -y
sudo -E apt upgrade -y

# Need this to add R repo
sudo -E apt-get install -y software-properties-common

# # Desktop GUI
# sudo -E apt-get install -y ubuntu-desktop

# Add R apt repository
sudo -E apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
# Adds source as well
sudo -E add-apt-repository -s "deb http://cran.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran35/"

# Install regular R, R developer and helpers
sudo -E apt update
sudo -E apt install -y r-base r-base-dev git libssl-dev libxml2-dev

# get all dependencies to build R from scratch
sudo -E apt-get build-dep -y r-base

# add simple style for knitr examples
sudo -E apt-get install lmodern

# add to global R profile
sudo -E bash -c 'cat <<EOF >> /etc/R/Rprofile.site
options(
  repos = c(CRAN = "https://cloud.r-project.org/"),
  download.file.method = "libcurl",
  # Detect number of physical cores
  Ncpus = parallel::detectCores(logical=FALSE)
)
EOF
'

# Get permission of /usr/local to save all the R versions
sudo chown -R `whoami` /usr/local

# Download r-source and sync common packages
cd /tmp \
    && git clone --depth 1 https://github.com/wch/r-source.git \
    && r-source/tools/rsync-recommended

# Build from https://github.com/wch/r-debug/blob/master/r-devel/buildR.sh
cd /tmp \
 && git clone --depth 1 https://github.com/wch/r-debug.git \
 && ./r-debug/r-devel/buildR.sh

# Install packrat to detect other dependencies
RD -q -e 'install.packages("packrat")'

# download examples to home folder and install dependencies
cd ~ \
 && git clone --depth 1 https://github.com/rstudio/shiny-examples.git \
 && RD -q -e 'install.packages(packrat:::dirDependencies("shiny-examples"))'

Rscript -e 'source("shiny-examples/install_deps.R", echo = TRUE)'

# cd ~/shiny-examples && RSTUDIO_WHICH_R=`which RD` rstudio
