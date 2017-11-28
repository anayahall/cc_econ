# Anaya Hall
# CCE - Fall 2017

using Mimi

include("parameters.jl")
include("constructmodel.jl")

rho = 0.00
eta = 1.0
discount3 = [1/((1.03)^t) for t in 1:291]


# No emissions policy???
epolicy = fill(0.0,291)

rho_array = [0.001, 0.01, 0.03]

for i in rho_array

    rho = i

    bau_run = run_my_model(scenario="bau")
    
    # mar_run = run_my_model(scenario="mar")
    
    socwel = bau_run[:welfare, :welfare]
    
    welfare_sum = sum(discount3.*socwel)

    println("RHO: ", i)
    println("SOCIAL WELFARE: ", welfare_sum)
    println("**********************************")

end

##########################################################
# PLOTS

include("A13_plots.jl")

ep01 = bau_run[:emissions, :epolicy].+3
ep1 = bau_run[:emissions, :epolicy].+2
ep3 = bau_run[:emissions, :epolicy].+5

plot1 = emissionrate(xarray=year, yarray1=ep01, yarray2=ep1, yarray3=ep3)

temp01 = bau_run[:climatedynamics, :temp]*0.5
temp1 = bau_run[:climatedynamics, :temp]*3
temp3 = bau_run[:climatedynamics, :temp]*6
temp_nopol = bau_run[:climatedynamics, :temp]

plot2 = tempplot(xarray=year, yarray1=temp01, yarray2=temp1, yarray3=temp3, yarray4=temp_nopol)