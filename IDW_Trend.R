sample<- read.table('/path/to/file.txt',header=T)
# and convert to sp object
spat.samp <- sample
coordinates(spat.samp) <- c('x','y')
# construct a grid of locations to predict at
grid <- expand.grid(x=seq(0,1,0.05), y=seq(0,1,0.05))
plot(grid)
spat.grid <- grid
# convert grid to a SpatialPoints object
coordinates(spat.grid) <- c('x','y')
# and tell sp that this is a grid
gridded(spat.grid) <- T
library(gstat)
sampinterp.idw <- idw(z~1, spat.samp, spat.grid)
# first argument is a formula.  
#   left hand side is the response variable
#   right hand side specifies the trend model variables
#   for idw, r.h.s. MUST be ~1, i.e. constant mean
# second is the spatial data set from which to get the obs.
# third is the set of locations at which to predict

# result is an spatial object with coordinates and two data columns:
#  var1.pred: the predictions for variable 1 (z here)
#  var1.var: the prediction variance.  Not computed for idw

sampinterp.idw@data$var1.pred
# or, if predicting on a grid, can use bubble or spplot to plot the gridded values
spplot(sampinterp.idw, 'var1.pred')
# default power is 2, can change by specifying idp in call to idw
sampinterp1.idw1 <- idw(z~1,spat.samp, spat.grid, idp=10)

spplot(sampinterp1.idw1, 'var1.pred')
# compare to previous spplot plor

# Trend Surface
sample<- read.table('/path/to/file.txt',header=T)
# and convert to sp object
spat.samp <- sample
coordinates(spat.samp) <- c('x','y')
# construct a grid of locations to predict at
grid <- expand.grid(x=seq(0,1,0.05), y=seq(0,1,0.05))
plot(grid)
spat.grid <- grid
# convert grid to a SpatialPoints object
coordinates(spat.grid) <- c('x','y')
# and tell sp that this is a grid
gridded(spat.grid) <- T
library(gstat)

sample.lm <- lm(Pb ~ x + y, data=spat.samp)
sample.lmq <- lm(Pb ~ x + y + I(x^2) + I(y^2) + I(x*y), data=spat.samp)
sample.ts <- predict(sample.lm, newdata=spat.grid)
sample.tsq <- predict(sample.lmq, newdata=spat.grid)
spat.grid<- SpatialPixelsDataFrame(spat.grid, data.frame(ts=sample.ts, tsq=sample.tsq) )
spplot(spat.grid, 'ts')
spplot(spat.grid, 'tsq')
