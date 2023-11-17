#' run the main elements of the study
#'
#' @param connectionDetails connection details generated using DatabaseConnector::createConnectionDetails()
#' @param cohortTable Name of the table to be created where cohorts will be stored
#' @param cdmDatabaseSchema name of the schema where the cdm is stored
#' @param cohortDatabaseSchema name of a schema with write access for the creation of cohort table
#' @param instantiateCohorts choose whether to instantiate the cohorts on your database
#' @param runDiagnostics choose whether to run the cohort diagnostics 
#' @param runPatternAnalysis choose whether to run the treatment patterns analysis
#' @param outputFolder The folder where the results should be written
#' @param databaseId a short name that can identify the database used
#' @param minCellCount the minimum number of patients that can be shared for any single count in the results
#'
#' @export

runStudy <- function(connectionDetails,
                     cohortTable, 
                     cdmDatabaseSchema, 
                     cohortDatabaseSchema,
                     instantiateCohorts = FALSE,
                     instantiateTreatmentCohorts = FALSE,
                     runDiagnostics = FALSE,
                     runPatternAnalysis = FALSE,
                     outputFolder,
                     databaseId,
                     minCellCount) {
  
  if (instantiateCohorts){
    cohortsGenerated <- createCohorts(connectionDetails = connectionDetails, 
                  cohortTable = cohortTable,
                  type = "cohorts",
                  cdmDatabaseSchema = cdmDatabaseSchema, 
                  cohortDatabaseSchema = cohortDatabaseSchema)
    readr::write_csv(cohortsGenerated, file.path(outputFolder, "cohortsGenerated.csv"))
  }
  
  if (runDiagnostics){
    cohortDefinitionSet <- readr::read_csv("inst/cohortDefinitionSet.csv")
    CohortDiagnostics::executeDiagnostics(cohortDefinitionSet = cohortDefinitionSet, 
                       connectionDetails = connectionDetails,
                       cohortTable = cohortTable,
                       cohortDatabaseSchema = cohortDatabaseSchema,
                       cdmDatabaseSchema = cdmDatabaseSchema,
                       exportFolder = outputFolder,
                       databaseId = databaseId,
                       minCellCount = minCellCount
    )
  }
  
  if (runPatternAnalysis){
    if (instantiateTreatmentCohorts){
      cohortsGenerated <- createCohorts(connectionDetails = connectionDetails, 
                                        cohortTable = cohortTable,
                                        type = "treatments",
                                        cdmDatabaseSchema = cdmDatabaseSchema, 
                                        cohortDatabaseSchema = cohortDatabaseSchema)
      readr::write_csv(cohortsGenerated, file.path(outputFolder, "treatmentCohortsGenerated.csv"))
    }
    targetCohortsGenerated <- readr::read_csv(file.path(outputFolder, "treatmentCohortsGenerated.csv"))
    treatmentCohortsGenerated  <- readr::read_csv(file.path(outputFolder, "treatmentCohortsGenerated.csv"))
    cohortsGenerated <- targetCohortsGenerated %>%
      dplyr::bind_rows(treatmentCohortsGenerated)
    for (cohort in c(92, 93, 94, 95, 96 ,97, 100)){
      cohortIds <- c(cohort, 101:127) 
      runTreatmentPatterns(connectionDetails = connectionDetails, 
                         cdmDatabaseSchema = cdmDatabaseSchema, 
                         cohortDatabaseSchema = cohortDatabaseSchema, 
                         cohortTable = cohortTable, 
                         cohortsGenerated = cohortsGenerated, 
                         outputFolder = outputFolder, 
                         cohortIds = cohortIds, 
                         minCellCount = minCellCount)
    }
  }
}