# Anaya Hall
# CCE - Fall 2017
# Assignment 1 : Climate Dynamics Model

#using Mimi
using DataFrames
using Gadfly

#Bring in CO2 Concentration & Radiative Forcing data from RCP8.5 (S1: Riahi 2007)
rcp85conc =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_CONCENTRATIONS/RCP85_MIDYEAR_CONCENTRATIONS-Table 1.csv")
rcp85rf   =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_RADFORCING/RCP85_MIDYEAR_RADFORCING-Table 1.csv")

#Parameters
alpha = 5.35    # (S2: Ramaswamy 2001)
lamda = 0.32    # in C/Wm^-2 (S3: Marten?)
w = (1/66)      # Provided in assignment
T0 = 13.8       # Pre-industrial average global temperature (C) (S4: )

function calcForcing(;CO2constant=false)
tempanomaly = 0
df = DataFrame(Year = Float64[], CO2conc = Float64[], Temp = Float64[], constant = Float64[])
    for (index, year) in enumerate(rcp85conc[:v_YEARS_GAS_])
        println("**************")
        println("Year: ", year)
        println("CO2 conc (ppm): ", rcp85conc[:CO2][index])
        
        println("CO2constant ", CO2constant)
        if CO2constant
            CO2 = rcp85conc[:CO2][1]
            constant = 1.0
        else
            CO2 = rcp85conc[:CO2][index]
            constant = 0.0 
        end

        co0 = rcp85conc[:CO2][1]
        CO2forcing = alpha*log(CO2/co0)
        println("CO2 FORCING (W/m^2):", CO2forcing)

        nCO2forcing = rcp85rf[:NON_CO2_RF][index]
        println("NON-CO2 Forcing (W/m^2):", rcp85rf[:NON_CO2_RF][index])

        forcing = CO2forcing + nCO2forcing
        println("Total RF (W/m^2): ", forcing)

        dTemp = lamda*forcing
        println("Change in Temp (C): ", dTemp)

        if index === 1
            tempanomaly = 0
        else 
            tempanomaly = tempanomaly + w*((lamda*forcing)-tempanomaly)
        end
        println("Temp Anomaly (C): ", tempanomaly)
        
        meantemp = T0 + tempanomaly
        println("Global Temperature (C): ", meantemp) 

        push!(df, [year, CO2, meantemp, constant])
    end
    return df
end

# Run function
calcForcing(CO2constant=false) #change boolean for different scenarios
base = df


calcForcing(CO2constant=true) #change boolean for different scenarios
constant = df

# push!(main_df, df[year, CO2, meantemp, constant])

# #graphs: 

# subset of years (2010:2300)
sub_b = base[(base[:Year].>2010)&(base[:Year].<2300),:]
sub_c = constant[(constant[:Year].>2010)&(constant[:Year].<2300),:]


#base case (b) & constant case (c)

xarray = sub_df[:Year]
y1b = sub_b[:CO2conc]
y1c = sub_c[:CO2conc]
y2b = sub_b[:Temp]
y2c = sub_c[:Temp]

# y1b = sub_df[:CO2conc][sub_df[:constant].==0]
# y1c = sub_df[:CO2conc][sub_df[:constant].==1]
# y2b = sub_df[:Temp][sub_df[:constant].==0]
# y2c = sub_df[:Temp][sub_df[:constant].==1]

plot1 = plot(layer(x=xarray, y=y1b, Geom.line),
            layer(x=xarray, y=y1c, Geom.line),
        Guide.xlabel("Year"), Guide.ylabel("CO2 conc (ppm)"), 
        Guide.title("CO2 Concentration"))


 plot2 = plot(x=xarray, y=y2array, Geom.line, 
     Guide.xlabel("Year"), Guide.ylabel("Temperature (C)"), Guide.title("2. Temperature"))


# function co2plot(yeararray, co2array)
#     println("**makefucnplot**")
#     plot(x=yeararray, y=co2array)
# end

