# Anaya Hall
# CCE - Fall 2017

using Mimi
using NLopt

include("parameters.jl")
include("constructmodel.jl")

rho = 0.00
eta = 1.0
#discount3 = [1/((1.03)^t) for t in 1:291]

# No emissions policy???
# epolicy = fill(0.0,291)

rho_array = [0.001, 0.01, 0.03]

count = 0 # keep track of # function evaluations

epolicy = Array{Float64}(291)

function wrapper(;x::AbstractArray=fill(0.0,10))

    global count
    count::Int += 1
    println("f_$count($x)")

    println("**********************************")
    println("ABOUT TO LOOOOOOOOOOOOOP year")
    println("**********************************")
    
    for year in 1:291
        println("YEAR!!! ", year)
        if year < 100
            epolicy[year] = x[(round(year/10))]
        else
            epolicy[year] = x[10]
        end
    end
    
    # for t in 1:291
    #     epolicy[t] = x[1]
    # end

    println("INSIDE WRAPPER!! EPOLICY: ", epolicy[1], "***...***", epolicy[100])
   
    bau_run = run_my_model(scenario="bau")

    return sum(bau_run[:welfare, :welfare])
    
    # return(x.*700)

end

# function myfunc(x::Vector, grad::Vector)
#     if length(grad) > 0
#         grad[1] = 0
#         grad[2] = 0.5/sqrt(x[2])
#     end

#     global count
#     count::Int += 1
#     println("f_$count($x)")

#     sqrt(x[2])
# end

for i in rho_array

    rho = i

    #optimization!!
    opt = Opt(:LN_NELDERMEAD, 10)
    lower_bounds!(opt, [0.,0.,0.,0.,0.,0.,0.,0.,0.,0.])
    upper_bounds!(opt, [1.,1.,1.,1.,1.,1.,1.,1.,1.,1.])

    max_objective!(opt::Opt, wrapper::Function)
    maxeval!(opt, 5)
    # decvar = fill(0.1,10)

    println("**********************************")
    println("ABOUT TO OPTIMIZE!")
    println("**********************************")   

    (maxf,maxx,ret) = optimize(opt::Opt, fill(0.5,10))
    println("got $maxf at $maxx after $count iterations (returned $ret)")

    # println("RHO: ", i)
    # println("SOCIAL WELFARE: ", welfare_sum)
    # println("**********************************")

end

##########################################################
# PLOTS

# include("A13_plots.jl")

# ep01 = bau_run[:emissions, :epolicy].+3
# ep1 = bau_run[:emissions, :epolicy].+2
# ep3 = bau_run[:emissions, :epolicy].+5

# plot1 = emissionrate(xarray=year, yarray1=ep01, yarray2=ep1, yarray3=ep3)

# temp01 = bau_run[:climatedynamics, :temp]*0.5
# temp1 = bau_run[:climatedynamics, :temp]*3
# temp3 = bau_run[:climatedynamics, :temp]*6
# temp_nopol = bau_run[:climatedynamics, :temp]

# plot2 = tempplot(xarray=year, yarray1=temp01, yarray2=temp1, yarray3=temp3, yarray4=temp_nopol)