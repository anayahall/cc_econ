epolicy = fill(0.0,291)

# Constant Discount Rates
discount0 = fill(1.0,291)

discount25 = [1/((1.025)^t) for t in 1:291]
discount3 = [1/((1.03)^t) for t in 1:291]
discount5 = [1/((1.05)^t) for t in 1:291]

using Mimi
eta = 1.0

########################################################
##################### RUN MODEL ########################
########################################################

# RUN MODEL SCENARIOS
prtp = 0.01

#BASE RUN
marginalton = 0.0
include("constructmodel.jl")
bau_run = run_my_model()

#MARGINAL RUN
marginalton = (1/(10^6))*(44/12)
include("constructmodel.jl")
mar_run = run_my_model()

# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
mar_d = mar_run[:damages, :d_dollars]

damage_diff_p1 = (mar_d - bau_d).*(10^9)       #From billions of dollars to dollars
ramseyDF = bau_run[:discountfactor, :ramseyDF]
diffp1 = ramseyDF.*damage_diff_p1
SCCp1 = sum(diffp1)*(12/44)

########################################################

# RUN MODEL SCENARIOS
prtp = 0.00

#BASE RUN
marginalton = 0.0
include("constructmodel.jl")
bau_run = run_my_model()

#MARGINAL RUN
marginalton = (1/(10^6))*(44/12)
include("constructmodel.jl")
mar_run = run_my_model()

# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
mar_d = mar_run[:damages, :d_dollars]

damage_diff_p0 = (mar_d - bau_d).*(10^9)       #From billions of dollars to dollars
ramseyDF = bau_run[:discountfactor, :ramseyDF]
diffp0 = ramseyDF.*damage_diff_p0
SCCp0 = sum(diffp0)*(12/44)

################################################

# RUN MODEL SCENARIOS
prtp = 0.03

#BASE RUN
marginalton = 0.0
include("constructmodel.jl")
bau_run = run_my_model()

#MARGINAL RUN
marginalton = (1/(10^6))*(44/12)
include("constructmodel.jl")
mar_run = run_my_model()

# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
mar_d = mar_run[:damages, :d_dollars]

damage_diff_p3 = (mar_d - bau_d).*(10^9)       #From billions of dollars to dollars
ramseyDF = bau_run[:discountfactor, :ramseyDF]
diffp3 = ramseyDF.*damage_diff_p3
SCCp3 = sum(diffp3)*(12/44)

################################################
#       CONSTANT DISCOUNT
################################################

marginalton = 0.0
include("constructmodel.jl")
bau_run = run_my_model()

#MARGINAL RUN
marginalton = (1/(10^6))*(44/12)
include("constructmodel.jl")
mar_run = run_my_model()

# #DIFFERENCE IN DAMAGES
bau_d = bau_run[:damages, :d_dollars]
mar_d = mar_run[:damages, :d_dollars]
damage_diff0 = (mar_d - bau_d).*(10^9) 

SCCr0 = sum(damage_diff0)*(12/44)

diffd25 = discount25.*damage_diff0
diffd3 = discount3.*damage_diff0
diffd5 = discount5.*damage_diff0

SCCr25 = sum(discount25.*damage_diff0)*(12/44)                #convert from tC to tCO2
SCCr3 = sum(discount3.*damage_diff0)*(12/44)                 #convert from tC to tCO2
SCCr5 = sum(discount5.*damage_diff0)*(12/44) 


println("SCC (usd/tCO2) if r=0.0%: ", SCCr0)
println("SCC (usd/tCO2) if r=2.5%: ", SCCr25)
println("SCC (usd/tCO2) if r=3.0%: ", SCCr3)
println("SCC (usd/tCO2) if r=5.0%: ", SCCr5)
println("SCC (usd/tCO2) if rho=0%: ", SCCp0)
println("SCC (usd/tCO2) if rho=1.0%: ", SCCp1)
println("SCC (usd/tCO2) if rho =3.0%: ", SCCp3)


