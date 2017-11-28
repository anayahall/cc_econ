# Anaya Hall
# CCE - Fall 2017
# Assignment 13 : Welfare

using Mimi


@defcomp welfare begin
    #Variables
    welfare = Variable(index=[time])     # social welfare
   
    #Parameters
    pop       = Parameter(index=[time])    # Population
    rho       = Parameter()                # Pure rate of time preference
    pccons    = Parameter(index=[time])
    
end

function run_timestep(state::welfare, t::Int64)
    v = state.Variables
    p = state.Parameters

    v.welfare[t] = p.pop[t]*log(p.pccons[t])*(1/(1+p.rho))

end
