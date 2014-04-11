#neuron
library(data.table)

datadir="/Users/davej/TW/kaggle/neuron/data"

read.ts<-function(name='valid'){
  #read neuron time series data
  path=paste(datadir,name,sep='/')
  file=paste(path,'/fluorescence_',name,'.txt',sep='')
  print(file)
  return(data.table(read.csv(file,header=F)))  
}
