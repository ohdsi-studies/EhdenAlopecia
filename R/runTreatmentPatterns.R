#' Run the treatment patterns analysis
#'
#' @param connection An database connection created using DatabaseConnector::connect
#' @param cdmDatabaseSchema the schema where the cdm is located
#' @param cohortDatabaseSchema  A writable location on the database. 
#' @param cohortsGenerated A table contianing the output of the createCohorts function, detailing the cohorts that have been instatiated
#' @param outputFolder The output directory where the results should be saved
#' @param tablePrefix table prefix
#' @param outcomeTableName outcome cohort table name
#' @param logger logger object
#' @param cohortIds the cohortIds to be used form the cohort table
#' @param minCellCount minimum cell count
#'
#' @return the drug utilisation results
#'
#' @examples
#' @export

runTreatmentPatterns <- function(connectionDetails,
                                 cdmDatabaseSchema,
                                 cohortDatabaseSchema,
                                 cohortTable,
                                 cohortsGenerated,
                                 outputFolder,
                                 tablePrefix = NULL,
                                 logger = NULL,
                                 cohortIds,
                                 minCellCount = 5) {
  # med level treatment patterns -----
  cohortCounts <- CohortGenerator::getCohortCounts(connectionDetails = connectionDetails,
                                                   cohortDatabaseSchema = cohortDatabaseSchema,
                                                   cohortTable = cohortTable)
  tpCohorts <- cohortsGenerated %>%
    dplyr::inner_join(cohortCounts,
               dplyr::join_by(cohortId)) %>%
    dplyr::filter(cohortSubjects > 0) # make sure at least someone appears
  
  if (nrow(tpCohorts) > 0) {
    # Select target cohort
    targetCohorts <- cohortsGenerated %>%
      filter(cohortName == cohortIds[1]) %>%
      select(cohortId, cohortName)
    
    # Select everything BUT target cohorts
    eventCohorts <- cohortsGenerated %>%
      filter(cohortName != cohortIds[1]) %>%
      select(cohortId, cohortName)
    
    cohorts <- dplyr::bind_rows(
      targetCohorts %>% mutate(type = "target"),
      eventCohorts %>% mutate(type = "event")
    )
    
    # Compute pathways
    pathways <- TreatmentPatterns::executeTreatmentPatterns(
      cohorts = cohorts,
      cohortTableName = cohortTable,
      outputPath = outputFolder,
      connectionDetails = connectionDetails,
      cdmSchema = cdmDatabaseSchema,
      resultSchema = cohortDatabaseSchema,
      # Optional settings
      includeTreatments = "startDate",
      periodPriorToIndex = 0,
      minEraDuration = 0,
      splitEventCohorts = "",
      splitTime = 30,
      eraCollapseSize = 30,
      combinationWindow = 30,
      minPostCombinationDuration = 30,
      filterTreatments = "First",
      maxPathLength = 5,
      minFreq = minCellCount,
      addNoPaths = TRUE
    )
    #export results
    TreatmentPatterns::export(
        andromeda = pathways,
        outputPath = here::here(outputFolder),
        ageWindow = c(2,6,11,17,65,150), 
        minFreq = minCellCount,
        archiveName = NULL
      )
  } 
}
