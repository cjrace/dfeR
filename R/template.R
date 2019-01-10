#' Create a standard project structure for analytical projects
#'
#' This function creates the the following structure to be used for analytical projects: \cr \cr
#' 1. R - A folder for your R scripts and functions \cr
#' 2. Data - A folder for copies of raw data to be stored if required \cr
#' 3. Outputs - A folder to populate in run.R with all outputs. Note outputs are considered disposable and not inteded to be tracked when using git. \cr
#' 4. Queries - A folder for copies of any SQL scripts used \cr
#' 5. Misc - A folder for anything else \cr
#' 6. README.md - A markdown file where documentation is to be kept \cr
#' 7. report.Rmd - An example R Markdown. Note .Rmd is in root so that relative references can be used easily. \cr
#' 8. run.R - An R file that when run populates the outputs folder with your analysis \cr
#' @param path Folder path where you would like to create the structure. Default is current working directory
#' @return Updated folder structure
#' @keywords project, setup
#' @export
#' @examples
#' \dontrun{
#' template_project()
#' }

template_project <- function(path = ".") {

  if (!is.character(path)) stop("path parmaeter must be of type character")

  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  folders <- c("R","Data","Outputs", "Queries", "Misc")

  folders_w_path <- file.path(path, folders)

  lapply(folders_w_path, dir.create)

  write("#README\n\nThis document is to be filled in with the documentation of the analysis.",file = file.path(path, "README.md"))

  write("#Note\n\nOutputs are not tracked in git. To populate this folder you must run run.R.", file = file.path(path, "Outputs/README.md"))

  write("# This file should be used to run all of the code required to populate the Outputs folder \n\n# Example below that renders example markdown in Outputs folder \n\nrmarkdown::render('report.Rmd', output_format = 'html_document', output_file='report.html', output_dir='Outputs')", file = file.path(path, "run.R"))

  rmarkdown::draft(file.path(path, "report.Rmd"), template = "dfe_analysis_markdown", package = "dfeR", edit = FALSE)

}

#' Create a standard project structure for RAP projects (Replicable Analytical Pipelines)
#'
#' This function creates the the following structure to be used for analytical projects: \cr \cr
#' 1. R - A folder for your R scripts and functions \cr
#' 2. Data - A folder for copies of raw data to be stored if required \cr
#' 3. QA_Outputs - A folder to populate in run.R with all outputs. Note outputs are considered disposable and not inteded to be tracked when using git. \cr
#' 4. QA_Scripts - A folder to contain all the quality assurance RMarkdown scripts \cr
#' 5  Queries - A folder for copies of any SQL scripts used \cr
#' 6. Dual_Run - A folder which can be populated with another analysts run of the data for dual QA \cr
#' 5. Misc - A folder for anything else \cr
#' 6. README.md - A markdown file where documentation is to be kept \cr
#' 7. report.Rmd - An example R Markdown. Note .Rmd is in root so that relative references can be used easily. \cr
#' 8. run.R - An R file that when run populates the outputs folder with your analysis \cr
#' @param path Folder path where you would like to create the structure. Default is current working directory
#' @return Updated folder structure
#' @keywords project, setup
#' @export
#' @examples
#' \dontrun{
#' rap_project()
#' }

rap_template <-  function (path = ".")
{
  if (!is.character(path))
    stop("path parmaeter must be of type character")
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  folders <- c("R","Data","QA_Outputs", "QA_Scripts", "Queries", "Dual_Run", "Misc")
  folders_w_path <- file.path(path, folders)
  lapply(folders_w_path, dir.create)
  write("#README\n\nThis document is to be filled in with the documentation of the analysis.",
        file = file.path(path, "README.md"))

  write("#Note\n\nOutputs are not tracked in git. To populate this folder you must run run.R.",
        file = file.path(path, "QA_Outputs/README.md"))

  write("# Replicable Analytical Pipeline - NAME_OF_PUBLICATION_YEAR

####
# Pseudocode ----
# 1. Load libraries and functions
# 2. Create tables in SQL
# 3. Pull in underlying data from SQL into a csv file
# 4. Generate QA report against individual underying data files
# 5. Generate QA across all publications underlying data
# 6. Produce summary report

####
# 1. Load libraries and functions ----
source(here::here('R', 'load_libraries.R'))
source(here::here('R', 'load_functions.R'))

####
# 2. Create tables in SQL ----

# Repeat this to create every underlying data table in SQL
dfeR::create_sql_table(query = 'create_NAME_OF_SQL_TABLE',
queries_folder = 'Queries')


####
# 3. Pull in underlying data from SQL into a csv file ----
# Repeat this to pull through every underlying data table in SQL into a csv which will be stored in the /Data folder
dfeR::sql_to_csv(query = 'run_NAME_OF_SQL_TABLE',
queries_folder = 'Queries',
save_folder = 'Data')

####
# 4. Generate QA report against individual underying data files ----
# Generate the first of the quality assurance reports
rmarkdown::render('QA_Scripts/QA_NAME_OF_SQL_TABLE.Rmd', output_dir = 'QA_Outputs')


####
# 5. Generate QA Consistency checks across underlying data ----
rmarkdown::render('QA_Scripts/QA_Across_Underlying_Data.Rmd', output_dir = 'QA_Outputs')

        ",
        file = file.path(path, "run.R"))

  write("# Loading libraries

library('devtools')
library('httr')
library('dfeR')

# Data manipulation
library('dplyr')
library('tidyr')
library('stringr')
library('magrittr')
library('reshape2')
library('janitor')
library('crayon')

# Report writing packages
library('knitr')
library('kableExtra')
library('pander')
library('formattable')
library('png')
library('here')

# Graphics packages
library('ggplot2')
library('scales')
library('plotly')
library('ggrepel')

# Database packages
library('RODBC')
library('dbplyr')",
        file = file.path(path, "R/load_libraries.R"))

  rmarkdown::draft(file.path(path, "report.Rmd"), template = "dfe_analysis_markdown",
                   package = "dfeR", edit = FALSE)
}
