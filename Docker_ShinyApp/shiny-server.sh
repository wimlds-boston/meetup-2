#!/bin/sh

Rscript -e ".libPaths('/usr/lib/R/library/'); shiny::runApp('/srv/shiny-server/Boston_Viz/', launch.browser = F, port = 3838, host = '0.0.0.0')"
