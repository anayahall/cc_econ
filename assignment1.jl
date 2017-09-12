# Anaya Hall
# CCE - Fall 2017
# Assignment 1 : Climate Dynamics Model
# (First attempt at using Julia!)

using DataFrames
using Gadfly

#Bring in CO2 Concentration & Radiative Forcing data from RCP8.5 (S1: Riahi 2007)
rcp85conc =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_CONCENTRATIONS/RCP85_MIDYEAR_CONCENTRATIONS-Table 1.csv")
rcp85rf   =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_RADFORCING/RCP85_MIDYEAR_RADFORCING-Table 1.csv")

#Set Parameters
alpha = 5.35    # (S2: Ramaswamy 2001)
lamda = 0.32    # in C/Wm^-2 (S3: Marten)
w = (1/66)      # Provided in assignment
T0 = 8.2       # Pre-industrial average global temperature (C) (S4: BEST (Rhodes 2013))

function calcForcing(;CO2constant=false)
    tempanomaly = 0
    df = DataFrame(Year = Float64[], CO2conc = Float64[], AbsTemp = Float64[], TempAnomaly = Float64[], constant = Float64[])

    for (index, year) in enumerate(rcp85conc[:v_YEARS_GAS_])   
       
        if CO2constant
            CO2 = rcp85conc[:CO2][1]
            constant = 1.0
        else
            CO2 = rcp85conc[:CO2][index]
            constant = 0.0 
        end

        co0 = rcp85conc[:CO2][1]
        CO2forcing = alpha*log(CO2/co0)

        nCO2forcing = rcp85rf[:NON_CO2_RF][index]

        forcing = CO2forcing + nCO2forcing

        dTemp = lamda*forcing

        if index === 1
            tempanomaly = 0
        else 
            tempanomaly = tempanomaly + w*((lamda*forcing)-tempanomaly)
        end
        
        meantemp = T0 + tempanomaly

        push!(df, [year, CO2, meantemp, tempanomaly, constant])
    end
    return df
end

# Run function twice (for base scenario and constant CO2 scenario)
base = calcForcing(CO2constant=false) #change boolean for different scenarios
constant = calcForcing(CO2constant=true) #change boolean for different scenarios

# merge output
main_df = [base;constant]


# subset of years we care about (2010:2300)
sub_df = main_df[(main_df[:Year].>=2010)&(main_df[:Year].<=2300),:]

#define arrays for plots [base case (b) & constant case (c)]
xarray = sub_df[:Year][sub_df[:constant].==0]
y1b = sub_df[:CO2conc][sub_df[:constant].==0]
y1c = sub_df[:CO2conc][sub_df[:constant].==1]
y2b = sub_df[:TempAnomaly][sub_df[:constant].==0]
y2c = sub_df[:TempAnomaly][sub_df[:constant].==1]


### PLOT
concplot = plot(   layer(x=xarray, y=y1b, Geom.line, Theme(default_color=color("red"))  ),
                layer(x=xarray, y=y1c, Geom.line, Theme(default_color=color("blue")) ),
        Guide.xlabel("Year"), Guide.ylabel("CO2 conc (ppm)"), 
       Guide.title("CO2 Concentration"),
       Guide.manual_color_key("Scenario", ["Base", "Constant"], ["red", "blue"]))


 tempplot = plot(layer(x=xarray, y=y2b, Geom.line, Theme(default_color=color("red"))),
        layer(x=xarray, y=y2c, Geom.line, Theme(default_color=color("blue"))), 
     Guide.xlabel("Year"), Guide.ylabel("Temperature (C)"), Guide.title("Temperature Anomaly"),
     Guide.manual_color_key("Scenario", ["Base", "Constant"], ["red", "blue"]))

#save data
writetable("climatemodel1.csv",sub_df)
