runStudy <- function(connectionDetails, 
                     cohortTable, 
                     cdmDatabaseSchema, 
                     cohortDatabaseSchema,
                     instantiateCohorts) {
  
  if (instantiateCohorts){
    createCohorts(connectionDetails = connectionDetails, 
                  cohortTable = cohortTable, 
                  cdmDatabaseSchema = cdmDatabaseSchema, 
                  cohortDatabaseSchema = cohortDatabaseSchema)
  }
  
  if (runDiagnostics){
    executeDiagnostics(cohortDefinitionSet,
                       connectionDetails = connectionDetails,
                       cohortTable = cohortTable,
                       cohortDatabaseSchema = cohortDatabaseSchema,
                       cdmDatabaseSchema = cdmDatabaseSchema,
                       exportFolder = exportFolder,
                       databaseId = "MyCdm",
                       minCellCount = 5
    )
    CohortGenerator::dropCohortStatsTables(
      connectionDetails = connectionDetails,
      cohortDatabaseSchema = cohortDatabaseSchema,
      cohortTableNames = cohortTableNames
    )
  }
}