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
#' @import dplyr TreatmentPatterns CohortGenerator CohortDiagnostics readr
#' @export

runStudy <- function(connectionDetails,
                     cohortTable, 
                     cdmDatabaseSchema, 
                     cohortDatabaseSchema,
                     instantiateCohorts = FALSE,
                     runDiagnostics = FALSE,
                     runPatternAnalysis = FALSE,
                     outputFolder,
                     databaseId,
                     minCellCount) {
  
  # Create output folder
  if (!dir.exists(outputFolder)) {
    dir.create(outputFolder)
  }
  # Instantiate cohorts
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
  # CohortDiagnostics
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
  
  # TreatmentPatterns
  if (runPatternAnalysis){
    # Target and treatment cohorts sections
    targetCohorts <- readr::read_csv(file.path(outputFolder, "cohortsGenerated.csv")) %>% 
      filter(cohortId <= 100)
    treatmentCohorts <- readr::read_csv(file.path(outputFolder, "cohortsGenerated.csv")) %>%
      filter(cohortId > 100)
    for (i in seq(1:length(targetCohorts$cohortId))) {
      outputSubDir <- file.path(outputFolder, 'treatmentPatterns', i)
      if (!dir.exists(outputSubDir)) {
        dir.create(outputSubDir, recursive = TRUE)
      }
      # TreatmentPathways for each target cohort with treatments
      cohortsGenerated <- targetCohorts[i,] %>%
        dplyr::bind_rows(treatmentCohorts)
      cohortIds <- cohortsGenerated$cohortId
      runTreatmentPatterns(connectionDetails = connectionDetails, 
                           cdmDatabaseSchema = cdmDatabaseSchema, 
                           cohortDatabaseSchema = cohortDatabaseSchema, 
                           cohortTable = cohortTable, 
                           cohortsGenerated = cohortsGenerated, 
                           outputFolder = outputSubDir, 
                           cohortIds = cohortIds, 
                           minCellCount = minCellCount)
    
      }
  }
}