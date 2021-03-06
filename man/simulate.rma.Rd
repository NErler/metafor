\name{simulate.rma}
\alias{simulate.rma}
\title{Simulate Method for 'rma' Objects}
\description{
   The function simulates observed outcomes based on \code{"rma"} model object.
}
\usage{
\method{simulate}{rma}(object, nsim = 1, seed = NULL, \dots)
}
\arguments{
   \item{object}{an object of class \code{"rma"}.}
   \item{nsim}{number of response vectors to simulate (defaults to 1).}
   \item{seed}{an object specifying if and how the random number generator should be initialized (\sQuote{seeded}). Either \code{NULL} or an integer that will be used in a call to \code{set.seed} before simulating the response vectors. If set, the value is saved as the \code{"seed"} attribute of the returned value. The default, \code{NULL} will not change the random generator state, and return \code{\link{.Random.seed}} as the \code{"seed"} attribute; see \sQuote{Value}.}
   \item{\dots}{other arguments.}
}
\details{
   The model specified via \code{object} must be a model fitted with either the \code{\link{rma.uni}} or \code{\link{rma.mv}} function.
}
\value{
   A data frame with \code{nsim} columns with the simulated outcomes.

   The data frame comes with an attribute \code{"seed"}. If argument \code{seed} is \code{NULL}, the attribute is the value of \code{\link{.Random.seed}} before the simulation was started; otherwise it is the value of the argument with a \code{"kind"} attribute with value \code{as.list(\link{RNGkind}())}.
}
\author{
   Wolfgang Viechtbauer \email{wvb@metafor-project.org} \cr
   package website: \url{http://www.metafor-project.org/} \cr
   author homepage: \url{http://www.wvbauer.com/}
}
\references{
   Viechtbauer, W. (2010). Conducting meta-analyses in R with the metafor package. \emph{Journal of Statistical Software}, \bold{36}(3), 1--48. \url{http://www.jstatsoft.org/v36/i03/}.
}
\seealso{
   \code{\link{rma.uni}}, \code{\link{rma.mv}}
}
\examples{
### load BCG vaccine data
dat <- get(data(dat.bcg))

### calculate log risk ratios and corresponding sampling variances
dat <- escalc(measure="RR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)
dat

### random-effects model
res <- rma(yi, vi, data=dat)
res

### simulate outcomes from model
newdat <- simulate(res, nsim=10, seed=1234)
}
\keyword{models}
