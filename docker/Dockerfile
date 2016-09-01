# To build, cd to this directory, then:
#   docker build -t ss-shiny-devel .
#
# To run with the built-in shiny-examples:
#   docker run --rm -p 3838:3838 --name ss ss-shiny-devel

FROM ubuntu:14.04

MAINTAINER Winston Chang "winston@rstudio.com"

# =====================================================================
# R
# =====================================================================

# Need this to add R repo
RUN apt-get update && apt-get install -y software-properties-common

# Add R apt repository
RUN add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install basic stuff and R
RUN apt-get update && apt-get install -y \
    sudo \
    vim-tiny \
    less \
    wget \
    r-base \
    r-base-dev \
    r-recommended \
    fonts-texgyre

RUN echo 'options(repos = c(CRAN = "https://cran.r-project.org/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site

# =====================================================================
# Shiny Server
# =====================================================================

RUN apt-get install -y \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev

# Download and install shiny server
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown'), Ncpus = parallel::detectCores())" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

# =====================================================================
# Shiny Examples
# =====================================================================

RUN apt-get update && apt-get install -y \
    libxml2-dev

RUN R -e "install.packages(c('devtools', 'packrat'), Ncpus = parallel::detectCores())"

# For deploying apps from a container
RUN R -e "devtools::install_github('rstudio/rsconnect')"

# Install shiny-examples
RUN cd /srv && \
    mv shiny-server shiny-server-orig && \
    wget -nv https://github.com/rstudio/shiny-examples/archive/master.zip && \
    unzip -x master.zip && \
    mv shiny-examples-master shiny-server && \
    rm master.zip

# Packages needed for the examples
RUN R -e "install.packages(packrat:::dirDependencies('/srv/shiny-server'), Ncpus = parallel::detectCores())"

# For 087-crandash
RUN R -e "devtools::install_github('hadley/shinySignals')"
RUN R -e "devtools::install_github('jcheng5/bubbles')"

# Install latest shiny from GitHub
RUN R -e "devtools::install_github('rstudio/shiny')"
