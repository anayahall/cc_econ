# Anaya Hall
# CCE - Fall 2017
# Assignment 1 : Climate Dynamics Model

using Mimi

@defcomp climatedynamics begin

    RF_CO2          = Variable(index=[time]) 
    RF_Total        = Variable(index=[time])
    Eq_temp         = Variable(index=[time])
    temp            = Variable(index=[time])

    CO2ppm          = Parameter(index=[time])
    CO2ppm0         = Parameter()
    RF_Other        = Parameter(index=[time])
    temp0           = Parameter()
    climate_sens    = Parameter()
    delay           = Parameter()

end

function run_timestep(state::climatedynamics, t::Int64)
    v = state.Variables
    p = state.Parameters

    v.RF_CO2[t] = 5.35 * log(p.CO2ppm[t]/p.CO2ppm0)
    v.RF_Total[t] = v.RF_CO2[t] + p.RF_Other[t]

    v.Eq_temp[t] = p.climate_sens * v.RF_Total[t]

    if t == 1
        v.temp[t] = p.temp0
    else
        v.temp[t] = v.temp[t-1] + p.delay * (v.Eq_temp[t] - v.temp[t-1])
    end

end 

