# Anaya Hall
# CCE - Fall 2017
# Assignment 3 : Emissions Model

# KAYA : Emissions = Pop * (GDP/POP) * (EU/GDP) * (EM/EU)

using Mimi

#GtCO2 --> Gt = *12/44


@defcomp emissions begin

    emis        = Variable(index=[time])        # Total Emissions (GtC/yr)
    fossil      = Variable(index=[time])        # Fossil Emissions (Mt CO2 / year)

    # pop         = Parameter(index=[time])       # persons (millions?)   
    # gdppc       = Parameter(index=[time])       # GDP per capita ($/person)
    YGROSS         = Parameter(index=[time])       #GDP from ECONOMY COMPONENT (Trillions of dollars)
    energyi     = Parameter(index=[time])       # Energy Intensity = Energy Use (EJ) / GDP ($)
    carboni     = Parameter(index=[time])       # Carbon Intensity = Emissions (Mt CO2) / Energy (EJ)
    luco2       = Parameter(index=[time])       # Land use CO2 emissions (Mt / year)
    epolicy     = Parameter(index=[time])

end

function run_timestep(state::emissions, t::Int64)
    v = state.Variables
    p = state.Parameters

    v.fossil[t] = (p.YGROSS[t] * p.energyi[t] * p.carboni[t])    
    v.emis[t] =  (v.fossil[t] + p.luco2[t]) * (1 - (p.epolicy[t])) * (12/44)/(10^3)     #convert from Mt CO2 to Gt C
    # println("TIME: ", t, "----- EMIS: ", v.emis[t])


end

