#' Instantiate cohorts against an omop cdm instance
#'
#' @param connectionDetails connection details generated using DatabaseConnector::createConnectionDetails()
#' @param cohortTable Name of the table to be created where cohorts will be stored
#' @param type Which cohorts to create
#' @param cdmDatabaseSchema name of the schema where the cdm is stored
#' @param cohortDatabaseSchema name of a schema with write access for the creation of cohort table
#' 
#' @import dplyr
#' @importFrom CirceR cohortExpressionFromJson buildCohortQuery
#' @importFrom CohortGenerator getCohortTableNames createCohortTables generateCohortSet getCohortCounts
#'
#' @export
createCohorts <- function(connectionDetails, 
                          cohortTable,
                          type = c("cohorts"),
                          cdmDatabaseSchema, 
                          cohortDatabaseSchema){
  
  # First construct a cohort definition set: an empty 
  # data frame with the cohorts to generate
  cohortsToCreate <- CohortGenerator::createEmptyCohortDefinitionSet()
  
  # Fill the cohort set using  cohorts included in this 
  # package as an example
  cohortJsonFiles <- list.files(path = system.file(type, package = "EhdenAlopecia"), full.names = TRUE)
  for (i in 1:length(cohortJsonFiles)) {
    cohortJsonFileName <- cohortJsonFiles[i]
    cohortName <- tools::file_path_sans_ext(basename(cohortJsonFileName))
    # Here we read in the JSON in order to create the SQL
    # using [CirceR](https://ohdsi.github.io/CirceR/)
    # If you have your JSON and SQL stored differenly, you can
    # modify this to read your JSON/SQL files however you require
    cohortJson <- readChar(cohortJsonFileName, file.info(cohortJsonFileName)$size)
    cohortExpression <- CirceR::cohortExpressionFromJson(cohortJson)
    cohortSql <- CirceR::buildCohortQuery(cohortExpression, options = CirceR::createGenerateOptions(generateStats = FALSE))
    cohortsToCreate <- rbind(cohortsToCreate, data.frame(cohortId = as.numeric(cohortName),
                                                         cohortName = cohortName, 
                                                         sql = cohortSql,
                                                         stringsAsFactors = FALSE))
  }
  

  
  # Create the cohort tables to hold the cohort generation results
  cohortTableNames <- CohortGenerator::getCohortTableNames(cohortTable = cohortTable)
  CohortGenerator::createCohortTables(connectionDetails = connectionDetails,
                                      cohortDatabaseSchema = cohortDatabaseSchema,
                                      cohortTableNames = cohortTableNames)
  # Generate the cohorts
  cohortsGenerated <- CohortGenerator::generateCohortSet(connectionDetails = connectionDetails,
                                                       cdmDatabaseSchema = cdmDatabaseSchema,
                                                       cohortDatabaseSchema = cohortDatabaseSchema,
                                                       cohortTableNames = cohortTableNames,
                                                       cohortDefinitionSet = cohortsToCreate)
  
  # Get the cohort counts
  cohortCounts <- CohortGenerator::getCohortCounts(connectionDetails = connectionDetails,
                                                 cohortDatabaseSchema = cohortDatabaseSchema,
                                                 cohortTable = cohortTableNames$cohortTable)
  return(cohortsGenerated)
}