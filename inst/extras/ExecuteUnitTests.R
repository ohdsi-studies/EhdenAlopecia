library(tibble)
library(dplyr)
library(readr)
library(tidyr)
library(CDMConnector)

pathToTestCaseSql <- "tests/sql"
# unitTestOutputFolder <- Sys.getenv("UT_TEST_CASES_RESULTS_LOCATION")
# Initialize the output path - careful, this will automatically remove prior results!
# if (dir.exists(unitTestOutputFolder)) {
#   unlink(unitTestOutputFolder, recursive = TRUE)
# }
# dir.create(unitTestOutputFolder)

# Use this when you'd like to emit the SQL for debugging
debug <- FALSE
cohortTable <- "mdd_test"
oracleTempSchema <- NULL
createSchemaPerTest <- TRUE
addIndex <- TRUE # Use this for PostgreSQL and other dialects that support creating indicies

# add any other tables that need to be truncated before a rerun
tablesToCleanup <- list(cohortTable)

# Connect to the server
con <- DBI::dbConnect(duckdb::duckdb(), eunomia_dir("synthea-covid19-10k"))

write_schema <- "main"
cdm_schema <- "main"

cdm <- cdm_from_con(con,
                    cdm_schema = cdm_schema,
                    write_schema = write_schema)

DBI::dbSendQuery(con, "DELETE FROM person")
DBI::dbSendQuery(con, "DELETE FROM condition_occurrence")
DBI::dbSendQuery(con, "DELETE FROM drug_exposure")

# Helper Functions ------------------
testCleanup <- function(tableList) {
  templateSql <- "TRUNCATE TABLE @cohort_database_schema.@table_name;\nDROP TABLE @cohort_database_schema.@table_name;\n"
  sql <- ""
  for (i in 1:length(tableList)) {
    sql <- paste(sql, SqlRender::render(sql=templateSql, table_name = tableList[i]), sep="\n")
  }
  return(sql)
}


# Execute Tests ---------------------

testCaseSql <- list.files(path = pathToTestCaseSql, pattern=".*.sql", include.dirs = FALSE)


for (i in 1:length(testCaseSql)) {
  # Create the data by running the SQL
  sql <- SqlRender::readSql(file.path(pathToTestCaseSql, testCaseSql[i]))
  sql <- SqlRender::render(sql = sql, cdm_database_schema = cdm_schema)
  ParallelLogger::logInfo(testCaseSql[i])
  DBI::dbSendQuery(con, sql)
  
  # Set the databaseName == the test case name
  # databaseName <- tools::file_path_sans_ext(testCaseSql[i])
  
  # if (createSchemaPerTest) {
    # resultsSchema <- paste0(cohortDatabaseSchema, i)
    
    # Drop any existing schemas that might interfere with running
    # these tests. For now check if the DB is PostgreSQL and drop the
    # results schemas
    # if (tolower(attr(connection, "dbms")) == tolower("postgresql")) {
    #   sql <- paste0("drop schema if exists ", resultsSchema, " cascade;")
    #   DatabaseConnector::executeSql(connection,
    #                                 sql,
    #                                 progressBar = F)
    # }
    
    # Create a schema for the results
    # DatabaseConnector::executeSql(connection,
                                  # paste0("CREATE SCHEMA ", resultsSchema, ";"),
                                  # progressBar = T)
  # } else {
    # resultsSchema = cohortDatabaseSchema
  # }
  
  # Execute the study and export the results
  # < ADD HERE THE CODE TO EXECUTE THE STUDY ON THE PATIENT PATTERNS OF A TEST >
  
  # Cleanup on exit
  # if (!createSchemaPerTest) {
  #   cleanupSql <- testCleanup(tablesToCleanup)
  #   cleanupSql <- SqlRender::render(sql = cleanupSql, cohort_database_schema = resultsSchema)
  #   DatabaseConnector::executeSql(connection, cleanupSql)
  # }
}

# 
# if (createSchemaPerTest) {
#   warning(paste0("There were ", i, " results schemas created as part of running these tests. You are responsible for manually dropping them before running another set of tests"))
# }

# on.exit(DatabaseConnector::disconnect(connection))

# Add the code to execute the Shiny App (note better to premerge and allow folder specification)
# shiny::runApp("shinyPAH")

