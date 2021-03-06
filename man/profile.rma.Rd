\name{profile.rma.uni}
\alias{profile.rma.uni}
\alias{profile.rma.mv}
\alias{plot.profile.rma}
\title{Profile Plots for 'rma' Objects}
\description{Function to profile the (restricted) log-likelihood for objects of class \code{"rma.uni"} and \code{"rma.mv"}.}
\usage{
\method{profile}{rma.uni}(fitted, xlim, ylim, steps=20,
        progbar=TRUE, parallel="no", ncpus=1, cl=NULL, plot=TRUE, pch=19, \ldots)

\method{profile}{rma.mv}(fitted, sigma2, tau2, rho, gamma2, phi, xlim, ylim, steps=20, startmethod="init",
        progbar=TRUE, parallel="no", ncpus=1, cl=NULL, plot=TRUE, pch=19, \ldots)

\method{plot}{profile.rma}(x, ylim, pch=19, ylab, \ldots)
}
\arguments{
   \item{fitted}{an object of class \code{"rma.uni"} or \code{"rma.mv"}.}
   \item{x}{an object of class \code{"profile.rma"} (for \code{plot}).}
   \item{sigma2}{integer specifying for which \if{latex}{\eqn{\sigma^2}}\if{html}{\eqn{\sigma²}}\if{text}{\eqn{\sigma^2}} value the likelihood should be profiled (only relevant for \code{"rma.mv"} objects).}
   \item{tau2}{integer specifying for which \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} value the likelihood should be profiled (only relevant for \code{"rma.mv"} objects).}
   \item{rho}{integer specifying for which \eqn{\rho} value the likelihood should be profiled (only relevant for \code{"rma.mv"} objects).}
   \item{gamma2}{integer specifying for which \if{latex}{\eqn{\gamma^2}}\if{html}{\eqn{\gamma²}}\if{text}{\eqn{\gamma^2}} value the likelihood should be profiled (only relevant for \code{"rma.mv"} objects).}
   \item{phi}{integer specifying for which \eqn{\phi} value the likelihood should be profiled (only relevant for \code{"rma.mv"} objects).}
   \item{xlim}{optional vector specifying the lower and upper limit of the parameter over which the profiling should be done. If unspecified, the function tries to set these limits automatically.}
   \item{ylim}{optional vector specifying the y-axis limits when plotting the profiled likelihood. If unspecified, the function tries to set these limits automatically.}
   \item{steps}{number of points between \code{xlim[1]} and \code{xlim[2]} (inclusive) for which the likelihood should be evaluated (the default is 20).}
   \item{startmethod}{method for picking starting values for the optimization. Default is \code{"init"}, which starts each model fit at the default initial values. The alternative is \code{"prev"}, which starts at the estimates from the previous model fit (usually faster, but also less stable for ill-defined models).}
   \item{progbar}{logical indicating whether a progress bar should be shown (the default is \code{TRUE}).}
   \item{parallel}{character string indicating whether parallel processing should be used (the default is \code{"no"}). For parallel processing, set to either \code{"snow"} or \code{"multicore"}. See \sQuote{Details}.}
   \item{ncpus}{integer specifying the number of processes to be used in the parallel operation.}
   \item{cl}{optional snow cluster to use if \code{parallel="snow"}. If not supplied, a cluster on the local machine is created for the duration of the call.}
   \item{plot}{logical indicating whether the profile plot should be drawn after profiling is finished (the default is \code{TRUE}).}
   \item{pch}{plotting symbol to use. By default, a filled circle is used. See \code{\link{points}} for other options.}
   \item{ylab}{title for the y-axis. If unspecified, the function tries to set an appropriate axis title.}
   \item{\dots}{other arguments.}
}
\details{
   The function fixes a particular variance component or correlation parameter of the model and then computes the maximized (restricted) log-likelihood over the remaining parameters of the model. By doing this for a range of values for the parameter that was fixed, a profile of the (restricted) log-likelihood is constructed.

   For objects of class \code{"rma.uni"} obtained with the \code{\link{rma.uni}} function, the function profiles over parameter \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}}. If the model was fitted with \code{method="ML"} or \code{method="REML"}, the profiled (restricted) log-likelihood should be maximized at the ML/REML estimate of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}}.

   For objects of class \code{"rma.mv"} obtained with the \code{\link{rma.mv}} function, profiling is done by default over all (non-fixed) variance and correlation components of the model. Alternatively, one can use the \code{sigma2}, \code{tau2}, \code{rho}, \code{gamma2}, or \code{phi} arguments to specify over which parameter the profiling should be done. Only one of these arguments can be used at a time. A single integer is used to specify the number of the parameter. Each profile plot should show a peak at the corresponding ML/REML estimate. If the profiled likelihood is flat (over the entire parameter space or large portions of it), then this suggests that at least some of the parameters of the model are not identifiable (and the parameter estimates obtained are to some extent arbitrary).

   Profiling requires repeatedly refitting the same model, which can be slow when \eqn{k} is large and/or the model is complex (the latter especially applies to \code{"rma.mv"} objects). On machines with multiple cores, one can usually speed things up by delegating the model fitting to separate worker processes, that is, by setting \code{parallel="snow"} or \code{parallel="multicore"} and \code{ncpus} to some value larger than 1. Parallel processing makes use of the \code{\link[parallel]{parallel}} package, using the \code{\link[parallel]{makePSOCKcluster}} and \code{\link[parallel]{parLapply}} functions when \code{parallel="snow"} or using the \code{\link[parallel]{mclapply}} function when \code{parallel="multicore"} (the latter only works on Unix/Linux-alikes). With \code{parallel::detectCores()}, one can check on the number of available cores on the local machine. Note that argument \code{startmethod} is ignored when using parallel processing and no progress bar will be shown.
}
\value{
   An object of class \code{"profile.rma"}. The object is a list (or list of lists) containing the following components:
   \item{sigma2}{values of \if{latex}{\eqn{\sigma^2}}\if{html}{\eqn{\sigma²}}\if{text}{\eqn{\sigma^2}} over which the likelihood was profiled (only when profiling was actually done over \if{latex}{\eqn{\sigma^2}}\if{html}{\eqn{\sigma²}}\if{text}{\eqn{\sigma^2}}).}
   \item{tau2}{values of \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}} over which the likelihood was profiled (only when profiling was actually done over \if{latex}{\eqn{\tau^2}}\if{html}{\eqn{\tau²}}\if{text}{\eqn{\tau^2}}).}
   \item{rho}{values of \eqn{\rho} over which the likelihood was profiled (only when profiling was actually done over \eqn{\rho}).}
   \item{gamma2}{values of \if{latex}{\eqn{\gamma^2}}\if{html}{\eqn{\gamma²}}\if{text}{\eqn{\gamma^2}} over which the likelihood was profiled (only when profiling was actually done over \if{latex}{\eqn{\gamma^2}}\if{html}{\eqn{\gamma²}}\if{text}{\eqn{\gamma^2}}).}
   \item{phi}{values of \eqn{\phi} over which the likelihood was profiled (only when profiling was actually done over \eqn{\phi}).}
   \item{ll}{(restricted) log-likelihood at the corresponding parameter value.}
   \item{beta}{a matrix with the estimated model coefficients at the corresponding parameter value.}
   \item{ci.lb}{a matrix with the lower confidence interval bounds for the model coefficients at the corresponding parameter value.}
   \item{ci.ub}{a matrix with the upper confidence interval bounds for the model coefficients at the corresponding parameter value.}
   \item{\dots}{some additional elements/values.}
   Note that the list is returned invisibly.
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
### calculate log odds ratios and corresponding sampling variances
dat <- escalc(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)

### random-effects model using rma.uni()
res <- rma(yi, vi, data=dat)

### profile over tau^2
profile(res)

### change data into long format
dat.long <- to.long(measure="OR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)

### set levels of group variable ("exp" = experimental/vaccinated; "con" = control/non-vaccinated)
levels(dat.long$group) <- c("exp", "con")

### set "con" to reference level
dat.long$group <- relevel(dat.long$group, ref="con")

### calculate log odds and corresponding sampling variances
dat.long <- escalc(measure="PLO", xi=out1, mi=out2, data=dat.long)

### bivariate random-effects model using rma.mv()
res <- rma.mv(yi, vi, mods = ~ group, random = ~ group | study, struct="UN", data=dat.long)
res

### profile over tau^2_1, tau^2_2, and rho
### note: for rho, adjust region over which profiling is done ('zoom in' on area around estimate)
\dontrun{
par(mfrow=c(3,1))
profile(res, tau2=1)
profile(res, tau2=2)
profile(res, rho=1, xlim=c(.90, .98))}
}
\keyword{hplot}
