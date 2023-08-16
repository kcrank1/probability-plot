probplot_multiple <- function(vectors, qdist=qnorm, probs=NULL, line=TRUE,
                              xlab=paste("Probability", "\u2264"), ylab=NULL,stdev=FALSE, xline=FALSE, yline=FALSE,stadj=0, ...)
{
  DOTARGS <- as.list(substitute(list(...)))[-1]
  DOTARGS <- paste(names(DOTARGS), DOTARGS, sep="=", collapse=", ")
  
  vectors_sorted <- lapply(vectors, sort)
  
  QNAME <- deparse(substitute(qdist))
  DOTS <- list(...)
  qdist <- match.fun(qdist)
  QFUN <- function(p){
    args <- DOTS
    args$p <- p
    do.call("qdist", args)
  }
  
  x <- QFUN(ppoints(length(unlist(vectors_sorted[1]))))
  
  if(is.null(probs)){
    probs <- c(.01, .05, seq(.1,.9, by=.1), .95, .99)
    if(length(x) >= 1000)
      probs <- c(0.001, probs, .999)
  }
  
  qprobs <- QFUN(probs)
  stdevs<-c(.025,.16,.50,.84,.975)
  sd<- QFUN(stdevs)
  
  plot(x, unlist(vectors_sorted[1]), axes=FALSE, type="n",
       xlim=range(c(x, qprobs)), ylim = range(c(min(unlist(vectors_sorted)),max(unlist(vectors_sorted)))), xlab=xlab, ylab=ylab)
  box()
  
  abline(v=qprobs, col="grey")
  if(stdev){
    abline(v=sd, col="black",lwd=1.2)
    #Adjust the value that is added to the max below in order to arrange the stdev labels to the proper position
    text(sd,max(y)+stadj,c(paste0("-2","\u03c3"),paste0("-1","\u03c3"),"",paste0("1","\u03c3"),paste0("2","\u03c3")),xpd=NA)
  }
  if(xline){
    abline(v=QFUN(xline),col="red",lty="dashed")
  }
  if(yline){
    abline(h=yline,col="red",lty="dashed")
  }
 
  axis(1, at=qprobs, labels=100*probs)
  axis(2)
  
  for (i in seq_along(vectors_sorted)) {
    points(x, unlist(vectors_sorted[i]), col=i)
  }
  

  if(line) {
    for (i in seq_along(vectors_sorted)) {
      xl <- qdist(c(0.25, 0.75), ...)
      yl <- quantile(unlist(vectors_sorted[i]), c(0.25, 0.75))
      slope <- diff(yl) / diff(xl)
      int <- yl[1] - slope * xl[1]
      abline(int, slope, col=i)
    }
  }
  int=NULL
  slope=NULL
  z <- list(qdist=QFUN, int=int, slope=slope)
  class(z) <- "probplot"
  invisible(z)
}

# Example usage:
set.seed(123)
x <- rnorm(100)
y <- rnorm(100, mean = 2, sd = 1.5)
z <-rnorm(100,mean=3,sd=1)
probplot_multiple(list(x, y,z), xlab = "Custom X Label", ylab = "Custom Y Label",line=TRUE,stdev=TRUE,stadj=0.7)
