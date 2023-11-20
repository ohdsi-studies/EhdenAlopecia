library(CohortDiagnostics)

# -- Load results into database
resultsPath <- "/Users/maxim/Documents/EHDEN-docs/AA Study-a-thon/results"
pathToZips <- file.path(resultsPath, "zips")
sqliteDbPath <- file.path(pathToZips, "AACohortDiagnosticsResults.sqlite")
createMergedResultsFile(pathToZips, sqliteDbPath = sqliteDbPath, overwrite = TRUE)

# -- Local shiny app
launchDiagnosticsExplorer(sqliteDbPath = sqliteDbPath)

# -- Publishing to Posit
# remotes::install_packages('OHDSI/OhdsiShinyModules')
launchDiagnosticsExplorer(
  sqliteDbPath = sqliteDbPath,
  makePublishable = TRUE,
  publishDir = file.path(getwd(), "AACohortDiagnosticsExplorer"),
  overwritePublishDir = TRUE
)

# This will create a shiny app folder "MyStudyDiagnosticsExplorer" in your R working directory.
# The above will also overwrite the existing application folder and copy your sqlite file in to it. 
# Following this, the shiny window should load and show a “publsh” button.
