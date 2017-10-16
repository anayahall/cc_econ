# Anaya Hall
# CCE - Fall 2017

using DataFrames
# Set up different plots 


### Prepare results for plotting

BAU_temp = bau_run[:climatedynamics, :temp]
ep1_temp = ep1_run[:climatedynamics, :temp]
# ep2_temp = ep2_run[:climatedynamics, :temp]

#A5 Scenarios
BAU_ynet = bau_run[:neteconomy, :YNET] 
ep1_ynet = ep1_run[:neteconomy, :YNET]
delta_ynet = BAU_ynet - ep1_ynet

# #A6 Scenarios
# #DIFFERENCE IN PER CAPITA CONSUMPTIN
# bau_d = bau_run[:damages, :cons_pc]
# # ep1_d = ep1_run[:damages, :cons_pc]
# # ep2_d = ep2_run[:damages, :cons_pc]
# # ep3_d = ep3_run[:damages, :cons_pc]
# # ep4_d = ep4_run[:damages, :cons_pc]
# # alt_d = bau_run[:damages, :altcons_pc]

# d_ep1 = ep1_d - bau_d
# d_ep2 = ep2_d - bau_d
# d_ep3 = ep3_d - bau_d
# d_ep4 = ep4_d - bau_d

# A6 = [year bau_d ep1_d ep2_d ep3_d ep4_d alt_d]
# A6df = convert(DataFrame, A6)
# writetable("damagescomp.csv",A6df)

# #DIFFERNCE IN ABATEMENT COST
# bau_abcost = bau_run[:abatement, :ab_cost]
# ep1_abcost = ep1_run[:abatement, :ab_cost]
# ep2_abcost = ep2_run[:abatement, :ab_cost]
# ep3_abcost = ep3_run[:abatement, :ab_cost]
# ep4_abcost = ep4_run[:abatement, :ab_cost]

# dabcost_ep1 = ep1_abcost - bau_abcost
# dabcost_ep2 = ep2_abcost - bau_abcost
# dabcost_ep3 = ep3_abcost - bau_abcost
# dabcost_ep4 = ep4_abcost - bau_abcost

# #DAMAGE OVER GDP
# bau_dgdp = bau_run[:damages, :d_dollars]
# ep1_dgdp = (ep1_run[:damages, :d_dollars]./ep1_run[:neteconomy, :YNET])
# ep2_dgdp = (ep2_run[:damages, :d_dollars]./ep2_run[:neteconomy, :YNET])
# ep3_dgdp = (ep3_run[:damages, :d_dollars]./ep3_run[:neteconomy, :YNET])
# ep4_dgdp = (ep4_run[:damages, :d_dollars]./ep4_run[:neteconomy, :YNET])


# ei_temp = ei_run[:climatedynamics, :temp]
# ci_temp = ci_run[:climatedynamics, :temp]

# constant_temp = con_run[:climatedynamics, :temp]
# ir_temp = ir_run[:climatedynamics, :temp]
# lr_temp = lr_run[:climatedynamics, :temp]
# s5_temp = s5_run[:climatedynamics, :temp]


# ep1_cost = ep1_run[:abatement, :ab_cost]
# ep2_cost = ep2_run[:abatement, :ab_cost]
# constant_conc = con_run[:climatedynamics, :CO2ppm]
# ir_conc = ir_run[:climatedynamics, :CO2ppm]
# lr_conc = lr_run[:climatedynamics, :CO2ppm]
#BAU_cost = bau_run[:abatement, :ab_cost]