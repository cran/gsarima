\name{garsim}
\alias{garsim}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Simulate a Generalized Autoregressive Time Series }
\description{
  Simulate a time series using a general autoregressive model.
}
\usage{
garsim(n, phi, X = matrix(0, nrow = n), beta = as.matrix(0), sd = 1, family = "gaussian",
	transform.Xbeta = "identity", link = "identity", minimum = 0, zero.correction = "zq1", 
	c = 1, theta = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{ The number of simulated values. }
  \item{phi}{ A vector of autoregressive parameters of length p. }
  \item{X}{ An n by m optional matrix of external covariates, optionally including an intercept (recommended for family = "poisson"). }
  \item{beta}{ An m vector of coefficients. }
  \item{sd}{ Standard deviation for Gaussian family. }
  \item{family}{ Distribution family, defaults to "gaussian". }
  \item{transform.Xbeta}{ Optional transformation for the product of covariates and coefficients, see Details. }
  \item{link}{ The link function, defaults to "identity". }
  \item{minimum}{ A minimum value for the mean parameter of the Poisson and Negative Binomialdistributions (only applicable for link= "identity" and family = c("poisson","negative.binomial"). Defaults to 0. A small positive value will allow non-stationary series to "grow" after encountering a simulated value of 0. }
  \item{zero.correction}{ Method for transformation for dealing with zero values (only applicable when link = "log"), see Details. }
  \item{c}{ The constant used for transformation before taking the logarithm (only applicable when link = "log"). A value between 0 and 1 is recommended. }
  \item{theta}{ Parameter theta (for family = "negative.binomial"). }
}
\details{
  Implemented are the following models:
  1) family = "gaussian", link = "identity"
  2) family = "poisson", link = "identity"
  3) family = "poisson", link = "identity", transform.Xbeta = "exponential"
  4) family = "poisson", link = "log", zero.correction = "zq1"
  5) family = "poisson", link = "log", zero.correction = "zq2"
  6) family = "negative.binomial", link = "identity"
  7) family = "negative.binomial", link = "identity", transform.Xbeta = "exponential"
  8) family = "negative.binomial", link = "log", zero.correction = "zq1"
  9) family = "negative.binomial", link = "log", zero.correction = "zq2"

  Models 1 to 4 are within the family of GARMA models of Benjamin and colleagues 2003
  Model 2 is the extension to higher order p of a Poisson CLAR(1) model proposed by Grunwald and  colleagues (2000).
  Model 3 is a modification of the PAR(p) data generating process (http://www.utdallas.edu/~pxb054000/code/pests.r) of Brandt and Williams (2001). Note that for psi = 0, the model reduces to a standard Poisson model with log-link function. For a model without external variables (only an intercept), the transformation of Xbeta has no consequence and then model 3 is the same as model 2.
  Model 4 corresponds to model 2.2 of Zeger and Qaqish (1988). The value c is only added to values of zero prior to taking the log.
  Models 6 to 9 are similar but with negative binomial distribution

}
\value{  An autoregressive series of length n. Note that the first p data do not have autoregressive structure.
}
\references{
  Brandt PT, Williams JT: A linear Poisson autoregressive model: The PAR(p). Political Analysis 2001, 9.

  Benjamin MA, Rigby RA, Stasinopoulos DM: Generalized Autoregressive Moving Average Models. Journal of the American Statistical Association 2003, 98:214-223.

  Zeger SL, Qaqish B: Markov regression models for time series: a quasi-likelihood approach. Biometrics 1988, 44:1019-1031

  Grunwald G, Hyndman R, Tedesco L, Tweedie R: Non-Gaussian conditional linear AR(1) models. Australian & New Zealand Journal of Statistics 2000, 42:479-495. 
}
\author{ Olivier Briet \email{ o.briet.antispam.@gmail.com } }
\note{ 
}
\seealso{ 'rnegbin(MASS)', 'arrep'. }
\examples{
  N<-1000
  ar<-c(0.8)
  intercept<-2
  frequency<-1
  x<- rnorm(N)
  beta.x<-0.7
  #Gaussian simulation with covariate
  X=matrix(c(rep(intercept, N+length(ar)), rep(0, length(ar)), x), ncol=2)
  y.sim <- garsim(n=(N+length(ar)),phi=ar, X=X, beta=c(1,beta.x), sd=sqrt(1)) 
  y<-y.sim[(1+length(ar)):(N+length(ar))]
  tsy<-ts(y, freq=frequency)
  plot(tsy)
  arima(tsy, order=c(1,0,0), xreg=x)

  #Gaussian simulation with covariate and deterministic seasonality through first order harmonic
  ar<-c(1.4,-0.4)
  frequency<-12
  beta.x<-c(0.7,4,4)
  X<-matrix(nrow= (N+ length(ar)), ncol=3)
  for (t in 1: length(ar)){
	X[t,1]<-0
	X[t,2]<-sin(2*pi*(t- length(ar))/frequency)
	X[t,3]<- cos(2*pi*(t- length(ar))/frequency)
  }
  for (t in (1+ length(ar)): (N+ length(ar))){
	X[t,1]<-x[t- length(ar)]
	X[t,2]<-sin(2*pi*(t- length(ar))/frequency)
	X[t,3]<- cos(2*pi*(t- length(ar))/frequency)
  }
  y.sim <- garsim(n=(N+length(ar)),phi=ar, X=X, beta= beta.x, sd=sqrt(1)) 
  y<-y.sim[(1+length(ar)):(N+length(ar))]
  tsy<-ts(y, freq=frequency)
  plot(tsy)
  Xreg<-matrix(nrow= N, ncol=3)
  for (t in 1: N){
	Xreg[t,1]<-x[t]
	Xreg[t,2]<-sin(2*pi*t/frequency)
	Xreg[t,3]<- cos(2*pi*t/frequency)
  }
  arimares<-arima(tsy, order=c(1,1,0), xreg=Xreg)
  tsdiag(arimares)

  #Negative binomial simulation with covariate
  ar<-c(0.8)
  frequency<-1
  beta.x<-0.7
  X=matrix(c(rep(log(intercept), N+length(ar)), rep(0, length(ar)), x), ncol=2)
  y.sim <- garsim(n=(N+length(ar)), phi=ar, beta=c(1,beta.x), link= "log", family=  "negative.binomial", zero.correction = "zq1", c=1, theta=5, X=X) 
  y<-y.sim[(1+length(ar)):(N+length(ar))]
  tsy<-ts(y, freq=frequency)
  plot(tsy)

  #Poisson ARMA(1,1) with identity link and negative auto correlation
  N<-500
  phi<-c(-0.8)
  theta<-c(0.6)
  ar<-arrep(phi=phi, theta=theta)
  check<-(acf2AR(ARMAacf(ar=phi, ma=theta, lag.max = 100, pacf = FALSE))[100,1:length(ar)])
  as.data.frame(cbind(ar,check))
  intercept<-100
  frequency<-1
  X=matrix(c(rep(intercept, N+length(ar))), ncol=1)
  y.sim <- garsim(n=(N+length(ar)), phi=ar, beta=c(1), link= "identity", family= "poisson", minimum = -100, X=X) 
  y<-y.sim[(1+length(ar)):(N+length(ar))]
  tsy<-ts(y, freq=frequency)
  plot(tsy)

  #Poisson AR(1) with identity link and negative auto correlation
  N<-1000
  ar<-c(-0.8)
  intercept<-100
  frequency<-1
  X=matrix(c(rep(intercept, N+length(ar))), ncol=1)
  y.sim <- garsim(n=(N+length(ar)), phi=ar, beta=c(1), link= "identity", family= "poisson", minimum = -100, X=X) 
  y<-y.sim[(1+length(ar)):(N+length(ar))]
  tsy<-ts(y, freq=frequency)
  plot(tsy)

  #Example of negative binomial GSARIMA(2,1,0,0,0,1)x
  phi<-c(0.5,0.2)
  theta<-c(0)
  Theta<-c(0.5)
  Phi<-c(0)
  d<-c(1)
  D<-c(0)
  frequency<-12
  ar<-arrep(phi=phi, theta=theta, Phi=Phi, Theta=Theta, frequency= frequency, d=d, D=D)
  N<-c(1000)
  intercept<-c(10)
  x<- rnorm(N)
  beta.x<-c(0.7)
  X<-matrix(c(rep(log(intercept), N+length(ar)), rep(0, length(ar)), x), ncol=2)
  c<-c(1)
  y.sim <- garsim(n=(N+length(ar)), phi=ar, beta=c(1,beta.x), link= "log", family= "negative.binomial", zero.correction = "zq1", c=c, theta=5, X=X) 
  y<-y.sim[(1+length(ar)):(N+length(ar))]
  tsy<-ts(y, freq=frequency)
  plot(tsy)
  plot(log(tsy))
}
\keyword{ ts}
