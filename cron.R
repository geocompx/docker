# Set-up cron jobs to regularly create empty commits to trigger builds


# setup -------------------------------------------------------------------

# install.packages("cronR")
# library(cronR)
# cron_rstudioaddin()
## cronR job
## id:   job_7a09466e532408cc6a751c666c7944fd
## tags: 
## desc: I execute things
# 29 22 * * 0 /usr/lib/R/bin/Rscript '/home/robin/geocompr/docker/cron.R'  >> '/home/robin/geocompr/docker/cron.log' 2>&1
# later: interrupt occurred while executing callback.
# cron_add(command = cron_rscript(rscript = "cron.R"), frequency = "daily", at = "21:46", days_of_week = c(1, 5), id = "docker1")
# cron_ls()
# cron_rm("job_8871baa767b6951ec00e7da13c3607a2")
# remotes::install_github("r-lib/gert")


# code to execute ---------------------------------------------------------

setwd("~/geocompr/docker/")
rmarkdown::render("README.Rmd", output_format = "github_document", output_file = "README.md")
gert::git_commit_all("Trigger DockerHub build")
gert::git_push()
