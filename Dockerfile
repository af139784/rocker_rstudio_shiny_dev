FROM rocker/rstudio:3.6.0

## Tidyverse
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libmariadb-client-lgpl-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  && install2.r --error \
    --deps TRUE \
    tidyverse \
    dplyr \
    devtools \
    formatR \
    remotes \
    selectr \
    caTools \
    BiocManager


## Verse
ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

## Add LaTeX, rticles and bookdown support
RUN wget "https://travis-bin.yihui.name/texlive-local.deb" \
  && dpkg -i texlive-local.deb \
  && rm texlive-local.deb \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ## for rJava
    default-jdk \
    ## Nice Google fonts
    fonts-roboto \
    ## used by some base R plots
    ghostscript \
    ## used to build rJava and other packages
    libbz2-dev \
    libicu-dev \
    liblzma-dev \
    ## system dependency of hunspell (devtools)
    libhunspell-dev \
    ## system dependency of hadley/pkgdown
    libmagick++-dev \
    ## rdf, for redland / linked data
    librdf0-dev \
    ## for V8-based javascript wrappers
    libv8-dev \
    ## R CMD Check wants qpdf to check pdf sizes, or throws a Warning
    qpdf \
    ## For building PDF manuals
    texinfo \
    ## for git via ssh key
    ssh \
 ## just because
    less \
    vim \
 ## parallelization
    libzmq3-dev \
    libopenmpi-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  ## Use tinytex for LaTeX installation
  && install2.r --error tinytex \
  ## Admin-based install of TinyTeX:
  && wget -qO- \
    "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
    sh -s - --admin --no-path \
  && mv ~/.TinyTeX /opt/TinyTeX \
  && /opt/TinyTeX/bin/*/tlmgr path add \
  && tlmgr install metafont mfware inconsolata tex ae parskip listings \
  && tlmgr path add \
  && Rscript -e "tinytex::r_texmf()" \
  && chown -R root:staff /opt/TinyTeX \
  && chown -R root:staff /usr/local/lib/R/site-library \
  && chmod -R g+w /opt/TinyTeX \
  && chmod -R g+wx /opt/TinyTeX/bin \
  && echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron \
  && install2.r --error PKI \
  ## And some nice R packages for publishing-related stuff
  && install2.r --error --deps TRUE \
    bookdown rticles rmdshower rJava
#
## Consider including:
# - yihui/printr R package (when released to CRAN)
# - libgsl0-dev (GSL math library dependencies)

RUN apt-get update \
  && apt-get -y install tcl8.6-dev tk8.6-dev

## Custum install packages
# ggplot2 extensions
RUN install2.r -s --error \
    GGally \
    ggridges \
    RColorBrewer \
    scales \
    viridis

# Misc utilities
RUN install2.r -s --error \
    flexdashboard \
    plotly \
    RPostgreSQL \
    lubridate \
    RSelenium \
    RJSONIO \
    crosstalk \
    forecast \
# graph analysis
    igraph \
    visNetwork \
    linkcomm

# Misc2 utilities
RUN install2.r -s --error \
    config \
    doParallel \
    DT \
    data.table \
    foreach \
    formattable \
    glue \
    here \
    Hmisc \
    httr \
    jsonlite \
    kableExtra \
    logging \
    MASS \
    microbenchmark \
    openxlsx \
    pkgdown \
    rlang \
    RPushbullet \
    roxygen2 \
    stringr \
    styler \
    testthat \
    usethis \
    magrittr \
    summarytools \
    FactoMineR \
    factoextra \
    ggpubr \
    explor \
    scatterD3 \
    rlist \
    pipeR 
    

## Shiny server
RUN export ADD=shiny && bash /etc/cont-init.d/add
RUN install2.r -s --error \
    shinythemes \
    shinydashboard \
    shinyjs \
    shinyWidgets \
    shinycssloaders 

EXPOSE 3838

# Caret and some ML packages
RUN install2.r -s --error \
# ML framework
    caret \
    car \
    ensembleR \
# metrics
    MLmetrics \
    pROC \
# Models
    arm \
    C50 \
    e1071 \
    elasticnet \ 
    fitdistrplus \
    gam \
    gamlss \
    glmnet \
    kernlab \
    lme4 \
    ltm \
    mboost \
    randomForest \ 
    ranger \
    rpart \
    survival \
    xgboost
