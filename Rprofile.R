if (interactive()) { 
  .First <- function(){
    cat("\n\n   RAM is cheap and thinking hurts.
   -- Uwe Ligges (about memory requirements in R)
      R-help (June 2007)\n\n")
    Sys.setenv("DISPLAY"=readLines("~/.display.txt"))
                                            #use main repo
    options("repos" = c(CRAN = "http://cran.r-project.org/"))
    options(show.signif.stars=FALSE)
    options(browser ="conkeror")
    library(Biobase)
    if(testBioCConnection()){source("http://bioconductor.org/biocLite.R")}
    else{cat("\n\ncould not source biocLite, network not connected\n\n")}
    ##  options(prompt=paste("R", basename(getwd()), "> "))
  }
}

# If no R_HISTFILE environment variable, set default
if (Sys.getenv("R_HISTFILE") == "") {
    Sys.setenv(R_HISTFILE=file.path("/home/ele/.Rhistory"))
  }

# Always have optimal width
tryCatch(
         {options(
                  width = as.integer(Sys.getenv("COLUMNS")))},
         error = function(err) {
           write("Can't get your terminal width",
                 stderr());
           options(width=120)}
         )

## some options
options(menu.graphics=FALSE) ## no tclk dialogs
options(max.print=999) ## no excessive output

## get rid of X11 crashes
setHook(packageEvent("grDevices", "onLoad"),
        function(...) grDevices::X11.options(width=12, height=12,
                                        #type="nbcairo"))  # Cairo device
                                             type="cairo"))    # other Cairo dev
                                        #type="xlib"))      # old default



ll <- function(envir=globalenv(), ...) {
  obs <- ls(envir=envir, ...)
  sizes <- sapply(obs, function (x) object.size(get(x)))
  modes <- sapply(obs, function (x) mode(get(x)))  
  classes <- sapply(obs, function (x) class(get(x)))
  as.data.frame(cbind(sizes, modes, classes))
}

fix.X11 <- function() {
  Sys.setenv("DISPLAY"=readLines("~/.display.txt"))
}

# Override q() to not save by default.
# Same as saying q("no")
q <- function (save="no", ...) {
  quit(save=save, ...)
}

.Last <- function() {
  if (!any(commandArgs()=='--no-readline') && interactive()){
    require(utils)
    try(savehistory(Sys.getenv("R_HISTFILE")))
  }
  cat("\n\nMay these stats lead to conclusions...\n\n")
}

