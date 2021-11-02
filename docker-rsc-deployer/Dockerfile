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
ARG DEBIAN_FRONTEND=noninteractive

# Need this to add R repo
RUN apt-get update && apt-get install -y software-properties-common

# Add R apt repository
RUN add-apt-repository "deb http://cran.r-project.org/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0x51716619e084dab9

# Install basic stuff and R
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    curl \
    vim-tiny \
    less \
    wget \
    r-base \
    r-base-dev \
    r-recommended \
    fonts-texgyre \
    texinfo \
    locales

# Install jt for working with JSON from the RSC API
RUN cd /usr/local \
  && wget -O - https://github.com/micha/json-table/raw/master/jt.tar.gz \
  | tar xzvf -

# Install jo for making JSON from bash
RUN cd /tmp \
  && wget -O - https://github.com/jpmens/jo/releases/download/v1.1/jo-1.1.tar.gz \
  | tar xzvf - \
  && cd jo-1.1 \
  && ./configure \
  && make install

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
   && locale-gen en_US.utf8 \
   && /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN echo 'options(\n\
  repos = c(CRAN = "https://cloud.r-project.org/"),\n\
  download.file.method = "libcurl"\n\
)' >> /etc/R/Rprofile.site

# Install TinyTeX (subset of TeXLive)
# From FAQ 5 and 6 here: https://yihui.name/tinytex/faq/
# Also install ae, parskip, and listings packages to build R vignettes
RUN wget -qO- \
    "https://github.com/yihui/tinytex/raw/main/tools/install-unx.sh" | \
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

RUN R -e "install.packages(c('devtools', 'packrat'))"

# Install shiny-examples, and fix permissions for apps that require write
# access to /shiny-examples
RUN cd / && \
    wget -nv https://github.com/rstudio/shiny-examples/archive/main.zip && \
    unzip -x main.zip && \
    mv shiny-examples-main shiny-examples && \
    cd shiny-examples


# Packages that need to be installed from GitHub
RUN R -e 'source("/install_deps.R", echo = TRUE)'


COPY deployApp.R /usr/local/bin
COPY set_public.sh /usr/local/bin
