# Anaya Hall
# CCE - Fall 2017
# Assignment 4 : Abatement Cost

using Mimi


@defcomp abatement begin

    # emis    = Variable(index=[time])        #Emissions (MtC/yr)

    # pop     = Parameter(index=[time])       # persons (millions?)   
    # gdppc   = Parameter(index=[time])       # GDP per capita ($/person)
    # energyi = Parameter(index=[time])       # Energy Intensity = Energy Use (EJ) / GDP ($)
    # carboni = Parameter(index=[time])       # Carbon Intensity = Emissions (Mt CO2) / Energy (EJ)
    # luco2   = Parameter(index=[time])

end

function run_timestep(state::abatement, t::Int64)
    v = state.Variables
    p = state.Parameters

    # v.emis[t] = ((p.pop[t] * p.gdppc[t] * p.energyi[t] * p.carboni[t]) + p.luco2[t])* (12/44) / 10^3
    # println("TIME: ", t, "----- EMIS: ", v.emis[t])
end