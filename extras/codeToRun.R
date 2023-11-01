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
# 2. In RStudio, create a new project by cloning
# 
# 3. Install renv package
# install.packages("renv")
# #
# # 4. Build the local library. This may take a while:
# renv::restore()
#
# 5. Build the R package in the Build menu  -> Install

# *******************************************************
# SECTION 2: Running the package -------------------------------------------------------------------------------
# *******************************************************
#
# Edit the variables below to the correct values for your environment:

#Load the library

library(EhdenAlopecia)
# database metadata and connection details -----
# The name/ acronym for the database
databaseId = ""

# Database connection details -----
#connection details
#User specified input


# Details for connecting to the server:
dbms <- ""
user <- ''
pw <- ''
server <- ""
port <- ''

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                server = server,
                                                                user = user,
                                                                password = pw,
                                                                port = port)


cdmDatabaseSchema = ""
cohortDatabaseSchema = ""


# Name of table prefix to use in the result schema for tables created during the study.
# Notes:
# - if there is an existing table in your results schema with the same names it
#   will be overwritten
# - name must be lower case
cohortTable = "alopecia_ehden"


# minimum counts that can be displayed according to data governance
minCellCount <- 5

#specify where to save the results
outputFolder = "Results"


#choose analysis to run
instantiateCohorts <- TRUE
runDiagnostics <- TRUE


### Do not edit below here

runStudy(connectionDetails = connectionDetails, 
         cohortTable = cohortTable, 
         cdmDatabaseSchema = cdmDatabaseSchema, 
         cohortDatabaseSchema = cohortDatabaseSchema,
         instantiateCohorts = instantiateCohorts,
         runDiagnostics = runDiagnostics,
         outputFolder = outputFolder,
         databaseId = databaseId,
         minCellCount = minCellCount)
