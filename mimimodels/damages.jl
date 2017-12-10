# Anaya Hall
# CCE - Fall 2017
# Assignment 7 : Damages with Income Elasticity

using Mimi

@defcomp damages begin
    d_frac      = Variable(index=[time])     # Damage Fraction
    d_dollars   = Variable(index=[time])   # Damage Dollars (not including SLR)

    slr_damages = Variable(index=[time])  # SLR damages from sea level rise (Fraction)
    
    slr_d_dollars = Variable(index=[time]) # SLR damages as DOLLAR
    total_damages = Variable(index=[time])  # TOTAL CLIMATE DAMAGES INCLUDING SLR
    
    d_elast    = Parameter()               # Income Elasticity 
    d_coeff     = Parameter()
    d_coeff_sq  = Parameter()
    temp        = Parameter(index=[time])   # From Climate Dynamics!
    d_exp       = Parameter()           
    YGROSS      = Parameter(index=[time])   # From Economy

    slr         = Parameter(index=[time])    # SLR from SLR component
    psi         = Parameter()                # Damage parameter #1 (0.005)
    omega       = Parameter()                # Damage parameter #2 (0.003)  
   
end

function run_timestep(state::damages, t::Int64)
    v = state.Variables
    p = state.Parameters

    v.d_frac[t] = ((p.d_coeff * p.temp[t]) + (p.d_coeff_sq * p.temp[t]^2.)) * (p.YGROSS[t]/p.YGROSS[1])^(p.d_elast)

    v.d_dollars[t] = v.d_frac[t] * p.YGROSS[t] 

    if t == 1 
        v. slr_damages[t] = 0.0
    else
        v.slr_damages[t] = (p.psi * p.slr[t-1]) + (p.omega * (p.slr[t-1]) ^ 2)
    end

    v.slr_d_dollars[t] = (v.slr_damages[t]) * p.YGROSS[t]
    
    v.total_damages[t] = v.d_dollars[t] + v.slr_d_dollars[t]

end

