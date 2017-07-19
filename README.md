# Spatial-Interpolation-in-R
Spatial Interpolation predicts values for cells in a raster from a limited number of sample data points. It can be used to predict unknown values for any geographic point data: elevation, rainfall, chemical concentrations, noise levels, and so on.

Interpolation methods implemented here are Inverse distance weighted and Trend surface.
IDW : Weights are proportional to the inverse of the distance (between the data point and the prediction location) raised to the power value p.

Trend Surface : The principle of a trend surface model is a regression function that estimates the property value Pi at any location, based on the Xi,Yi coordinates of this location. The surface is approximated using polynomial function.

Input file is a .txt file that contains the (x,y) locations and the values (z) at the location.
Value of power p in idw can be varied using the 'idp' parameter. 
Output is a plot containing predicted values at unknown locations.

Screenshot : Left is an interpolated plot of lead data using IDW with p=10 and right is the interpolated plot of the same in trend surface.