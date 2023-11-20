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
# See the instructions at https://ohdsi.github.io/Hades/rSetup.html for configuring your R environment, including Java and RStudio.
# Follow these instructions for setting up your R environment, including RTools and Java.

# Clone the EhdenAlopecia package into your local R environment.

# Open your study package in RStudio. Use the following code to install all the dependencies:

# In RStudio, select 'Build' then 'Install and Restart' to install the package.

# After succesfully installing the package, run the following code

# *******************************************************
# SECTION 2: Running the package -------------------------------------------------------------------------------
# *******************************************************
#
# Edit the variables below to the correct values for your environment:

#Load the library

library(EhdenAlopecia)

# database metadata and connection details -----
# The name/ acronym for the database
databaseId <- "IPCI"

# Database connection details -----
#connection details
#User specified input

# Details for connecting to the server:
dbms <- Sys.getenv("dbms")
user <- Sys.getenv("user")
password <- Sys.getenv("password")
server <- Sys.getenv("host")
port <- Sys.getenv
connectionString <- Sys.getenv("connectionString")

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                connectionString = connectionString,
                                                                user = user,
                                                                password = password,
                                                                port = port)


cdmDatabaseSchema <- "cdm"
cohortDatabaseSchema <- "cbarboza"


# Name of table prefix to use in the result schema for tables created during the study.
# Notes:
# - if there is an existing table in your results schema with the same names it
#   will be overwritten
# - name must be lower case
cohortTable <- "alopecia_ehden"


# minimum counts that can be displayed according to data governance
minCellCount <- 5

#specify where to save the results
outputFolder <- "results"


#choose analysis to run
instantiateCohorts <- TRUE
runDiagnostics <- FALSE
instantiateTreatmentCohorts <- FALSE
runPatternAnalysis <- TRUE

### Do not edit below here
EhdenAlopecia::runStudy(
  connectionDetails = connectionDetails, 
  cohortTable = cohortTable, 
  cdmDatabaseSchema = cdmDatabaseSchema, 
  cohortDatabaseSchema = cohortDatabaseSchema,
  instantiateCohorts = instantiateCohorts,
  runDiagnostics = runDiagnostics,
  runPatternAnalysis = runPatternAnalysis,
  outputFolder = outputFolder,
  databaseId = databaseId,
  minCellCount = minCellCount
)
