\name{gsarima-package}
\alias{gsarima-package}
\alias{gsarima}
\docType{package}
\title{
Two Functions for Generalized SARIMA Time Series Simulation
}
\description{
Write SARIMA models in (finite) AR representation and simulate generalized multiplicative seasonal autoregressive moving average (time) series The methodology of this method is described in Briet OJT, Amerasinghe PH, and Vounatsou P (2013) <doi:10.1371/journal.pone.0065761>.} 
\details{
\tabular{ll}{
Package: \tab gsarima\cr
Type: \tab Package\cr
Version: \tab 0.1-5\cr
Date: \tab 2020-09-03\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab yes\cr
}
Use arrep() for converting the SARIMA function into AR representation, and use garsim() to simulate.
}
\author{
Olivier Briet <o.briet@gmail.com>

Maintainer: Olivier Briet <o.briet@gmail.com>
}
\references{
  Briet OJT, Amerasinghe PH, Vounatsou P: Generalized seasonal autoregressive integrated moving average
	 models for count data with application to malaria time series with low case numbers.
	 PLoS ONE, 2013, 8(6): e65761. doi:10.1371/journal.pone.0065761  \url{https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0065761} If you use the gsarima package, please cite the above reference.
	 
  Brandt PT, Williams JT: A linear Poisson autoregressive model: The PAR(p). Political Analysis 2001, 9.

  Benjamin MA, Rigby RA, Stasinopoulos DM: Generalized Autoregressive Moving Average Models. Journal of the American Statistical Association 2003, 98:214-223.

  Zeger SL, Qaqish B: Markov regression models for time series: a quasi-likelihood approach. Biometrics 1988, 44:1019-1031

  Grunwald G, Hyndman R, Tedesco L, Tweedie R: Non-Gaussian conditional linear AR(1) models. Australian & New Zealand Journal of Statistics 2000, 42:479-495. 
}
\keyword{ package }
