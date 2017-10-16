# Anaya Hall
# CCE - Fall 2017
# ASSIGNMENT 5

include("constructmodel.jl")

########################################################
##################### RUN MODEL ########################
########################################################

using Mimi
include("parameters.jl")

# EMISSIONS POLICY SCENARIOS
# #
epolicy1 = ones(291).*0.0
# epolicy1 = [(10/291)*t for t in 1:291]
for (index,y) in enumerate(1:291)
    if y == 1
        epolicy1[y] = .30
    else
        epolicy1[y] = 0.0
    end
    # println("Y: ", y , "---- EPOLICY ", epolicy1[y])
end

bau_run = run_my_model(scenario="bau")
ep1_run = run_my_model(scenario="EP1")

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

########################################################
################### PLOT OUTPUT ########################
########################################################

include("plots.jl")
include("scenarios.jl")

# tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = constant_temp, yarray3 = ir_temp, yarray4 = lr_temp)
# cplot = concplot(xarray = year, yarray1 = BAU_conc, yarray2 = constant_conc, yarray3 = ir_conc, yarray4 = lr_conc)

#A5 PLOT
netplot = netoutput(xarray = collect(2010:2300), yarray1 = delta_ynet[1:291])
