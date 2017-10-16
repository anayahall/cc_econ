# Anaya Hall
# CCE - Fall 2017
# Assignment 5 : Economic Growth

using Mimi


@defcomp grosseconomy begin
    #Variables
    YGROSS = Variable(index=[time])     # Gross Output (trillions of dollars)
    K       = Variable(index=[time])    #Capital
  
    
    #Parameters
    L       = Parameter(index=[time])    # Labor
    s       = Parameter(index=[time])    # Savings rate    
    k0      = Parameter()                #Initial level of capital
    depk    = Parameter()                #Depreciation rate on capital - assume to be 0.05
    alpha   = Parameter()                # Factor share
    A       = Parameter(index=[time])    # Technology (Total Productivity Factor ~ 3 -> 30)
    kaya_gdp = Parameter(index=[time])    #SSP GDP
    YNET    = Parameter(index=[time])
    
end

function run_timestep(state::grosseconomy, t::Int64)
    v = state.Variables
    p = state.Parameters

    #Define an equation for K
    if t == 1
        v.K[t]  = p.k0  
    else
        v.K[t]  = (1 - p.depk) * v.K[t-1] + p.YNET[t-1] * p.s[t-1] 
    end

    #Define an equation for YGROSS
    v.YGROSS[t] = p.A[t] * (v.K[t]^p.alpha) * (p.L[t]^(1-p.alpha))

end



@defcomp neteconomy begin

    YNET = Variable(index=[time])
    consumption = Variable(index=[time])    # Consumption
    cons_pc     = Variable(index=[time])    # Consumption per capita

    YGROSS = Parameter(index=[time])
    abatement = Parameter(index=[time])      # called ab_cost in abatement.jl
    d_dollars = Parameter(index=[time])      # Damage Dollars (from damages.jl) 
    pop         = Parameter(index=[time])   # From kaya
    savings     = Parameter(index=[time])   # From DICE 

end

function run_timestep(state::neteconomy, t::Int64)
    v = state.Variables
    p = state.Parameters

    #define equation for YNET
    v.YNET[t] = p.YGROSS[t] - p.abatement[t] - p.d_dollars[t]

    #define consumption
    v.consumption[t] = v.YNET[t] - (p.savings[t]*v.YNET[t])
    v.cons_pc[t] = v.consumption[t] / p.pop[t]

end