# Anaya Hall
# CCE - Fall 2017
# Assignment 4 : Abatement Cost

using Mimi


@defcomp abatement begin

    AC_coeff    = Variable(index=[time])       # Abatement Cost Coefficient (in GtCO2)
    AC_share    = Variable(index=[time]) 
    ab_cost     = Variable(index=[time])
    
          # Abatement Cost Share
    backstop      = Parameter(index=[time])        # in thousands USD
    sigma       = Parameter(index=[time])        # MtCO2 per thousands USD
    AC_exponent = Parameter()            # Exponent of control cost function
    epolicy     = Parameter(index=[time])       # Emissions Policy Control
    YGROSS      = Parameter(index=[time])       # GDP (YGROSS)
    
end

function run_timestep(state::abatement, t::Int64)
    v = state.Variables
    p = state.Parameters
    
    v.AC_coeff[t] = (p.backstop[t] * p.sigma[t] / p.AC_exponent) / 1000 

    v.AC_share[t] = v.AC_coeff[t] * (p.epolicy[t] ^ p.AC_exponent) 

    v.ab_cost[t] = v.AC_share[t]* p.YGROSS[t] 
end

