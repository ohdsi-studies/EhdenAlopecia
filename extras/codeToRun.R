# *******************************************************
# -----------------INSTRUCTIONS -------------------------
# *******************************************************
#
# This CodeToRun.R is the code to open, edit and run.
#
# Below you will find 3 sections: the 1st is for installing the study package and its dependencies,
# the 2nd for running the package, the 3rd is for sharing the results with the study coordinator.
#
# In section 2 below, you will also need to update the code to use your site specific values. Please scroll
# down for specific instructions.
#
#
# *******************************************************
# SECTION 1: Installing
# *******************************************************
#
# 1. See the instructions at https://ohdsi.github.io/Hades/rSetup.html for configuring your R environment, including Java and RStudio.
#
# 2. In RStudio, create a new project by cloning https://github.com/darwin-eu-studies/P1C3001AsthmaBackgroundRates
#
# 3. Install renv package
install.packages("renv")
#
# 4. Build the local library. This may take a while:
renv::restore()
#
# 5. Build the R package in the Build menu  -> Install

# *******************************************************
# SECTION 2: Running the package -------------------------------------------------------------------------------
# *******************************************************
#
# Edit the variables below to the correct values for your environment:


# library(testthat)

# database metadata and connection details -----
# The name/ acronym for the database
# IMPORTANT: to use names CPRD, IMASIS, IPCI, IQVIA_GERMANY_DA, SIDIAP for these databases.
dbName <- " "

# Database connection details -----
# In this study we also use the DBI package to connect to the database
# set up the dbConnect details below (see https://dbi.r-dbi.org/articles/dbi for
# more details)
# you may need to install another package for this
# eg for postgres
# conn <- dbConnect(
#   RPostgres::Postgres(),
#   dbname = server_dbi,
#   port = port,
#   host = host,
#   user = user,
#   password = password
# )
conn <- DBI::dbConnect("....")

# The name of the schema that contains the OMOP CDM with patient-level data
cdmDatabaseSchema <- "...."

# The name of the schema where results tables will be created
resultsDatabaseSchema <- "...."

# Name of table prefix to use in the result schema for tables created during the study.
# Notes:
# - if there is an existing table in your results schema with the same names it
#   will be overwritten
# - name must be lower case
tablePrefix <- ""

# minimum counts that can be displayed according to data governance
minimumCounts <- 5

instantiateCohorts <- TRUE
runDiagnostics <- FALSE

runStudy(connectionDetails, 
         cohortTable, 
         cdmDatabaseSchema, 
         cohortDatabaseSchema,
         instantiateCohorts)
