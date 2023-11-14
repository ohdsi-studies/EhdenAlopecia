test_that("calculateIncidencePrevalence adults", {

  cdm <- mockIncidencePrevalenceRef(sampleSize = 10)

  result <- calculateIncidencePrevalence(cdm = cdm,
                                         tablePrefix = "test",
                                         populationType = "adults",
                                         outcomeTableName = "outcome",
                                         logger = log4r::create.logger(level = "INFO"))

  expect_equal(length(result), 2)
  expect_equal(names(result), c("incidence", "prevalence"))
  expect_equal(nrow(result$incidence), 16)
  expect_equal(nrow(result$prevalence), 12)
})

test_that("calculateIncidencePrevalence catch errors", {

  cdm <- mockIncidencePrevalenceRef(sampleSize = 10)

  expect_error(calculateIncidencePrevalence(cdm = NULL))
  expect_error(calculateIncidencePrevalence(cdm = cdm))
  expect_error(calculateIncidencePrevalence(cdm = cdm, tablePrefix = "test"))
  expect_error(calculateIncidencePrevalence(cdm = cdm, tablePrefix = "test", populationType = 3))
  expect_error(calculateIncidencePrevalence(cdm = cdm, tablePrefix = "test", populationType = "adults",
                                              outcomeTableName = NULL))
  expect_error(calculateIncidencePrevalence(cdm = cdm, tablePrefix = "test", populationType = "adults",
                                              outcomeTableName = "outcome", logger = NULL))
})
