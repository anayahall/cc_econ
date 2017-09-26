# Anaya Hall
# CCE - Fall 2017
# Assignment 2 : Carbon Cycle Model

using Mimi

#Define relative concentration parameters
b21 = (3.83 / 100) / 5
b12 = (8.80 / 100) / 5
b32 = (0.03 / 100) / 5
b23 = (0.25 / 100) / 5
b11 = 1. - b12
b22 = 1. - b21 - b23
b33 = 1. - b32

@defcomp carboncycle begin
    
    M_atm   = Variable(index=[time])    #Atm conc at time t
    M_lo    = Variable(index=[time])    #Lower ocean conc at time t
    M_up    = Variable(index=[time])    #Upper ocean conc at time t
    CO2ppm  = Variable(index=[time])    #CO2 concentration in atm in ppm

    CO2emis = Parameter(index=[time])   #CO2 emissions in Gt/year from emissions component
    M_atm0  = Parameter()               #Initial atm conc
    M_lo0   = Parameter()               #Intial lower ocean conc
    M_up0   = Parameter()               #Intial upper ocean conc

end

function run_timestep(state::carboncycle, t::Int64)
    v = state.Variables
    p = state.Parameters
    
    #Defining flows of CO2 between atmosphere, upper and lower ocean
    if t == 1
        v.M_atm[t] = p.M_atm0
        v.M_lo[t] = p.M_lo0
        v.M_up[t] = p.M_up0
    else
        v.M_atm[t] = p.CO2emis[t] + (b11 *v.M_atm[t-1]) + (b21 * v.M_up[t-1])            
        v.M_lo[t] = (b23 * v.M_up[t-1]) + (b33 * v.M_lo[t-1])
        v.M_up[t] = (b12 * v.M_atm[t-1]) + (b22 * v.M_up[t-1]) + (b32 * v.M_lo[t-1])
    end

    v.CO2ppm[t] = v.M_atm[t] / 2.12

end


