# Anaya Hall
# CCE - Fall 2017
# Assignment 7 : Damages with Income Elasticity

using Mimi

@defcomp damages begin
    d_frac      = Variable(index=[time])     # Damage Fraction
    d_dollars   = Variable(index=[time])   # Damage Dollars

    d_elast    = Parameter()               # Income Elasticity 
    d_coeff     = Parameter()
    d_coeff_sq  = Parameter()
    temp        = Parameter(index=[time])   # From Climate Dynamics!
    d_exp       = Parameter()           
    YGROSS      = Parameter(index=[time])   # From Economy

end

function run_timestep(state::damages, t::Int64)
    v = state.Variables
    p = state.Parameters

    v.d_frac[t] = ((p.d_coeff * p.temp[t]) + (p.d_coeff_sq * p.temp[t]^2)) * (p.YGROSS[t]/p.YGROSS[1])^(p.d_elast)

    v.d_dollars[t] = v.d_frac[t] * p.YGROSS[t]

end

