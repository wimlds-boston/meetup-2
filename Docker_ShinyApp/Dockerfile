FROM r-base:latest

MAINTAINER Svetlana Vinogradova "kintany@gmail.com"

# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    make \
    git \
    gcc \
    zlib1g-dev \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libxt-dev && \
    R -e "install.packages(c('shiny', 'rmarkdown', 'DT'), repos='https://cran.rstudio.com/')" && \
        R -e "install.packages(c('dplyr','magnittr','ggplot2','shinythemes', 'remotes','lubridate'))"  && \
	R -e "remotes::install_github('thomasp85/shinyFiles')" && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
COPY Boston_Viz/ /srv/shiny-server/Boston_Viz/

CMD ["/usr/bin/shiny-server.sh"]
RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
