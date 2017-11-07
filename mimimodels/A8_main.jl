# Anaya Hall
# CCE - Fall 2017

include("A8_constructmodel.jl")
include("parameters.jl")

# Assigment 8 - replicate plots from assignment 6 (include A6_plots)


# epolicy1 = [(.01/291)*t for t in 1:291]
epolicy1 = fill(.1,291)
epolicy2 = fill(.2,291)
epolicy3 = fill(.3,291)
epolicy4 = fill(.4,291)

########################################################
##################### RUN MODEL ########################
########################################################

using Mimi


# RUN MODEL SCENARIOS
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

# include("A6_plots.jl")
# # include("scenarios.jl")

# # A6 PLOTS
# # Collect Variables
# #A6 Scenarios
# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
ep1_d = ep1_run[:damages, :d_dollars]
ep2_d = ep2_run[:damages, :d_dollars]
ep3_d = ep3_run[:damages, :d_dollars]
ep4_d = ep4_run[:damages, :d_dollars]
# alt_d = bau_run[:damages, :altcons_pc]

d_ep1 = bau_d - ep1_d 
d_ep2 = bau_d - ep2_d
d_ep3 = bau_d - ep3_d
d_ep4 = bau_d - ep4_d

################################################
#       DISCOUNT
################################################

discount2 = [1/((1.02)^t) for t in 1:291]
discount3 = [1/((1.03)^t) for t in 1:291]
discount5 = [1/((1.05)^t) for t in 1:291]


ep1d2 = discount2.*d_ep1
ep1d3 = discount3.*d_ep1
ep1d5 = discount5.*d_ep1

ep2d2 = discount2.*d_ep2
ep2d3 = discount3.*d_ep2
ep2d5 = discount5.*d_ep2

ep3d2 = discount2.*d_ep3
ep3d3 = discount3.*d_ep3
ep3d5 = discount5.*d_ep3

ep4d2 = discount2.*d_ep4
ep4d3 = discount3.*d_ep4
ep4d5 = discount5.*d_ep4

################################################
#       SUM
################################################

# Sbased2 = sum(based2)
# Sbased3 = sum(based3)
# Sbased5 = sum(based5)

Sep1d2 = sum(ep1d2)
Sep1d3 = sum(ep1d3)
Sep1d5 = sum(ep1d5)

Sep2d2 = sum(ep2d2)
Sep2d3 = sum(ep2d3)
Sep2d5 = sum(ep2d5)

Sep3d2 = sum(ep3d2)
Sep3d3 = sum(ep3d3)
Sep3d5 = sum(ep3d5)

Sep4d2 = sum(ep4d2)
Sep4d3 = sum(ep4d3)
Sep4d5 = sum(ep4d5)

A8 = [Sep1d2 Sep1d3 Sep1d5 ; Sep2d2 Sep2d3 Sep2d5 ; Sep3d2 Sep3d3 Sep3d5 ; Sep4d2 Sep4d3 Sep4d5]
A8df = convert(DataFrame, A8)
rename!(A8df, [:x1 :x2 :x3], [:discount2 :discount3 :discount5])
# rename!(A8df, [:x1 :x2 :x3 :x4 :x5 :x6 :x7 :x8 :x9 :x10 :x11 :x12], [:EP1d2 :EP1d3 :EP1d5 :EP2d2 :EP2d3 :EP2d5 :EP3d2 :EP3d3 :EP3d5 :EP4d2 :EP4d3 :EP4d5])
writetable("damagescomp.csv",A8df)

################################################
#       CHECK ABATEMENT COSTS
################################################

#Check difference in abatement costs
bau_ac = bau_run[:abatement, :ab_cost]
ep1_ac = ep1_run[:abatement, :ab_cost]
ep2_ac = ep2_run[:abatement, :ab_cost]
ep3_ac = ep3_run[:abatement, :ab_cost]
ep4_ac = ep4_run[:abatement, :ab_cost]


ep1ac2 = discount2.*ep1_ac
ep1ac3 = discount3.*ep1_ac
ep1ac5 = discount5.*ep1_ac

ep2ac2 = discount2.*ep2_ac
ep2ac3 = discount3.*ep2_ac
ep2ac5 = discount5.*ep2_ac

ep3ac2 = discount2.*ep3_ac
ep3ac3 = discount3.*ep3_ac
ep3ac5 = discount5.*ep3_ac

ep4ac2 = discount2.*ep4_ac
ep4ac3 = discount3.*ep4_ac
ep4ac5 = discount5.*ep4_ac

#SUM!!!!!!!!!
Sep1ac2 = sum(ep1ac2)
Sep1ac3 = sum(ep1ac3)
Sep1ac5 = sum(ep1ac5)

Sep2ac2 = sum(ep2ac2)
Sep2ac3 = sum(ep2ac3)
Sep2ac5 = sum(ep2ac5)

Sep3ac2 = sum(ep3ac2)
Sep3ac3 = sum(ep3ac3)
Sep3ac5 = sum(ep3ac5)

Sep4ac2 = sum(ep4ac2)
Sep4ac3 = sum(ep4ac3)
Sep4ac5 = sum(ep4ac5)

AC = [Sep1ac2 Sep1ac3 Sep1ac5 ; Sep2ac2 Sep2ac3 Sep2ac5 ; Sep3ac2 Sep3ac3 Sep3ac5 ; Sep4ac2 Sep4ac3 Sep4ac5]
ACdf = convert(DataFrame, AC)
rename!(ACdf, [:x1 :x2 :x3], [:discount2 :discount3 :discount5])
# rename!(ACdf, [:x1 :x2 :x3 :x4 :x5 :x6 :x7 :x8 :x9 :x10 :x11 :x12], [:EP1ac2 :EP1ac3 :EP1ac5 :EP2ac2 :EP2ac3 :EP2ac5 :EP3ac2 :EP3ac3 :EP3ac5 :EP4ac2 :EP4ac3 :EP4ac5])
writetable("abatementcosts.csv",ACdf)

# # Call plot
# # callplota = A7plot(xarray = year, yarray1 = BAU_dd, yarray2 = iepos_dd, yarray3 = ie0_dd, yarray4 = ieneg_dd)

# # callplotb = A7plotb(xarray = year, yarray1 = ieneg_dd, yarray2 = ie0_dd, yarray3 = iepos_dd)


# #A6 PLOT
# #Policy Q1

# # #Policy Q2
# # A6Q2A = pccons4(xarray = year, yarray1 = d_ep1, yarray2 = d_ep2, yarray3 = d_ep3, yarray4 = d_ep4)

# # A6Q2B = abcost4(xarray = year, yarray1 = dabcost_ep1, yarray2 = dabcost_ep2, yarray3 = dabcost_ep3, yarray4 = dabcost_ep4)

# # A6Q2C = damages4(xarray = year, yarray1 = ep1_dgdp, yarray2 = ep2_dgdp, yarray3 = ep3_dgdp, yarray4 = ep4_dgdp)


