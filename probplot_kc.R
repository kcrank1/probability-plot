probplot_kc <- function(x, qdist=qnorm, probs=NULL, line=TRUE,
                     xlab=paste("Probability", "\u2264"), ylab=NULL, stdev=FALSE, xline=FALSE, yline=FALSE,stadj=0,...)
{
  DOTARGS <- as.list(substitute(list(...)))[-1]
  DOTARGS <- paste(names(DOTARGS), DOTARGS, sep="=",collapse=", ")

  y <- sort(x)
 
  QNAME <- deparse(substitute(qdist))
  DOTS <- list(...)
  qdist <- match.fun(qdist)
  QFUN <- function(p){
    args=DOTS
    args$p=p
    do.call("qdist", args)
  }
  
  x <- QFUN(ppoints(length(y)))
  
  if(is.null(probs)){
    probs <- c(.01, .05, seq(.1,.9, by=.1), .95, .99)
    if(length(x)>=1000)
      probs <- c(0.001, probs, .999)
  }
  
  qprobs <- QFUN(probs)
    stdevs<-c(.025,.16,.50,.84,.975)
    sd<- QFUN(stdevs)
  
 
  plot(x, y, axes=FALSE, type="n", xlim=range(c(x,qprobs)),
       xlab=xlab, ylab=ylab)
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
  axis(2)#commenting this out for C. auris plotting purposes only, use this for every other application
  #axis(2, at=seq(1,3.25,by=0.25), labels=c('1.0',1.25,1.5,1.75,'2.0',2.25,2.5,2.75,'3.0',3.25))
  
  points(x, y)
  
  #linear regression and line plotting
  xl <- qdist(c(0.25, 0.75), ...)
  yl <- quantile(y, c(0.25, 0.75))
  slope <- diff(yl)/diff(xl)
  int <- yl[1] - slope * xl[1]
  
  if(line){
    abline(int, slope, col="red")
  }
  
  z <- list(qdist=QFUN, int=int, slope=slope)
  class(z) <- "probplot"
  invisible(z)
}
# Example usage:
set.seed(123)
x <- rnorm(100)
probplot_kc(x, xlab = "Custom X Label", ylab = "Custom Y Label",line=TRUE,stdev=TRUE,stadj=0.3)
