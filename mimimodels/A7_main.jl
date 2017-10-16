# Anaya Hall
# CCE - Fall 2017

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
        epolicy1[y] = 0.30
    else
        epolicy1[y] = 0.0
    end
    # println("Y: ", y , "---- EPOLICY ", epolicy1[y])
end

epolicy2 = [(20/291)*t for t in 1:291]
epolicy3 = [(30/291)*t for t in 1:291]
epolicy4 = [(40/291)*t for t in 1:291]




bau_run = run_my_model(scenario="bau")
ep1_run = run_my_model(scenario="EP1")
ep2_run = run_my_model(scenario="EP2")
ep3_run = run_my_model(scenario="EP3")
ep4_run = run_my_model(scenario="EP4")

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

########################################################
################### PLOT OUTPUT ########################
########################################################

include("plots.jl")
# include("scenarios.jl")

# tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = constant_temp, yarray3 = ir_temp, yarray4 = lr_temp)
# cplot = concplot(xarray = year, yarray1 = BAU_conc, yarray2 = constant_conc, yarray3 = ir_conc, yarray4 = lr_conc)

#A5 PLOT
# netplot = netoutput(xarray = collect(2011:2300), yarray1 = delta_ynet[2:291])


#A6 PLOT
#Policy Q1

# #Policy Q2
# A6Q2A = pccons4(xarray = year, yarray1 = d_ep1, yarray2 = d_ep2, yarray3 = d_ep3, yarray4 = d_ep4)

# A6Q2B = abcost4(xarray = year, yarray1 = dabcost_ep1, yarray2 = dabcost_ep2, yarray3 = dabcost_ep3, yarray4 = dabcost_ep4)

# A6Q2C = damages4(xarray = year, yarray1 = ep1_dgdp, yarray2 = ep2_dgdp, yarray3 = ep3_dgdp, yarray4 = ep4_dgdp)