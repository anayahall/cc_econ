#Construct Model!

using DataFrames
using Gadfly

include("carboncycle.jl")
include("calcForcing.jl")



######################################
#### CARBON CYCLE COMPONENT      #####
######################################

carbon_base = carboncycle(CO2constant=false)  #Base Scenario


######################################
#### CLIMATE DYNAMICS COMPONENT  #####
######################################

forcing_base = calcForcing(CO2constant=false)



#run both scenarios
#CO2 constant Scenarios
carbon_constant = carboncycle(CO2constant=true)   #Constant CO2 Scenario
forcing_constant = calcForcing(CO2constant=true)

df = [forcing_base;forcing_constant]


######################################
#### PLOTS
######################################

xarray = df[:Year][df[:scenario].=="base"]
y1b = df[:CO2conc][df[:scenario].=="base"]
y1c = df[:CO2conc][df[:scenario].=="constant CO2"]
y2b = df[:TempAnomaly][df[:scenario].=="base"]
y2c = df[:TempAnomaly][df[:scenario].=="constant CO2"]



concplot = plot( layer(x=xarray, y=y1b, Geom.line, Theme(default_color=color("red")) ),
    layer(x=xarray, y=y1c, Geom.line, Theme(default_color=color("blue")) ),
    Guide.xlabel("Year"), Guide.ylabel("CO2 conc (ppm)"), 
    Guide.title("CO2 Concentration"),
    Guide.manual_color_key("Scenario", ["Base", "Constant"], ["red", "blue"]))


tempplot = plot(layer(x=xarray, y=y2b, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=y2c, Geom.line, Theme(default_color=color("blue"))), 
    Guide.xlabel("Year"), Guide.ylabel("Temperature (C)"), Guide.title("Temperature Anomaly"),
    Guide.manual_color_key("Scenario", ["Base", "Constant"], ["red", "blue"]))


#OUTPUT Table
writetable("climatemodel.csv", df)
    