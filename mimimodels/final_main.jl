# Anaya Hall
# ER 276: CC ECON
# TAKE HOME FINAL

using Mimi
using DataFrames

rho = 0.01
eta = 1.0

## MODELING QUESION 1:
# include("final_m1.jl")

## MODELING QUESTION 2: 
## How does SCC change when accounting for SEA LEVEL RISE



################################################################################
## BRING IN OPTIMAL EMISSIONS POLICIES
################################################################################

oep_input = readtable("/Users/anayahall/projects/CCecon/data/OptimalEmissionsPolicy.csv")

oep01 = oep_input[:oep01]
oep1 = oep_input[:oep1]
oep3 = oep_input[:oep3]

oep_array = [oep01 oep1 oep3]

bau_run = run_my_model()

println("**********************************")
bau_run[:climatedynamics, :temp]

# mar_run = run_my_model(scenario="mar")

################################################################################
## SETUP ARRAYS FOR RESULTS
################################################################################

#Policy Analysis Questions 1 and 3 will use this array, which collects SCC for 
#3 climate sensitivities (columns) and 6 discount rate options (rows)
results_SCC = Array{Float64}(6,3)

#Policy Analysis Question 2 will use this array, which collects the damages for 
#6 different discount rate options under climate sensitivity of 0.8 as well as 
#the undiscounted damges
results_damages = Array{Float64}(291,7)

#POLICY ANALYSIS: Generates table (Array) that lists the net present value of 
#costs and benefits (separately) of each of the five policies (columns) for the six 
#discounting schemes (rows) .

results_CBA = Array{Float64}(6,5)

################################################################################
## SETUP ARRAYS FOR LOOPING
################################################################################

cs_array = Array{Float64}(3) #climate sensitivities
cs_array[1] = 2. / (5.35 * log(2))
cs_array[2] = 3. / (5.35 * log(2))
cs_array[3] = 4.5 / (5.35 * log(2))

rho_array = [0., 0.01, 0.03] #pure rate of time preference
constdr_array = [0.025, 0.03, 0.05] #constant discount rates

epolicy10 = fill(.1,291)
epolicy40 = fill(.4,291)

#Emissions Policies: TWO constant policies (10% and 40%), THREE optimal policies
ep_array = [epolicy10 epolicy40 oep_array] 


################################################################################
## LOOPS
################################################################################

for i in rho_array
    
        rho = i


        #RUN MODEL HERE?
end


################################################################################
## OUTPUT RESULTS
################################################################################

# PLOTS: 





# TABLE
CBA_table = convert(DataFrame, results_CBA)
writetable("CBA.csv",CBA_table)