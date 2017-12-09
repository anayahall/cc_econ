# Anaya Hall
# CCE - Fall 2017
# FINAL COMPONENT: SEA LEVEL RISE

using Mimi

@defcomp sealevelrise begin
    slr         = Variable(index=[time])        # Sea level rise (Global mean in meters)
    slr_damages = Variable(index=[time])        # Climate Damages from sea level rise
                                                # [SHARE OF GROSS OUTPUT - fraction of YGROSS[t]]

    temp        = Parameter(index=[time])    # From CLIMATE DYNAMICS COMPONENT
    ef          = Parameter()                # E-folding time (=500.0)
    slsens      = Parameter()                # Sea Level Sensitivity to Temp (2.0)

    psi         = Parameter()                # Damage parameter #1 (0.005)
    omega       = Parameter()                # Damage parameter #2 (0.003)  

end

function run_timestep(state::sealevelrise, t::Int64)
    v = state.Variables
    p = state.Parameters

    if t == 1
        v.slr[t] = 0.0
    else
        v.slr[t] = ((1 - (1/p.ef))*(v.slr[t-1])) + (p.slsens*(1/p.ef)*p.temp[t])
    end

    v.slr_damages[t] = (p.psi*v.slr[t]) + (p.omega*(v.slr[t])^2)
    
end

