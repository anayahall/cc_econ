# Anaya Hall
# CCE - Fall 2017
# Assignment 6 : Damages

using Mimi

@defcomp damages begin
    d_frac      = Variable(index=[time])     # Damage Fraction
    d_dollars   = Variable(index=[time])   # Damage Dollars
    consumption = Variable(index=[time])    # Consumption
    cons_pc     = Variable(index=[time])    # Consumption per capita
    
    d_coeff     = Parameter()
    d_coeff_sq  = Parameter()
    temp        = Parameter(index=[time])   # From Climate Dynamics!
    d_exp       = Parameter()           
    YGROSS      = Parameter(index=[time])   # From Economy
    YNET        = Parameter(index=[time])   # From Economy
    pop         = Parameter(index=[time])   # From kaya
    savings     = Parameter(index=[time])               # From DICE

end

function run_timestep(state::damages, t::Int64)
    v = state.Variables
    p = state.Parameters

    v.d_frac[t] = (p.d_coeff * p.temp[t]) + (p.d_coeff_sq * p.temp[t]^p.d_exp)

    v.d_dollars[t] = v.d_frac[t] * p.YGROSS[t]

    v.consumption[t] = p.YNET[t] - (p.savings[t]*p.YNET[t])
    
    v.cons_pc[t] = v.consumption[t] / p.pop[t]




end