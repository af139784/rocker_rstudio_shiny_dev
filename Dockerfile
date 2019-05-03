FROM rocker/verse:3.5.3

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
    #forecast \
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
    scatterD3
    

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
