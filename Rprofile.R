.First <- function(){
  cat("\n R says: Let's go !\n\n")
  #use main repo
  options("repos" = c(CRAN = "http://cran.r-project.org/"))
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
           write("Can't get your terminal width. Put ``export COLUMNS'' in your \
           .bashrc. Or something. Setting width to 120 chars",
                 stderr());
           options(width=120)}
         )


# aliases
s <- base::summary;
h <- utils::head;
n <- base::names;

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
