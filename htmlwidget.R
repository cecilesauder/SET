# devtools::create("SETwidget")               # create package using devtools
# setwd("SET") # navigate to package dir
#deja fait
setwd("SET")
htmlwidgets::scaffoldWidget("SETwidget")    # create widget scaffolding (une seule fois )

devtools::install()                        # install the package so we can try it
library(SET)
SETwidget(table)
