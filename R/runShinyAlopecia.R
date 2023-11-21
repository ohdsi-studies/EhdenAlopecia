#' `runAlopeciaShiny()` launches an app to visualise TreatmentPatterns results for the alopecia study.
#' 
#' @import shiny shinythemes shinydashboard shinycssloaders shinyWidgets TreatmentPatterns here
#' @importFrom readr read_csv
#' @export
runShinyAlopecia <- function() {
  ui <- dashboardPage(
    dashboardHeader(title = "Menu"),
    dashboardSidebar(
      sidebarMenu(
        menuItem(
          text = "Home",
          tabName = "home"
        ),
        menuItem(
          text = "TreatmentPathways",
          tabName = "data"
          )
        )
      ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "home",
          h4("Analytic software to perform large-scale distributed analysis of patients with Alopecia as part of the EHDEN study-athon.")
        ),
        tabItem(
          tabName = "data",
          uiOutput("dataTable")
        )
      )
    )
  )
  
  server <- function(input, output, session) {
    ## TreatmentPatterns ----
    resultsPathways <- reactive({
      databases <- list.files(here::here("results"), full.names = TRUE)
      resultsPathways <- list()
      for (i in seq(1:length(databases))) {
        # i <- 1
        targetCohorts <- list.files(databases[i], full.names = TRUE)
        targetCohortNumber <- list.files(databases[i])
        for (v in seq(1:length(targetCohorts))) {
          # v <- 1
          pathwaysFiles <- list.files(targetCohorts[v], full.names = TRUE)
          file_metaData <- pathwaysFiles[stringr::str_detect(pathwaysFiles, "metadata")]
          cdm_name <- readr::read_csv(file_metaData, show_col_types = FALSE) %>%
            pull(cdmSourceName)
          file_TreatmentPathways <- pathwaysFiles[stringr::str_detect(pathwaysFiles, "treatmentPathways")]
          resultsPathways <- bind_rows(resultsPathways, readr::read_csv(file_TreatmentPathways, show_col_types = FALSE) %>%
            mutate(cdm_name = cdm_name,
                   targetCohort = targetCohortNumber[v]))
        }
      }
      return(resultsPathways)
    })
    
    output$dataTable <- renderUI({
      tagList(
        pickerInput(
          inputId = "dataDatabase",
          label = "Data partner",
          choices = unique(resultsPathways()$cdm_name),
          selected = unique(resultsPathways()$cdm_name)[1],
          multiple = FALSE
        ),
        pickerInput(
          inputId = "dataTargetCohort",
          label = "Target Cohort",
          choices = unique(resultsPathways()$targetCohort),
          selected = unique(resultsPathways()$targetCohort)[1],
          multiple = FALSE
        ),
        pickerInput(
          inputId = "dataSex",
          label = "Sex",
          choices = unique(resultsPathways()$sex),
          selected = unique(resultsPathways()$sex)[1],
          multiple = FALSE
        ),
        pickerInput(
          inputId = "dataAge",
          label = "Age",
          choices = unique(resultsPathways()$age),
          selected = unique(resultsPathways()$age)[1],
          multiple = FALSE
        ),
        pickerInput(
          inputId = "dataIndex",
          label = "Index year",
          choices = unique(resultsPathways()$indexYear),
          selected = unique(resultsPathways()$indexYear)[1],
          multiple = FALSE
        ),
        tabsetPanel(
          type = "tabs",
          tabPanel(
            "Data",
            DT::dataTableOutput(outputId = "treatmentPathways")
          ),
          tabPanel(
            "Sunburst Plot",
            uiOutput(outputId = "sunburstPlot")
          )
          # ,
          # tabPanel(
          #   "Sankey Diagram",
          #   uiOutput(outputId = "sankeyDiagram")
          # )
        )
      )
    })
    
    pathwaysData <- reactive({
      resultsPathways() %>%
        filter(cdm_name == input$dataDatabase,
               targetCohort == input$dataTargetCohort,
               sex == input$dataSex,
               age == input$dataAge,
               indexYear == input$dataIndex)
    })
    
    output$treatmentPathways <- DT::renderDataTable(pathwaysData())
    
    output$sunburstPlot <- renderUI({
      TreatmentPatterns::createSunburstPlot2(treatmentPathways = pathwaysData(),
                                             groupCombinations = TRUE)
    })

    # output$sankeyDiagram <- renderUI({
    #   TreatmentPatterns::createSankeyDiagram2(treatmentPathways = pathwaysData(),
    #                                           groupCombinations = TRUE)
    # })
  }
  shinyApp(ui, server)
}