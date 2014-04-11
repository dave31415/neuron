#neuron
library(data.table)
library(timsac)

datadir="/Users/davej/TW/kaggle/neuron/data"

file.name<-function(name='normal-1',type='ts'){
  path=paste(datadir,name,sep='/')
  tag=''
  if (type=='ts') {
    #time series
    tag='/fluorescence_'
  } 
  if (type =='net') {
    #network if it is a training set
    tag='/network_'
  }
  if (type =='pos') {
    #neuron positions
    tag='/networkPositions_'
  }

  stopifnot(tag!='')
  if (name =='small') {
    #pick one, 1 to 6 
    num=1
    name=paste('iNet1_Size100_CC0',num,'inh',sep='')
  }
  file=paste(path,tag,name,'.txt',sep='')
  print(file)
  stopifnot(file.exists(file))
  return(file)
}

read.data<-function(name='normal-1',type='ts'){
  #read neuron time series data
  file=file.name(name=name,type=type)
  return(data.table(read.csv(file,header=F)))  
}

xcor<-function(ts,num1=1,num2=1,lag.max=500){
  x=ts[[num1]]
  y=ts[[num2]]
  L=length(x)
  a=array(c(x,y),dim=c(L,2))
  #xc=fftcor(a,lag=lag.max)
  xc=ccf(x,y)
  return(xc)
}

plot.some<-function(d,nsamp=8,tmin=1,tmax=3000){
  num.neuron=ncol(d)
  num.time=nrow(d)
  s=sample(num.neuron,nsamp)
  plot(0,0,cex=0,xlim=c(tmin-1,tmax+1),ylim=c(0,nsamp+2),xlab="Time",ylab="Response")
  for (i in 1:nsamp) {
    lines(tmin:tmax,d[[s[i]]][tmin:tmax]+i,lw=1)
    lines(tmin:tmax,rep(i,tmax-tmin+1),lw=0.7,col='lightblue')
  }
}

