\name{summary.seas}
\alias{print.summary.seas}
\alias{summary.seas}
\title{Summary of a X13-ARIMA-SEATS seasonal adjustment}
\usage{
  \method{summary}{seas} (object, ...)

  \method{print}{summary.seas} (x,
    digits = max(3, getOption("digits") - 3),
    signif.stars = getOption("show.signif.stars"), ...)
}
\arguments{
  \item{object}{an object of class \code{"seas"}, usually,
  a result of a call to \code{\link{seas}}.}

  \item{x}{an object of class \code{"summary.seas"},
  usually, a result of a call to \code{summary.seas}.}

  \item{digits}{the number of significant digits to use
  when printing.}

  \item{signif.stars}{logical. If \code{TRUE},
  'significance stars' are printed for each coefficient.}

  \item{\dots}{further arguments passed to or from other
  methods.}
}
\value{
  \code{summary.seas} returns a list containing the summary
  statistics included in \code{object}, and computes the
  following additional statistics:

  \item{coefficients}{a named matrix containing
  coefficients, standard deviations, t-values and p-values}

  The \code{print} method prints the summary output in a
  similar way as the method for \code{"lm"}.
}
\description{
  \code{summary} method for class "seas".
}
\examples{
x <- seas(AirPassengers)
summary(x)
}

