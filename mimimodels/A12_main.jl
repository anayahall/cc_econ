# Anaya Hall
# CCE - Fall 2017

using Mimi
using Distributions

include("parameters.jl")
include("constructmodel.jl")

# DISCOUNT RATE: Constant 3% #
prtp = 0.00
discount3 = [1/((1.03)^t) for t in 1:291]
eta = 1.0

# No emissions policy
epolicy = fill(0.0,291)

SCC = Float64[]

for i = 1:1000

    f = rand(Normal(0.62, 0.18),1)
    println("f: ", f)
    
    numerator = (1.2 / (1. - f[1]))
    println("NUM: ", numerator, typeof(numerator))
    
    if 0 < numerator <= 8

        climate_sens = numerator / (5.35 * log(2))
        println("CS: ", climate_sens, typeof(climate_sens)) #check array!
    
        # then just do the normal base and marginal runs and store the SCC value in a vector
        #BASE RUN
        # marginalton = 0.0
        # println("marginal ton   ", typeof(marginalton))
        # include("constructmodel.jl")
        bau_run = run_my_model(scenario="bau")
        # println("BAU TEMP:   ", bau_run[:climatedynamics, :temp])

        # #MARGINAL RUN
        # marginalton = (1/(10^6))*(44/12)
        # include("constructmodel.jl")
        mar_run = run_my_model(scenario="mar")
        println("BOTH SCENARIOS RUN!")

        bau_d = bau_run[:damages, :d_dollars]
        mar_d = mar_run[:damages, :d_dollars]
        damage_diff = (mar_d - bau_d).*(10^9) 
        SCCr3 = sum(discount3.*damage_diff)*(12/44)                 #convert from tC to tCO2

        append!(SCC, SCCr3)

    end

end

println("************************")
println("SCC: ", SCC)
println("************************")


# # #PLOT HISTOGRAM
using Gadfly 

# xx = randn(500)

Gadfly.plot(x=SCC, Geom.histogram, 
            Guide.xlabel("SCC (USD/MtCO2)"), Guide.ylabel("Frequency"), 
            Guide.title("Monte Carlo Histogram of SCC"))

mean = mean(SCC)
se = std(SCC)/sqrt(1000)