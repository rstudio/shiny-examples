# To build, cd to this directory, then:
#   docker build -t ss-shiny-devel .
#
# If you are not on the master branch and would like to build with
# shiny-examples from your branch, run:
#  docker build --build-arg SHINY_EXAMPLES_BRANCH=$(git symbolic-ref --short -q HEAD) -t ss-shiny-devel .
#
# To run with the built-in shiny-examples:
#   docker run --rm -p 3838:3838 --name ss ss-shiny-devel

FROM ubuntu:18.04

MAINTAINER Winston Chang "winston@rstudio.com"

# =====================================================================
# R
# =====================================================================

# Don't print "debconf: unable to initialize frontend: Dialog" messages
ARG DEBIAN_FRONTEND=noninteractive

# Need this to add R repo
RUN apt-get update && apt-get install -y software-properties-common

# Add R apt repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository "deb http://cran.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran35/"

# Install basic stuff and R
RUN apt-get update && apt-get install -y \
    sudo \
    locales \
    git \
    vim-tiny \
    less \
    wget \
    r-base \
    r-base-dev \
    r-recommended \
    fonts-texgyre \
    texinfo \
    locales \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev

RUN locale-gen en_US.utf8 \
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
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown'))" && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

# =====================================================================
# Shiny Examples
# =====================================================================

RUN apt-get update && apt-get install -y \
    libxml2-dev

RUN R -e "install.packages(c('devtools', 'packrat'))"

# For deploying apps from a container
RUN R -e "devtools::install_github('rstudio/rsconnect')"

# Install shiny-examples, and fix permissions for apps that require write
# access.
ARG SHINY_EXAMPLES_BRANCH=master
ENV SHINY_EXAMPLES_BRANCH=$SHINY_EXAMPLES_BRANCH
RUN cd /srv && \
    mv shiny-server shiny-server-orig && \
    wget -nv https://github.com/rstudio/shiny-examples/archive/${SHINY_EXAMPLES_BRANCH}.zip && \
    unzip -x ${SHINY_EXAMPLES_BRANCH}.zip && \
    mv shiny-examples-${SHINY_EXAMPLES_BRANCH} shiny-server && \
    rm ${SHINY_EXAMPLES_BRANCH}.zip && \
    cd shiny-server && \
    chmod 777 022-unicode-chinese 055-observer-demo 059-reactive-poll-and-file-reader

# Packages that need to be installed from GitHub
RUN R -e 'source("/srv/shiny-server/install_deps.R", echo = TRUE)'
