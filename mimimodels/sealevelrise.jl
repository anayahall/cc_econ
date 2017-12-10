# Anaya Hall
# CCE - Fall 2017
# FINAL COMPONENT: SEA LEVEL RISE

using Mimi

@defcomp sealevelrise begin
    slr         = Variable(index=[time])        # Sea level rise (Global mean in meters)
                                                # [SHARE OF GROSS OUTPUT - fraction of YGROSS[t]]
    temp        = Parameter(index=[time])    # From CLIMATE DYNAMICS COMPONENT
    ef          = Parameter()                # E-folding time (=500.0)
    slsens      = Parameter()                # Sea Level Sensitivity to Temp (2.0)

end

function run_timestep(state::sealevelrise, t::Int64)
    v = state.Variables
    p = state.Parameters

    if t == 1
        v.slr[t] = 0.0
    else
        v.slr[t] = ((1 - (1/p.ef))*(v.slr[t-1])) + (p.slsens*(1/p.ef)*p.temp[t])
    end
    
end

