FROM af139784/verse:4.0.5

RUN apt-get update \
  && apt-get -y install tcl8.6-dev tk8.6-dev libsodium-dev libharfbuzz-dev libfribidi-dev unixodbc-dev

# Change Locale 
ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8
RUN sed -i '$d' /etc/locale.gen \
  && echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen ja_JP.UTF-8 \
    && /usr/sbin/update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja" \
    && /bin/bash -c "source /etc/default/locale" \
    && ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \

# Install JP Fonts 
  && apt-get update && apt-get install -y \
    fonts-ipaexfont \
    fonts-noto-cjk \

## Custum install packages
# ggplot2 extensions
 && install2.r -s --error \
    GGally \
    ggridges \
    RColorBrewer \
    scales \
    viridis \

# Misc utilities
#RUN install2.r -s --error \
    flexdashboard \
    plotly \
    #RPostgreSQL \
    #RPostgres \
    odbc \
    lubridate \
    RSelenium \
    RJSONIO \
    crosstalk \
    forecast \
# graph analysis
    igraph \
    visNetwork \
    linkcomm \

# Misc2 utilities
#RUN install2.r -s --error \
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
    pipeR \
    R.utils \
    UpSetR \
    colourpicker \
    patchwork \
    sodium \
    arrow \ 
    
# Caret and some ML packages
#RUN install2.r -s --error \
# ML framework
    caret \
    car \
    tidymodels \
# metrics
    MLmetrics \
    pROC \
# Models
    arm \
    e1071 \
    elasticnet \ 
    #fitdistrplus \
    #gam \
    #gamlss \
    glmnet \
    kernlab \
    lme4 \
    ltm \
    mboost \
    randomForest \ 
    ranger \
    rpart \
    survival \
    xgboost \

## Shiny server
 && export ADD=shiny && bash /etc/cont-init.d/add \
 && install2.r -s --error \
    shinythemes \
    shinydashboard \
    shinyjs \
    shinyWidgets \
    shinycssloaders \
    shinyalert \

# Re-Install from GitHub
 && installGithub.r \
    rstudio/shiny \

# Install from GitHub
 && installGithub.r \
    paulc91/shinyauthr 

EXPOSE 3838
