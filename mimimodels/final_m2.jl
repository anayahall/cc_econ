# Anaya Hall
# ER 276: CC ECON
# TAKE HOME FINAL
# Modeling Question #2

using Mimi
rho = 0.0
eta = 1.0
epolicy = fill(0.0, 291)

include("parameters.jl")
include("constructmodel.jl")
include("final_plots.jl")

#########################################################################
## MODELING QUESTION 2: SCC AFTER SLR
#########################################################################
df3 = [1/((1.03)^t) for t in 1:291]

# TWO RUNS (BASE AND MAR with SLR)
println("RUNNING SLR RUNS")
bau_slr = run_my_model(scenario ="bau",  slr="yes")
mar_slr = run_my_model(scenario="mar", slr="yes")
# Calc SCC
# discount rate * damages, summed

println("CALCULATING SCC w SLR")
difference = (mar_slr[:neteconomy, :d_dollars] - bau_slr[:neteconomy, :d_dollars]).*(10^9)       #From billions of dollars to dollars
SCC_slr = sum(difference .* df3)*(12/44)
println("*************************************************************")



# TWO RUNS WITHOUT SLR (BASE AND MAR)
println("RUNNING NO SLR RUNS")
bau_noslr = run_my_model(scenario="bau", slr="no")
mar_noslr = run_my_model(scenario="mar", slr="no")
# same calc of SCC
difference = (mar_noslr[:neteconomy, :d_dollars] - bau_noslr[:neteconomy, :d_dollars]).*(10^9)       #From billions of dollars to dollars
SCC_noslr = sum(difference .* df3)*(12/44)
println("CALCULATING SCC w/out SLR")

println("Damges (SLR): ", sum((bau_slr[:neteconomy, :d_dollars]).*df3))
println("Damages (no SLR): ", sum((bau_noslr[:neteconomy, :d_dollars]).*df3))


println("*************************************************************")
println("SCC with SLR: ", SCC_slr)
println("SCC w/o SLR: ", SCC_noslr)
println("*************************************************************")


#########################################################################
## PLOT DAMAGES OF BASERUNS : BAU (no SLR) v SLR


d_slr = bau_slr[:neteconomy, :d_dollars].*df3
d_noslr = bau_noslr[:neteconomy, :d_dollars].*df3

plot2 = damage2(xarray = year, yarray1 = d_noslr, yarray2 = d_slr)

#########################################################################
