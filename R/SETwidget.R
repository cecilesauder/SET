#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
SETwidget <- function(table, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    table = table
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'SETwidget',
    x,
    width = width,
    height = height,
    package = 'SET',
    elementId = elementId
  )
}

#' Shiny bindings for SETwidget
#'
#' Output and render functions for using SETwidget within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a SETwidget
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name SETwidget-shiny
#'
#' @export
SETwidgetOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'SETwidget', width, height, package = 'SET')
}

#' @rdname SETwidget-shiny
#' @export
renderSETwidget <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, SETwidgetOutput, env, quoted = TRUE)
}
