# To build, cd to this directory, then:
#   docker build -t ss-shiny-devel .
#
# To run with the built-in shiny-examples:
#   docker run --rm -p 3838:3838 --name ss ss-shiny-devel

FROM ubuntu:16.04

MAINTAINER Winston Chang "winston@rstudio.com"

# =====================================================================
# R
# =====================================================================

# Don't print "debconf: unable to initialize frontend: Dialog" messages
ARG DEBIAN_FRONTED=noninteractive

# Need this to add R repo
RUN apt-get update && apt-get install -y software-properties-common

# Add R apt repository
RUN add-apt-repository "deb http://cran.r-project.org/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0x51716619e084dab9

# Install basic stuff and R
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    vim-tiny \
    less \
    wget \
    r-base \
    r-base-dev \
    r-recommended \
    fonts-texgyre \
    texinfo \
    locales

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
   && locale-gen en_US.utf8 \
   && /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN echo 'options(\n\
  repos = c(CRAN = "https://cloud.r-project.org/"),\n\
  download.file.method = "libcurl",\n\
  # Detect number of physical cores\n\
  Ncpus = parallel::detectCores(logical=FALSE)\n\
)' >> /etc/R/Rprofile.site

# Install TinyTeX (subset of TeXLive)
# From FAQ 5 and 6 here: https://yihui.name/tinytex/faq/
# Also install ae, parskip, and listings packages to build R vignettes
RUN wget -qO- \
    "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
    sh -s - --admin --no-path \
    && ~/.TinyTeX/bin/*/tlmgr path add \
    && tlmgr install metafont mfware inconsolata tex ae parskip listings \
    && tlmgr path add \
    && Rscript -e "source('https://install-github.me/yihui/tinytex'); tinytex::r_texmf()"

# This is necessary for non-root users to follow symlinks to /root/.TinyTeX
RUN chmod 755 /root

# Create docker user with empty password (will have uid and gid 1000)
RUN useradd --create-home --shell /bin/bash docker \
    && passwd docker -d \
    && adduser docker sudo

# =====================================================================
# Shiny Examples
# =====================================================================

RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcairo2-dev \
    libxt-dev \
    libcurl4-openssl-dev \
    parallel

RUN bash -c 'echo "will cite" | parallel --bibtex'

RUN R -e "install.packages(c('devtools', 'packrat', 'knitr'))"

# Install shiny-examples, and fix permissions for apps that require write
# access to /shiny-examples
RUN cd / && \
    wget -nv https://github.com/rstudio/shiny-examples/archive/master.zip && \
    unzip -x master.zip && \
    mv shiny-examples-master shiny-examples && \
    cd shiny-examples && \
    chmod 777 022-unicode-chinese 055-observer-demo 059-reactive-poll-and-file-reader

# Autodetect packages needed for the examples (will install from CRAN)
RUN R -e "install.packages(packrat:::dirDependencies('/shiny-examples'))"

# Packages that need to be installed from GitHub
# For 087-crandash
RUN R -e "devtools::install_github('hadley/shinySignals')"
RUN R -e "devtools::install_github('jcheng5/bubbles')"

# For deploying apps to RSC
RUN R -e "devtools::install_github('rstudio/rsconnect')"

COPY deployApp.R /usr/local/bin
