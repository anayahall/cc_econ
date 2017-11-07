# Anaya Hall
# CCE - Fall 2017

include("parameters.jl")

# Assigment 9 - SOCIAL COST OF CARBON

# epolicy1 = [(.01/291)*t for t in 1:291]
epolicy = fill(0.0,291)


########################################################
##################### RUN MODEL ########################
########################################################

using Mimi

# RUN MODEL SCENARIOS
prtp = 0.01
eta = 1.0

#BASE RUN
marginalton = 0.0
include("constructmodel.jl")
bau_run = run_my_model()

#MARGINAL RUN
marginalton = (1/(10^6))*(44/12)
include("constructmodel.jl")
mar_run = run_my_model()


println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")


# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
mar_d = mar_run[:damages, :d_dollars]

damage_diff = (mar_d - bau_d).*(10^9)       #From billions of dollars to dollars

################################################
#       RAMSEY DISCOUNT
################################################

#v.ramseyDF[t] = (p.pccons[1]/p.pccons[t]) * (1/((1+p.prtp)^[t]))




################################################
#       CONSTANT DISCOUNT
################################################

discount25 = [1/((1.025)^t) for t in 1:291]
discount3 = [1/((1.03)^t) for t in 1:291]
discount5 = [1/((1.05)^t) for t in 1:291]

diffd25 = discount25.*damage_diff
diffd3 = discount3.*damage_diff
diffd5 = discount5.*damage_diff

################################################
#       SUM
################################################

SCC25 = sum(diffd25)*(12/44)                #convert from tC to tCO2
SCC30 = sum(diffd3)*(12/44)                 #convert from tC to tCO2
SCC50 = sum(diffd5)*(12/44)                 #convert from tC to tCO2

# println("Damages in bau yr 2300: ", bau_d[291])
# println("Damages in marginal yr 2300: ", mar_d[291])
println("DAMAGE DIFFERENCE: ", damage_diff[291])

println("SCC (usd/tCO2) if r=2.5%: ", SCC25)
println("SCC (usd/tCO2) if r=3.0%: ", SCC30)
println("SCC (usd/tCO2) if r=5.0%: ", SCC50)


#include("A10_plots.jl")

# damageplot7(xarray=year, yarray1=diffd25, yarray2=diffd5, yarray3=x, yarray4=x, yarray5=x, yarray6=x, yarray7=x)

# damageplot6(xarray=year, yarray1=diffd25, yarray2=diffd5, yarray3=x, yarray4=x, yarray5=x, yarray6=x)



############ QUESTION 3 ########################
# Play with climate sensitivities
# climate_sens = 2 / (5.35 * log(2))
# cs2_run = run_my_model()


# climate_sens = 4.5 / (5.35 * log(2))
# cs45_run = run_my_model()