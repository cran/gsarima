\name{arrep}
\alias{arrep}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Compute the Autoregressive Representation of a Sarima Model }
\description{
  Invert (invertible) SARIMA(p, d, q, P, D, Q) models to ar representation.
}
\usage{
arrep(notation = "arima", phi = c(rep(0, 10)), d = 0, theta = c(rep(0, 10)), Phi = c(rep(0, 10)), D = 0, 
	Theta = c(rep(0, 10)), frequency = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{notation}{ "arima" for notation of the type used by the function arima(stats), "dse1" for type  notation used by the package dse1. }
  \item{phi}{ p vector of autoregressive coefficient. }
  \item{d}{ difference operator, implemented: d element of (0,1,2). }
  \item{theta}{ q vector of moving average coefficients. }
  \item{Phi}{ P vector of seasonal autoregressive coefficients. }
  \item{D}{ Seasonal difference operator, implemented: D element of (0,1,2). }
  \item{Theta}{ Q vector of seasonal moving average coefficients. }
  \item{frequency}{ The frequency of the seasonality (e.g. frequency = 12 for monthly series with annual periodicity). }
}
\details{
  For input, positive values of phi, theta, Phi and Theta indicate positive dependence. 
     Implemented for p,q,P,Q element of c(0,1,2,3,4,5,6,7,8,9,10). The ar representation is truncated at coefficients less than 1.0e-10. Values of theta, Theta near non invertibility (-1 or 1) will not be practical and will cause near infinite lags, especially for Theta and large frequency.
}
\value{
A vector containing a truncated autoregressive representation of a SARIMA model. This can be used as input for the function gar.sim.
}
\references{ to be published }
\author{ Olivier Briet \email{ o.briet.antispam.@gmail.com } }
\seealso{ 'garsim'. }
\examples{
phi<-c(0.5, 0.3, 0.1)
theta<-c(0.6, 0.2, 0.2)
ar<-arrep(phi=phi, theta=theta, frequency=12)
check<-(acf2AR(ARMAacf(ar=phi, ma=theta, lag.max = 100, pacf = FALSE))[100,1:length(ar)])
as.data.frame(cbind(ar,check))
phi<-c(0.2,0.5)
theta<-c(0.4)
Phi<-c(0.6)
Theta<-c(0.3)
d<-2
D<-1
frequency<-12
ar<-arrep(phi=phi, theta=theta, Phi=Phi, Theta=Theta, frequency= frequency, d=d, D=D)
N<-500
intercept<-10
data.sim <- garsim(n=(N+length(ar)),phi=ar, X=matrix(rep(intercept,(N+ length(ar)))),
beta=1, sd=1) 
y<-data.sim[1+length(ar): (N+length(ar))]
tsy<-ts(y, freq= frequency)
plot(tsy)
arima(tsy, order=c(2,2,1), seasonal=list(order=c(1,1,1)))
}
\keyword{ ts }
