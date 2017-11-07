# Anaya Hall
# CCE - Fall 2017

# DEFINE PARAMETERS FOR COMPONENTS
using DataFrames

######################################
####   GROSS & NET ECONOMY       #####
######################################

# L = [(1. + 0.015)^t *6404/5 for t in 1:291]
A = [(0.118t - 235.06) for t in 2010:2300]      #Trendline from DICE values
# A = [(1. + 0.065)^t * 3.57 for t in 1:291]
s = ones(291).* 0.22
k0 = 135.0          #From Dice!
depk = 0.1          #From Dice!
alpha = 0.3          #From Dice!


######################################
####   EMISSIONS COMPONENT      #####
######################################

include("iiasa_data.jl")

df = kayadata
L       = df[:Population]
pop     = df[:Population]                  # persons (millions of people)   
gdppc   = df[:GDPperCapita]                # GDP per capita ($ billions / millions of person)
energyi = df[:Energy_Intensity]            # Energy Intensity = Energy Use (EJ) / GDP (billions $)
carboni = df[:Emissions_intensity]         # Carbon Intensity = Emissions (Mt CO2) / Energy (EJ)
luco2   = df[:LandUseEmissions]            # CO2 emissions from Land use (Mt CO2)
kaya_gdp  = pop .* gdppc

######################################
## EMISSIONS REDUCTIONS / ABATEMENT ## (FROM DICE MODEL)
######################################

bkstp0       = 344.000                # Initial Backstop Price ( $1000 / tC )
sigma0       = 0.489                  # Initial Sigma (industrial, MTCO2/$1000)
sigma_rate   = -0.001                 # Growth rate of sigma (per year, log)
AC_exponent  = 2.800                  # Exponent of control cost function


######################################
#### CARBON CYCLE COMPONENT      #####
######################################

M_atm0 = ((2*818.985)+(3*839.646))/5       #weighted average for 2010
M_up0 =  1527.000                          #From DICE Model
M_lo0 =  10010.000 

### CO2 EMISSIONS  ####
function emission_data()
    
    # bring in data
    rcp85emis =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_EMISSIONS.csv")
    #need to use fossil, industrial and landuse related CO2 emissions NOTE: Emissions are given in GtC/year
    df = rcp85emis[37:end,1:3]                 #get rid of metadeta

    rename!(df, :RCP85__EMISSIONS____________________________, :Year)
    df[:Year] = float(df[:Year])
    df[:x] = float(df[:x])                    #Units are GtC/yr
    df[:x_1] = float(df[:x_1])                #Units are GtC/yr

    #Rename for clarity & subset to get years of interest
    rename!(df, :x, :FossilCO2)
    rename!(df, :x_1, :OtherCO2)
    df = df[(df[:Year].>=2010)&(df[:Year].<=2300),:]

    #Sum emissions
    CO2emis = df[:FossilCO2] + df[:OtherCO2]
    return CO2emis
end

# CO2emis = emission_data()

######################################
#### CLIMATE DYNAMICS COMPONENT  #####
######################################

### Bring in NON-CO2 Radiative Forcing Data
function forcing_data()
    rcp85rf   =  readtable("/Users/anayahall/projects/CCecon/data/RCP85_MIDYEAR_RADFORCING/RCP85_MIDYEAR_RADFORCING-Table 1.csv")
    rcp85rf = rcp85rf[(rcp85rf[:v_YEARS_GAS_].>=2010)&(rcp85rf[:v_YEARS_GAS_].<=2300),:]

    RF_Other = rcp85rf[:NON_CO2_RF]
    return RF_Other
end

RF_Other = forcing_data()

CO2ppm0 = 275.0
climate_sens = 3 / (5.35 * log(2))
delay = (1/66)
temp0 = 0.85

######################################
####   DAMAGES                  #####
######################################

d_coeff = 0.0               # From Valeri!
d_coeff_sq = 0.003          # From Valeri!
d_exp = 2.0                 # From Valeri!
d_elast = 0.00             