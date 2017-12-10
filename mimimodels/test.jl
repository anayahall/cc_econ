# TEST RUN MODEL OUTPUT

using Mimi

include("parameters.jl")
include("constructmodel.jl")

# baserun = run_my_model()

slrrun = run_my_model(scenario="bau", slr="yes")
noslrrun = run_my_model(scenario="bau", slr="no")


# println("SEA LEVEL RISE: ", noslrrun[:sealevelrise, :slr])
# println("*****************************************")
# println("DAMAGE SHARE FROM SLR: ", noslrrun[:damages, :slr_damages])
# println("*****************************************")
# println("DAMAGE DOLLAR FROM SLR: ", noslrrun[:damages, :slr_d_dollars])
# println("*****************************************")
# println("TOTAL DAMAGES: ", noslrrun[:damages, :total_damages])
# println("*****************************************")

# comparisonarray = Array{Float64}(292,2)
names = ["SLR DAMAGES" "DAMAGES w/o SLR"]
comparisonarray = [slrrun[:neteconomy, :d_dollars] noslrrun[:neteconomy, :d_dollars]]
vcat(names, comparisonarray)



# plot2 = damage2(xarray=year, yarray1=noslrrun[:neteconomy, :d_dollars], yarray2=slrrun[:neteconomy, :d_dollars] )