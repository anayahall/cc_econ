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

# include("A6_plots.jl")
# # include("scenarios.jl")

# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
mar_d = mar_run[:damages, :d_dollars]

damage_diff = (mar_d - bau_d).*(10^9)       #From billions of dollars to dollars

################################################
#       DISCOUNT
################################################

discount25 = [1/((1.025)^t) for t in 1:291]
discount5 = [1/((1.05)^t) for t in 1:291]

diffd25 = discount25.*damage_diff
diffd5 = discount5.*damage_diff

################################################
#       SUM
################################################

SCC25 = sum(diffd25)*(12/44)                #convert from tC to tCO2
SCC50 = sum(diffd5)*(12/44)                 #convert from tC to tCO2

# println("Damages in bau yr 2300: ", bau_d[291])
# println("Damages in marginal yr 2300: ", mar_d[291])
println("DAMAGE DIFFERENCE: ", damage_diff[291])

println("SCC if r=2.5%: ", SCC25)
println("SCC if r=5.0%: ", SCC50)


# A9df = convert(DataFrame, A9)
# rename!(A8df, [:x1 :x2 :x3], [:discount2 :discount3 :discount5])
# # rename!(A8df, [:x1 :x2 :x3 :x4 :x5 :x6 :x7 :x8 :x9 :x10 :x11 :x12], [:EP1d2 :EP1d3 :EP1d5 :EP2d2 :EP2d3 :EP2d5 :EP3d2 :EP3d3 :EP3d5 :EP4d2 :EP4d3 :EP4d5])
# writetable("damagescomp.csv",A8df)

function damageplot(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("green"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("purple"))),   
    Guide.xlabel("Year"), Guide.ylabel("Damages (PV USD)"), 
    Guide.title("Discounted Damages by of Marginal Ton of Carbon"),
    Guide.manual_color_key("Discount Rate: ", ["r= 0.025", "r = 0.05"], 
    ["green", "purple"]))

end
year = collect(2010:2300)

damageplot(xarray=year, yarray1=diffd25, yarray2=diffd5)