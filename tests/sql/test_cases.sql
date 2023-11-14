TRUNCATE TABLE @cdm_database_schema.PERSON;
TRUNCATE TABLE @cdm_database_schema.DRUG_EXPOSURE;
TRUNCATE TABLE @cdm_database_schema.OBSERVATION_PERIOD;
TRUNCATE TABLE @cdm_database_schema.CONDITION_OCCURRENCE;

 -- TEST:  test_cases.json
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 1, 8532, 1999, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 2, 8507, 1995, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 3, 8532, 1990, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 4, 8507, 1985, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 5, 8532, 1980, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 6, 8507, 1975, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 7, 8532, 1970, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 8, 8507, 1965, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 9, 8532, 1960, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 10, 8507, 1955, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 11, 8532, 1950, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 12, 8507, 1945, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 13, 8532, 1940, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 14, 8507, 1935, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 15, 8532, 1930, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 16, 8507, 1925, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 17, 8532, 1920, 0, 0, NULL;
INSERT INTO @cdm_database_schema.PERSON (person_id, gender_concept_id, year_of_birth, race_concept_id, ethnicity_concept_id, person_source_value) 
                  SELECT 18, 8507, 1915, 0, 0, NULL;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 1, 1, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 2, 2, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 3, 3, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 4, 4, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 5, 5, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 6, 6, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 7, 7, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 8, 8, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 9, 9, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 10, 10, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 11, 11, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 12, 12, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 13, 13, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 14, 14, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 15, 15, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 16, 16, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 17, 17, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.OBSERVATION_PERIOD (observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) 
                  SELECT 18, 18, '2012-01-01', '2016-01-01', 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 1, 1, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 2, 2, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 3, 3, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 4, 4, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 5, 5, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 6, 6, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 7, 7, 797617, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 8, 8, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 9, 9, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 10, 10, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 11, 11, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 12, 12, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 13, 13, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 14, 14, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 15, 15, 717607, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.DRUG_EXPOSURE (drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_end_date, quantity, drug_type_concept_id) 
                  SELECT 16, 16, 750982, '2014-01-01', '2014-01-31', 30, 0;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 1, 1, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 2, 2, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 3, 3, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 4, 4, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 5, 5, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 6, 6, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 7, 7, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 8, 8, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 9, 9, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 10, 10, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 11, 11, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 12, 12, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 13, 13, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 14, 14, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 15, 15, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 16, 16, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 17, 17, 4282316, '2013-11-05', 1;
INSERT INTO @cdm_database_schema.CONDITION_OCCURRENCE (condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_type_concept_id) 
                  SELECT 18, 18, 4282316, '2013-11-05', 1;