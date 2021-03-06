### Create dispersal kernel plots for SharkRayMPA project

displot<-function(data, cn, var="dis", xlab="Maximum dispersal distance (km)", ylab="Relative frequency", breaks=seq(0,log(10000+1), l=30), mar=c(4,4,1,1), bar.col=NA, bar.border=1 ,xlim=log(c(0,5000)+1), lcol=2, dist=c("gamma","kernel","normal"),...){
  dat<-subset(data, common_name%in%cn)
  if(nrow(dat)>3){
    a<-log(dat[dat[,var]>0,var]+1)
    xfit<-seq(0,max(a),length=1000)
    par(mar=mar)
    h<-hist(a, plot=F, breaks=breaks, ...)
    if(dist=="normal"){
      # normal distribution
      yfn<-dnorm(xfit,mean=mean(a),sd=sd(a));
      yfitn<-yfn
      hist(a, breaks=breaks, freq=F, xaxt="n", las=1, main="", ylab=ylab, xlab=xlab, col=bar.col, border=bar.border, xlim=xlim, ylim=range(0,max(yfitn, na.rm=T),max(h$density, na.rm=T)), ...)
      axis(1, at= log(c(0.01, seq(0.1,1,l=10), seq(1,10,l=10),seq(10,100,l=10), seq(100,1000,l=10), seq(1000,10000,l=10))+1), labels=F, tcl=-0.3)
      axis(1, at= log(c(0.1,1,10,100,1000,10000)+1), labels=c(0.1,1,10,100,1000,10000))
      lines(xfit, yfitn, col=lcol, lwd=2) 
    }
    if(dist=="gamma"){
      # gamma distribution
      yfg<-dgamma(xfit,shape=mean(a)^2/var(a),scale=var(a)/mean(a)); 
      yfitg<-yfg
      hist(a, breaks=breaks, freq=F, xaxt="n", las=1, main="", ylab=ylab, xlab=xlab, col=bar.col, border=bar.border, xlim=xlim, ylim=range(0,max(yfitg, na.rm=T),max(h$density, na.rm=T)), ...)
      axis(1, at= log(c(0.01, seq(0.1,1,l=10), seq(1,10,l=10),seq(10,100,l=10), seq(100,1000,l=10), seq(1000,10000,l=10))+1), labels=F, tcl=-0.3)
      axis(1, at= log(c(0.1,1,10,100,1000,10000)+1), labels=c(0.1,1,10,100,1000,10000))
      lines(xfit, yfitg, col=lcol, lwd=2)
    }
    if(dist=="kernel"){
      # kernel distribution
      yfk<-density(a, n=1000, adjust=2)$y
      yfitk<-yfk
      hist(a, breaks=breaks, freq=F, xaxt="n", las=1, main="", ylab=ylab, xlab=xlab, col=bar.col, border=bar.border, xlim=xlim, ylim=range(0,max(yfitk, na.rm=T),max(h$density, na.rm=T)), ...)
      axis(1, at= log(c(0.01, seq(0.1,1,l=10), seq(1,10,l=10),seq(10,100,l=10), seq(100,1000,l=10), seq(1000,10000,l=10))+1), labels=F, tcl=-0.3)
      axis(1, at= log(c(0.1,1,10,100,1000,10000)+1), labels=c(0.1,1,10,100,1000,10000))
      lines(xfit, yfitk, col=lcol, lwd=2)
    }
    box(bty="l")
    legend('topright', bty="n", pch=NA, col=NA, legend=cn, text.font=2, cex=1.2)
  } else {
    message("Not enough data")
  }
}