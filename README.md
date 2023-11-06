# Ehden Alopecia

Analytic software to perform large-scale distributed analysis of patients with Alopecia as part of the EHDEN study-athon

<img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started">

- Analytics use case(s): Population-Level Estimation
- Study type: Clinical Application
- Tags: -
- Study lead: 
- Study lead forums tag: 
- Study start date: 1 November 2023
- Study end date: -
- Protocol: To be added
- Publications: -
- Results explorer: -

# Requirements


A database in Common Data Model version 5 in one of these platforms: SQL Server, Oracle, PostgreSQL, IBM Netezza, Apache Impala, Amazon RedShift, Google BigQuery, or Microsoft APS.
R version 4.0.5
On Windows: RTools
Java
100 GB of free disk space

# How to run
Follow these instructions for setting up your R environment, including RTools and Java.

Clone the Ehdenaloopecia package into your local R environment.

Open your study package in RStudio. Use the following code to install all the dependencies:

In RStudio, select 'Build' then 'Install and Restart' to install the  package.

After succesfully installing the package. Open the extras/codeTorun.R and run the following code

```
#Load the library

library(EhdenAlopecia)
# database metadata and connection details -----
# The name/ acronym for the database
databaseId <- ""

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


cdmDatabaseSchema <- ""
cohortDatabaseSchema <- ""


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
runDiagnostics <- TRUE


### Do not edit below here

EhdenAlopecia::runStudy(
  connectionDetails = connectionDetails, 
  cohortTable = cohortTable, 
  cdmDatabaseSchema = cdmDatabaseSchema, 
  cohortDatabaseSchema = cohortDatabaseSchema,
  instantiateCohorts = instantiateCohorts,
  runDiagnostics = runDiagnostics,
  outputFolder = outputFolder,
  databaseId = databaseId,
  minCellCount = minCellCount
)
```
