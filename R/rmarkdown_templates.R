#' R Markdown template picker
#'
#' Allows you to pick template in inst/styles folder and convert into callable output type.
#'
#' @param template Name of template in styles folder

rmarkdown_template <- function(template) {

  # get the locations of resource files located within the package
  file <- system.file(paste0("styles/",template,".docx"), package = "dfeR")

  # call the base html_document function
  rmarkdown::word_document(reference_docx = file)
}

#' R Markdown DfE National Statistic Output Format
#'
#' This function creates an R Markdown output format that generates documents
#' in the style of DfE National Statistic Publications. \cr
#'
#' To format an R Markdown document using this template add the function to the R Markdowns
#' YAML header as follows:
#'
#' title: "Name" \cr
#' output: dfeR::national_statistic \cr
#'
#' You can also use the template in R Studio via File > New File > R Markdown > From Template ...
#'
#' @param ... All Parameters from rmarkdown::word_document are accepted
#' @export
#' @examples
#' national_statistic()

national_statistic <- function(...) {

  rmarkdown_template("national_statistic")

}

#' R Markdown DfE Official Statistic Output Format
#'
#' This function creates an R Markdown output format that generates documents
#' in the style of DfE Official Statistic Publications. \cr
#'
#' To format an R Markdown document using this template add the function to the R Markdowns
#' YAML header as follows:
#'
#' title: "Name" \cr
#' output: dfeR::official_statistic \cr
#'
#' You can also use the template in R Studio via File > New File > R Markdown > From Template ...
#'
#' @param ... All Parameters from rmarkdown::word_document are accepted
#' @export
#' @examples
#' official_statistic()

official_statistic <- function(...) {

  rmarkdown_template("official_statistic")

}

#' R Markdown DfE Internal PowerPoint
#'
#' This function creates an R Markdown output format that generates html slide shows
#' in the style of DfE internal presenetations. \cr
#'
#' To format an R Markdown document using this template add the function to the R Markdowns
#' YAML header as follows:
#'
#' title: "Name" \cr
#' output: dfeR::internal_powerpoint \cr
#'
#' You can also use the template in R Studio via File > New File > R Markdown > From Template ...
#'
#' @param ... All Parameters from rmarkdown::word_document are accepted
#' @export
#' @examples
#' internal_powerpoint()

internal_powerpoint <- function(){

  # get the locations of resource files located within the package
  file <- system.file("styles/internal_powerpoint.pptx", package = "dfeR")

  # call the base html_document function
  rmarkdown::powerpoint_presentation(reference_doc = file)

}
