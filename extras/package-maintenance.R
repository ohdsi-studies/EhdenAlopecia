library(ROhdsiWebApi)
baseUrl <- "https://test-atlas.ehden.eu/WebAPI"

authorizeWebApi(
    baseUrl,
    authMethod = "db",
    webApiUsername = Sys.getenv('EHDEN_WEBAPI_USERNAME'),
    webApiPassword = Sys.getenv('EHDEN_WEBAPI_PASSWORD')
)

getCdmSources(baseUrl)

cohortDefinitionSet <- ROhdsiWebApi::exportCohortDefinitionSet(
    baseUrl,
    c(92:97, 100)
)
write.csv(cohortDefinitionSet, 'inst/cohortDefinitionSet.csv')

# Insert cohort definitions from ATLAS into package -----------------------
for (cohortId in 92:97) {
    ROhdsiWebApi::insertCohortDefinitionInPackage(
    cohortId,
    name = cohortId,
    jsonFolder = "inst/cohorts",
    sqlFolder = "inst/sql/sql_server",
    baseUrl,
    generateStats = FALSE
    )
}
