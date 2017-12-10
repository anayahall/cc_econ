# Anaya Hall
# ER 276: CC ECON
# TAKE HOME FINAL
# Modeling Question #1

include("parameters.jl")
include("constructmodel.jl")
include("final_plots.jl")

########################################################################
## MODELING QUESTION 1: ROLE OF NON-CO2 GASES
########################################################################
# two graphs: one with RF as y, one with temp as y
# compare RF of NON-CO2 = 0 with base case


# Base Run
bau = run_my_model(slr="no")

# Set NON-CO2 gases to 0.0
RF_Other = fill(0.,291)

#construct model again, and run new scenario
include("constructmodel.jl")
bau_nonCO2 = run_my_model(slr="no")

temp_bau = bau[:climatedynamics, :temp]
rf_bau = bau[:climatedynamics, :RF_Total]

temp_nonCO2 = bau_nonCO2[:climatedynamics, :temp]
rf_nonCO2 = bau_nonCO2[:climatedynamics, :RF_Total]

plot1a = temp2(xarray=year, yarray1=temp_bau, yarray2=temp_nonCO2)

plot1b = rf2(xarray=year, yarray1=rf_bau, yarray2=rf_nonCO2)

