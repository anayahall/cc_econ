# Anaya Hall
# CCE - Fall 2017
# Assignment 4 : Abatement Cost

using Mimi


@defcomp abatement begin

    AC_coeff    = Variable(index=[time])       # Abatement Cost Coefficient
    AC_share    = Variable(index=[time])       # Abatement Cost Share
    bkstop      = Variable(index=[time])
    sigma       = Variable(index=[time])
    ab_cost     = Variable(index=[time])
    sigma_rate   = Variable(index=[time])
    
    sigma_rate   = Parameter()    
    bkstp0       = Parameter()                  # Backstop Price ( $1000 / tC )
    sigma0       = Parameter()                  # Sigma (industrial, MTCO2/$1000)
    AC_exponent = Parameter()                   # Exponent of control cost function
    epolicy     = Parameter(index=[time])       # Emissions Policy Control
    gdp         = Parameter(index=[time])       # GDP per capita ($/person)
    
end



function run_timestep(state::abatement, t::Int64)
    v = state.Variables
    p = state.Parameters
    
    if t == 1
        v.bkstop[t] = p.bkstp0
        v.sigma_rate[t] = -0.01
        v.sigma[t] = p.sigma0
    else
        v.bkstop[t] = v.bkstop[t-1] * (1 - 0.005)
        v.sigma_rate[t] = v.sigma_rate[t-1]*(1+p.sigma_rate)
        v.sigma[t]  = v.sigma[t-1] * exp(v.sigma_rate[t])
    end

    v.AC_coeff[t] = v.bkstop[t] * v.sigma[t] / p.AC_exponent / 1000

    v.AC_share[t] = v.AC_coeff[t] * (p.epolicy[t] ^ p.AC_exponent)

    v.ab_cost[t] = v.AC_share[t]*p.gdp[t]
end

