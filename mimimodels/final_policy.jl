# Anaya Hall
# ER 276: CC ECON
# TAKE HOME FINAL
# Policy Question - Impact of Different Discount Rates

using Mimi
using DataFrames

include("parameters.jl")
include("constructmodel.jl")

rho = 0.01
eta = 1.0
epolicy = fill(0.,291)

################################################################################
## SETUP ARRAYS FOR RESULTS
################################################################################

# NPV OF ABATEMENT COSTS OF FIVE POLICIES
npv_abcosts = Array{Float64}(6,5)

# NPV OF DAMAGES AVOIDED BY POLICIES (ie the BENEFITS)
npv_damages = Array{Float64}(6,5)
#### damaages in base minus damages in policy-run

#Generates table (Array) that lists the net present value of 
#costs and benefits of each of the five policies (columns) for the six 
#discounting schemes (rows)

results_CBA = Array{Float64}(6,5)

################################################################################
## SETUP ARRAYS FOR LOOPING
################################################################################

# Optimal Emissions Traejctories (from David)
oep_input = readtable("/Users/anayahall/projects/CCecon/data/OptimalEmissionsPolicy.csv")

oep01 = oep_input[:oep01]
oep1 = oep_input[:oep1]
oep3 = oep_input[:oep3]
oep_array = [oep01 oep1 oep3]

# Constant Emissions Policies
nopolicy = fill(0.,291)
epolicy10 = fill(.1,291)
epolicy40 = fill(.4,291)

# Emissions Policies: 
# TWO constant policies (10% and 40%), THREE optimal policies (from David)
ep_array = [epolicy10 epolicy40 oep_array] 

# Discount Methods
rho_array = [0.01, 0.01, 0.03] #pure rate of time preference
constdr_array = [0.025, 0.03, 0.05] #constant discount rates

################################################################################
## LOOPS
################################################################################

for policychoice = 1:5 #five emissions policies
    # println("RUNNING NEW EMISSIONS POLICY")

    for discountmethod = 1:6

        if discountmethod < 4
            rho = 0.0
        else
            rho = rho_array[discountmethod - 3]
        end
    
    ## RUN DAMAGES
    #base run
    epolicy = fill(0.0,291)
    bau_run = run_my_model()

    #policy run
    epolicy = ep_array[:,policychoice]
    policy_run = run_my_model()

    ## GET DISCOUNT FACTORS
    if discountmethod < 4
        df = ([1/((1. + constdr_array[discountmethod])^t) for t in 1:291])
    else
        df = bau_run[:discountfactor, :ramseyDF]
    end
    # println("DISCOUNT RATE: ", constdr_array[discountmethod])
    # println("DF: ", df[1])
    ## GET RESULTS

    #ab costs (COSTS)
    ab_costs = policy_run[:abatement, :ab_cost]
    npv_abcosts[discountmethod, policychoice] = sum(ab_costs.*df)


    #avoided damages (BENEFITS)
    damagediff = bau_run[:neteconomy, :d_dollars] - policy_run[:neteconomy, :d_dollars]
    npv_damages[discountmethod, policychoice] = sum(damagediff.*df)
    
    results_CBA[discountmethod, policychoice] = npv_abcosts[discountmethod, policychoice] - npv_damages[discountmethod, policychoice]

    end
end


################################################################################
## OUTPUT RESULTS
################################################################################

# PLOTS: 

# TABLES:

#ABATEMENT COSTS
abcost_table = convert(DataFrame, npv_abcosts)
writetable("abatementcosts.csv",abcost_table)

#AVOIDED DAMAGES
benefits_table = convert(DataFrame, npv_damages)
writetable("avoideddamages.csv",benefits_table)
    
CBA_table = convert(DataFrame, results_CBA)
writetable("CBA.csv",CBA_table)

println("******************************************")
println("COSTS MINUS BENEFITS")
println(CBA_table)
println("******************************************")
