# The Economics of Climate Change Graduate Assignment
# Lisa Rennels
# September 26, 4017

# Main Program

using Mimi 
using DataFrames

##------------------------------------------------------------------------------
## SETUP FOR QUESTIONS
##------------------------------------------------------------------------------

#Policy Analysis Questions 1 and 3 will use this array, which collects SCC for 
#3 climate sensitivities (columns) and 6 discount rate options (rows)
results_SCC = Array{Float64}(6,3)

#Policy Analysis Question 2 will use this array, which collects the damages for 
#6 different discount rate options under climate sensitivity of 0.8 as well as 
#the undiscounted damges
results_damages = Array{Float64}(291,7)

##------------------------------------------------------------------------------
## SETUP FOR MODELS
##------------------------------------------------------------------------------

include("parameters.jl")
emissionspolicy = Array{Float64}(291) #time series of emissions reduction
for yr = 1:291
    emissionspolicy[yr] = 0.
end
d_elast = 0.

##------------------------------------------------------------------------------
## ARRAYS FOR LOOPING
##------------------------------------------------------------------------------

climate_sensitivity = Array{Float64}(3) #climate sensitivities
climate_sensitivity[1] = 2. / (5.35 * log(2))
climate_sensitivity[2] = 3. / (5.35 * log(2))
climate_sensitivity[3] = 4.5 / (5.35 * log(2))

ρ_array = [0., 0.01, 0.03] #pure rate of time preference
constdr = [0.025, 0.03, 0.05] #constant discount rates

##------------------------------------------------------------------------------
## LOOPS
##------------------------------------------------------------------------------

for sensitivity = 1:3 #three climate sensitivities
    println("running new scenario")    
    lambda = climate_sensitivity[sensitivity]
    
    for discountmethod = 1:6 #six options for discounting

        if discountmethod < 4
            ρ = 0.
        else
            ρ = ρ_array[discountmethod - 3]
        end

        ##----------------------------------------------------------------------
        ## run damages
        ##----------------------------------------------------------------------

        #base run
        marginalton = 0.        
        include("construct_model.jl")
        base_run= run_IAM()

        #marginal run
        marginalton = 1/(10^9)
        include("construct_model.jl")
        marginal_run = run_IAM()

        ##----------------------------------------------------------------------
        ## get discount factors
        ##----------------------------------------------------------------------

        #get dicount factors
        if discountmethod < 4 #constant discount rate
            df = Array{Float64}(291)
            for yr = 1:291
                    df[yr]= 1./((1. + constdr[discountmethod])^yr)
            end

        else #Ramsey discount rate
            df = base_run[:ramseydf, :dfR]
        end

        ##----------------------------------------------------------------------
        ## get results
        ##----------------------------------------------------------------------
        difference = marginal_run[:neteconomy, :d_dollars] - base_run[:neteconomy, :d_dollars]
        SCC = sum(difference .* df)
        results_SCC[discountmethod, sensitivity] = SCC

        if sensitivity == 2
            results_damages[:,1] =  difference
            results_damages[:,discountmethod+1] = PV
        end
        
    end
end

#print csv for questions 1 and 3
writecsv("/Users/lisarennels/Documents/UC Berkeley ERG/ENERES 276/Project/Assignment 10/results_SCC.csv", results_SCC);

#print graphs for question 2
writecsv("/Users/lisarennels/Documents/UC Berkeley ERG/ENERES 276/Project/Assignment 10/results_damages.csv", results_damages);

#=
include("A10_plots.jl")

Q2a = damageplot7(xarray=year, yarray1=results_damages[:,1], yarray2=results_damages[:,2],
    yarray3=results_damages[:,3], array4=results_damages[:,4], yarray5=results_damages[:,5],
    yarray6=results_damages[:,6], yarray7=results_damages[:,7])

Q2b = damageplot6(xarray=year, yarray1=results_damages[:,2],
    yarray2=results_damages[:,3], array3=results_damages[:,4], yarray4=results_damages[:,5],
    yarray5=results_damages[:,6], yarray6=results_damages[:,7])
=#