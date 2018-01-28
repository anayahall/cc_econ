using DataFrames

include("carboncycle.jl")
println("CARBON CYCLE RUNNING")
println("output", carbon_data)

#non-co2 forcing data
rcp85conc =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_CONCENTRATIONS/RCP85_MIDYEAR_CONCENTRATIONS-Table 1.csv")
rcp85rf   =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_RADFORCING/RCP85_MIDYEAR_RADFORCING-Table 1.csv")


rcp85rf = rcp85rf[(rcp85rf[:v_YEARS_GAS_].>=2010)&(rcp85rf[:v_YEARS_GAS_].<=2300),:]


#Set Parameters
alpha = 5.35    # (S2: Ramaswamy 2001)
climate_sens = (3/(5.35*log(2)))    # in C/Wm^-2 (S3: Marten)
delay = (1/66)      # Provided in assignment
T0 = 0.85       # Pre-industrial average global temperature (C) (S4: BEST (Rhodes 2013))
CO20 = 275

# println("*************************")
# println("*************************")
# println("*************************")

println("CO2 concs   ", carbon_data[:CO2conc])
df = carbon_data


function calcForcing(;CO2constant=false)
    df = carbon_data
    tempanomaly = 0
    forcing_data = DataFrame(Year = Float64[], CO2emis = Float64[], CO2conc = Float64[], TempAnomaly = Float64[], scenario = AbstractString[])
    
    for (index, year) in enumerate(df[:Year])   
       
        #ADJUST!
        if CO2constant
            CO2 = CO20
            scenario = "constant CO2"
        else
            CO2 = df[:CO2conc][index]
            scenario = "base" 
        end

        co0 = 275
        RF_CO2 = alpha*log(CO2/co0)

        RF_Other = rcp85rf[:NON_CO2_RF][index]

        RF_total = RF_CO2 + RF_Other

        Eq_temp = climate_sens * RF_total

        if index === 1
            tempanomaly = T0
        else 
            tempanomaly = tempanomaly + delay*((Eq_temp)-tempanomaly)
        end
        
        meantemp = T0 + tempanomaly
        CO2emis = df[:CO2emis][index]
        push!(forcing_data, [year, CO2emis, CO2, tempanomaly, scenario])
    end
    return forcing_data
end

# base = calcForcing(CO2constant=false)
# constant = calcForcing(CO2constant=true)

# forcing_data = [base;constant]
