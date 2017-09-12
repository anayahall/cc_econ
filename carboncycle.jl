# Anaya Hall
# CCE - Fall 2017
# Assignment 2 : Carbon Cycle Model

using DataFrames
using Gadfly

# bring in data
rcp85emis =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_EMISSIONS.csv")
#need to use fossil, industrial and landuse related CO2 emissions 
#NOTE: Emissions are given in GtC/year

df = rcp85emis[37:end,1:3]                 #get rid of metadeta

rename!(df, :RCP85__EMISSIONS____________________________, :Year)
df[:Year] = float(df[:Year])
df[:x] = float(df[:x])                    #Units are GtC/yr
df[:x_1] = float(df[:x_1])                #Units are GtC/yr

#Rename for clarity!
rename!(df, :x, :FossilCO2)
rename!(df, :x_1, :OtherCO2)

#Sum emissions
df[:CO2emis] = df[:FossilCO2] + df[:OtherCO2]
df = df[(df[:Year].>=2010)&(df[:Year].<=2300),:]

sdf = df

### set parameters
alpha = 0.5

#Carbon cycle transition coefficients (from DICE model) adjusted to per 1 years
global b21 = (3.83 / 100) / 5
global b12 = (8.80 / 100) / 5
global b32 = (0.03 / 100) / 5
global b23 = (0.25 / 100) / 5
global b11 = 1. - b12
global b22 = 1. - b21 - b23
global b33 = 1. - b32

M_atm0 = ((2*818.985)+(3*839.646))/5       #weighted average for 2010
M_up0 =  1527.000 
M_lo0 =  10010.000 
reduction = 0.5

function carboncycle(;CO2constant=false)               #;scenario=AbstractString[])
    M_atm = M_atm0
    M_up = M_up0
    M_lo = M_lo0

    for (index, year) in enumerate(df[:Year])
        println("****************")        
        println("Year:", year)
        # println("Emissions (MtC): ", df[:CO2emis][index])
        
        #Scenario 
        if CO2constant
            df[:CO2emis] = 0
            # println("Scenario: ", scenario)
        else 
            df[:CO2emis] = df[:CO2emis]
            # println("Scenario: ", scenario)
        # elseif scenario == "imm_reduce"
        #     CO2emis = df[:CO2emis] * reduction
        #     println("Scenario: ", scenario)
        # elseif scenario == "later_reduce"
        #     println("Scenario: ", scenario)
        #     if df[:Year][index] < 2049
        #         CO2emis = df[:CO2emis][index]
        #         println("CO2: ", df[:CO2emis][index])
        #     else
        #         CO2emis = df[:CO2emis][42]
        #         println("CO2: ", df[:CO2emis][index])                
        #     end
        end
        
        if index == 1
            M_atm = M_atm0
        else
            #save previous years for use in formulas
            M_lo_lag = M_lo
            M_up_lag = M_up
            M_atm_lag = M_atm

            #calculate new concentrations in three resevoirs
            M_atm = df[:CO2emis] + (b11 * M_atm) + (b21 * M_up_lag)            
            M_lo = (b23 * M_up_lag) + (b33 * M_lo_lag)
            M_up = (b12 * M_atm_lag) + (b22 * M_up_lag) + (b32 * M_lo_lag)
        end
        df[:M_atm] = M_atm
        # df[:CO2emis] = CO2emis
        # df[:scenario] = scenario
    end
    df[:CO2conc] = df[:M_atm]/2.12
    df                      # Change GtC to ppm
    return df
end

carbon_data = df


#TEST RUN
# constant = carboncycle(CO2constant=true)
#           #Constant CO2 Scenario
# base = carboncycle(CO2constant=false)                     #Base Scenario
# # scen3 = carboncycle(scenario="imm_reduce") 
# # scen4 = carboncycle(scenario="later_reduce") 


# carbon_data = [base;constant]

# carbon_data = base


# if df[:Year][index] < 2049
#     # df[:CO2emis]= df[:CO2emis]
#     println("year less than 2049", year)
# else
#     # df[:CO2emis] = df[:CO2emis][41]
#     println("Year above 2049", year)
# end