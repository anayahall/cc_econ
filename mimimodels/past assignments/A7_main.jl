# Anaya Hall
# CCE - Fall 2017

include("constructmodel.jl")
include("parameters.jl")

# Assigment 7: Scenarios around income elasticity
d_elast_bau = 0.0
d_elast_neg = -0.25
d_elast_ie0 = 0.0
d_elast_pos = 0.25

########################################################
##################### RUN MODEL ########################
########################################################

using Mimi


# INCOME ELASTICY SCENARIOS
bau_run = run_my_model(scenario="bau")
iepos_run = run_my_model(scenario="ie_pos")
ie0_run = run_my_model(scenario="ie0")
ieneg_run = run_my_model(scenario="ie_neg")


println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

########################################################
################### PLOT OUTPUT ########################
########################################################

include("A7_plots.jl")
# include("scenarios.jl")

# A7 PLOTS
# Collect Variables
BAU_dd = bau_run[:damages, :d_dollars]
iepos_dd = iepos_run[:damages, :d_dollars]
ieneg_dd = ieneg_run[:damages, :d_dollars]
ie0_dd = ie0_run[:damages, :d_dollars]


# Call plot
callplota = A7plot(xarray = year, yarray1 = BAU_dd, yarray2 = iepos_dd, yarray3 = ie0_dd, yarray4 = ieneg_dd)

callplotb = A7plotb(xarray = year, yarray1 = ieneg_dd, yarray2 = ie0_dd, yarray3 = iepos_dd)


#A6 PLOT
#Policy Q1

# #Policy Q2
# A6Q2A = pccons4(xarray = year, yarray1 = d_ep1, yarray2 = d_ep2, yarray3 = d_ep3, yarray4 = d_ep4)

# A6Q2B = abcost4(xarray = year, yarray1 = dabcost_ep1, yarray2 = dabcost_ep2, yarray3 = dabcost_ep3, yarray4 = dabcost_ep4)

# A6Q2C = damages4(xarray = year, yarray1 = ep1_dgdp, yarray2 = ep2_dgdp, yarray3 = ep3_dgdp, yarray4 = ep4_dgdp)


