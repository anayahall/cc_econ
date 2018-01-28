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
df[:all_emis] = df[:FossilCO2] + df[:OtherCO2]
df = df[(df[:Year].>=2010)&(df[:Year].<=2300),:]

### set parameters
alpha = 0.5

#Carbon cycle transition coefficients (PER FIVE YEARS)
global b21 = (3.83 / 100) / 5
global b12 = (8.80 / 100) / 5
global b32 = (0.03 / 100) / 5
global b23 = (0.25 / 100) / 5
global b11 = (91.20 / 100) - b12
global b22 = (95.92 / 100) - b21 - b23
global b33 = (99.97 / 100) - b32

function carboncycle()
    M_atm = 0
    M_up = 0
    M_lo = 0
    for (index, year) in enumerate(df[:Year])
        println("****************")        
        println("Year:", year)
        println("Emissions (MtC): ", all_emis[index])
        if index == 1
            M_atm = all_emis[index]
            print("*M_atm", M_atm)
        else

            M_lo0 = M_lo
            M_up0 = M_up
            println("M_lo0 ", M_lo0)

            M_lo = (b23 * M_up) + (b33 * M_lo)
            M_up = (b12 * M_atm) + (b22 * M_up) + (b32 * M_lo0)
            M_atm = all_emis[index] + (b11 * M_atm) + (b21 * M_up0)

            println("M_lo ", M_lo)
            println("M_up ", M_up)
            println("M_atm ", M_atm)

        end
        # println("CO2 Conc: ", M_atm)
        df[:M_atm] = M_atm
    end
    return df
end

carboncycle()
