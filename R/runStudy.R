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
                     # instantiateTreatmentCohorts = FALSE,
                     runDiagnostics = FALSE,
                     runPatternAnalysis = FALSE,
                     outputFolder,
                     databaseId,
                     minCellCount) {
  
  if (!dir.exists(outputFolder)) {
    dir.create(outputFolder)
  }
  
  if (instantiateCohorts){
    cohortsGenerated <- createCohorts(connectionDetails = connectionDetails, 
                  cohortTable = cohortTable,
                  type = "cohorts",
                  cdmDatabaseSchema = cdmDatabaseSchema, 
                  cohortDatabaseSchema = cohortDatabaseSchema)
    cohortCounts <- CohortGenerator::getCohortCounts(connectionDetails = connectionDetails,
                                                     cohortDatabaseSchema = cohortDatabaseSchema,
                                                     cohortTable = cohortTable)
    cohortsGenerated <- cohortsGenerated %>%
      left_join(cohortCounts, by = "cohortId") 
    cohortsGenerated <- cohortsGenerated %>%
      filter(cohortSubjects > 0)
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
    # if (instantiateTreatmentCohorts){
    #   cohortsGenerated <- createCohorts(connectionDetails = connectionDetails, 
    #                                     cohortTable = cohortTable,
    #                                     type = "treatment_cohorts",
    #                                     cdmDatabaseSchema = cdmDatabaseSchema, 
    #                                     cohortDatabaseSchema = cohortDatabaseSchema)
    #   readr::write_csv(cohortsGenerated, file.path(outputFolder, "treatmentCohortsGenerated.csv"))
    # }
    targetCohortsGenerated <- readr::read_csv(file.path(outputFolder, "cohortsGenerated.csv")) %>% 
      filter(cohortId <= 100)

    treatmentCohortsGenerated  <- readr::read_csv(file.path(outputFolder, "cohortsGenerated.csv")) %>%
      filter(cohortId > 100)
    # cohortsGenerated <- targetCohortsGenerated[1,] %>%
    #   dplyr::bind_rows(treatmentCohortsGenerated)
    for (i in seq(1:length(targetCohortsGenerated$cohortId))) {
      # i <- 1
      cohortsGenerated <- targetCohortsGenerated[i,] %>%
        dplyr::bind_rows(treatmentCohortsGenerated)
      
      # cohortIds <- c(cohort, 101:127)
      # cohort <- 100
      cohortIds <- cohortsGenerated$cohortId
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