#' Run the treatment patterns analysis
#' 
#' @param connectionDetails DatabaseConnector connection details.
#' @param cdmDatabaseSchema the schema where the cdm is located.
#' @param cohortDatabaseSchema  A writable location on the database.
#' @param cohortTable Name of the main cohort table in characters.  
#' @param cohortsGenerated A table contianing the output of the createCohorts function, detailing the cohorts that have been instatiated
#' @param outputSubDir The output directory where the results should be saved
#' @param tablePrefix table prefix
#' @param logger logger object
#' @param cohortIds the cohortIds to be used form the cohort table
#' @param minCellCount minimum cell count
#' 
#' @import dplyr TreatmentPatterns
#' 
#' @return the drug utilisation results
#'
#' @export
runTreatmentPatterns <- function(connectionDetails,
                                 cdmDatabaseSchema,
                                 cohortDatabaseSchema,
                                 cohortTable,
                                 cohortsGenerated,
                                 outputSubDir,
                                 tablePrefix = NULL,
                                 logger = NULL,
                                 cohortIds,
                                 minCellCount = 5) {

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
    TreatmentPatterns::executeTreatmentPatterns(
      cohorts = cohorts,
      cohortTableName = cohortTable,
      outputPath = outputSubDir,
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
}
