EHDEN Alopecia
==============

<img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started">

- Analytics use case(s): **Population-Level Estimation**
- Study type: **Clinical Application**
- Tags: -
- Study lead:
- Study lead forums tag:
- Study start date: 1 November 2023
- Study end date: -
- Protocol: To be added
- Publications: -
- Results explorer: -

Analytic software to perform large-scale distributed analysis of
patients with Alopecia as part of the EHDEN study-athon.

# Requirements

A database mapped to the OMOP Common Data Model version 5 in one of
these platforms: SQL Server, Oracle, PostgreSQL, IBM Netezza, Apache
Impala, Amazon RedShift, Google BigQuery, or Microsoft APS. R version
4.0.5 On Windows: RTools Java 100 GB of free disk space

# How to run

1.  See the instructions at <https://ohdsi.github.io/Hades/rSetup.html>
    for configuring your R environment, including Java and RStudio.

2.  Clone the EhdenAlopecia package into your local R environment.

3.  Open your study package in RStudio. Use the following code to
    install all the dependencies:

``` r

install.packages(c("TreatmentPatterns", 
                   "DBI",
                   "dplyr",
                   "glue",
                   "zip",
                   "magrittr",
                   "checkmate",
                   "lubridate",
                   "rlang",
                   "readr",
                   "here",
                   "rmarkdown",
                   "checkmate",
                   "SqlRender",
                   "duckdb",
                   "ParallelLogger",
                   "DBI",
                   "glue",
                   "zip",
                   "lubridate",
                   "rlang",
                   "jsonlite"))

remotes::install_github(c("ohdsi/CirceR",
                          "ohdsi/CohortGenerator",
                          "ohdsi/CohortDiagnostics"))
                          
```

In RStudio, select ‘Build’ then ‘Install and Restart’ to install the
package.

After succesfully installing the package. Open the
[inst/extras/CodeTorun.R](https://raw.githubusercontent.com/ohdsi-studies/EhdenAlopecia/main/inst/extras/CodeToRun.R)
and run the following code:

``` r
#Load the library

library(EhdenAlopecia)
library(here)

# database metadata and connection details -----
# The name/ acronym for the database
databaseId <- "..."

# Database connection details -----
#connection details
#User specified input

# Details for connecting to the server:
dbms <- Sys.getenv("dbms")
user <- Sys.getenv("user")
password <- Sys.getenv("password")
server <- Sys.getenv("host")
port <- Sys.getenv("port")
connectionString <- Sys.getenv("connectionString")

connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = dbms,
                                                                connectionString = connectionString,
                                                                user = user,
                                                                password = password,
                                                                port = port)


cdmDatabaseSchema <- "..."
cohortDatabaseSchema <- "..."


# Name of table prefix to use in the result schema for tables created during the study.
# Notes:
# - if there is an existing table in your results schema with the same names it
#   will be overwritten
# - name must be lower case
cohortTable <- "alopecia_ehden"


# minimum counts that can be displayed according to data governance
minCellCount <- 5

#specify where to save the results
outputFolder <- here::here("results")


#choose analysis to run
instantiateCohorts <- FALSE
runDiagnostics <- FALSE
runPatternAnalysis <- FALSE

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
```
