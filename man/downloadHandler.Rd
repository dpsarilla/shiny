% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/shinywrappers.R
\name{downloadHandler}
\alias{downloadHandler}
\title{File Downloads}
\usage{
downloadHandler(filename, content, contentType = NULL, outputArgs = list())
}
\arguments{
\item{filename}{A string of the filename, including extension, that the
user's web browser should default to when downloading the file; or a
function that returns such a string. (Reactive values and functions may be
used from this function.)}

\item{content}{A function that takes a single argument \code{file} that is a
file path (string) of a nonexistent temp file, and writes the content to
that file path. (Reactive values and functions may be used from this
function.)}

\item{contentType}{A string of the download's
\href{https://en.wikipedia.org/wiki/Internet_media_type}{content type}, for
example \code{"text/csv"} or \code{"image/png"}. If \code{NULL}, the content type
will be guessed based on the filename extension, or
\code{application/octet-stream} if the extension is unknown.}

\item{outputArgs}{A list of arguments to be passed through to the implicit
call to \code{\link[=downloadButton]{downloadButton()}} when \code{downloadHandler} is used
in an interactive R Markdown document.}
}
\description{
Allows content from the Shiny application to be made available to the user as
file downloads (for example, downloading the currently visible data as a CSV
file). Both filename and contents can be calculated dynamically at the time
the user initiates the download. Assign the return value to a slot on
\code{output} in your server function, and in the UI use
\code{\link[=downloadButton]{downloadButton()}} or \code{\link[=downloadLink]{downloadLink()}} to make the
download available.
}
\examples{
## Only run examples in interactive R sessions
if (interactive()) {

ui <- fluidPage(
  downloadButton("downloadData", "Download")
)

server <- function(input, output) {
  # Our dataset
  data <- mtcars

  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(data, file)
    }
  )
}

shinyApp(ui, server)
}

}
\seealso{
\itemize{
\item The download handler, like other outputs, is suspended (disabled) by
default for download buttons and links that are hidden. Use
\code{\link[=outputOptions]{outputOptions()}} to control this behavior, e.g. to set
\code{suspendWhenHidden = FALSE} if the download is initiated by
programmatically clicking on the download button using JavaScript.
}
}
