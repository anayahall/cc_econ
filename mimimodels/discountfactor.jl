# Anaya Hall
# CCE - Fall 2017
# Assignment 10 : Ramsey Discount Factor

using Mimi


@defcomp discountfactor begin
    #Variables
    ramseyDF    = Variable(index=[time])     # Ramsey Discount Factor
    constantDF  = Variable(index=[time])     # Constant Discount Factor
    
    #Parameters
    rho   = Parameter()                # RHO - Pure Rate of Time Preference
    eta    = Parameter()                 # ETA = risk aversion
    pccons = Parameter(index=[time])     # Per capita consumption #FROM NET ECONOMY
    year   = Parameter(index=[time])
end

function run_timestep(state::discountfactor, t::Int64)
    v = state.Variables
    p = state.Parameters
    

    v.ramseyDF[t] = (p.pccons[1]/p.pccons[t]) * (1/((1+p.rho)^(p.year[t])))

end

