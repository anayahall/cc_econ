# Anaya Hall
# CCE - Fall 2017

# Set up different plots 


### Prepare results for plotting

BAU_temp = bau_run[:climatedynamics, :temp]
ep1_temp = ep1_run[:climatedynamics, :temp]
# ep2_temp = ep2_run[:climatedynamics, :temp]


BAU_ynet = bau_run[:neteconomy, :YNET] 
ep1_ynet = ep1_run[:neteconomy, :YNET]

delta_ynet = BAU_ynet - ep1_ynet

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