#neuron
library(data.table)

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
  file=paste(path,tag,name,'.txt',sep='')
  print(file)
}

read.data<-function(name='normal-1',type='ts'){
  #read neuron time series data
  file=file.name(name=name,type=type)
  return(data.table(read.csv(file,header=F)))  
}
