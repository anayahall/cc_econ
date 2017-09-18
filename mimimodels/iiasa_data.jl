# Anaya Hall
# CCE - Fall 2017

#Fix IIASA Data

using DataFrames
using Gadfly

function load_kaya()
    
    data = readtable("/Users/anayahall/projects/CCecon/data/kaya/SSP5_WorldData.csv")
    
end
    
kaya = load_kaya()
kayadf = kaya[6:end,:]

# FORMULAS 

year = collect(2005:2300)
luco2 = fill(0,296)
pop   = fill(0,296)
gdppc = fill(0,296)
energyi = fill(0,296)
carboni = fill(0,296)

# df = [year luco2 gdppc pop energyi carboni]

function extend_kaya()

    df = DataFrame(Year = Float64[], LUCO2 = Float64[], GDPPC = Float64[], 
    Pop = Float64[], Energyi = Float64[], Carboni = Float64[])
    
    for (index, year) in enumerate(year)
        
        println("YEAR: ", year)
        println("INDEX: ", index)
        if year.<2092                               # Decreasing emissions 
            luco2 = -57.003*(year) + 119296
        else
            luco2 = 0.0                             # Constant zero after 2092
        end
        println("LU EMIS: ", luco2)
        gdppc = (2E-204) * (year) ^ 61.966
        println("GDP PC ", gdppc)
        pop = -0.7347*(year) ^ 2 + 3024.1*year - 3E+06  
        println("POP: ", pop)    
        # energyi =(1E-06)*(year) ^ 2 - (0.0041)(year) + 4.2876     #POLYNOMIAL
        energyi = (1E+13)*e^(-0.018*year)                           #EXPONENTIAL FXN
        println("energyi ", energyi)
        # carboni = (0.0009)(year) ^ 2 - 3.7937*year + 4051.3       #POLYNOMIAL
        carboni = (8E+09) * year ^ (-2.421)                         #POWER
        println("Carbon I ", carboni)
        
        # if y == 2005
        #     luco2 = kaya[:LUCO2][1]
        # else 
        #     luco2 = -57.003(year) + 119296
        # end
        push!(df, [year luco2 gdppc pop energyi carboni])
    end
    return df
end

kayadata = extend_kaya()

# CHECK FUNCTIONAL FORM OF PARAMETERS!!!
# yvar = kayadata[:Pop]

# plot(x = kayadata[:Year], y = yvar)