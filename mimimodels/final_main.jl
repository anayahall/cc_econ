# Anaya Hall
# ER 276: CC ECON
# TAKE HOME FINAL

using Mimi
using DataFrames

rho = 0.01
eta = 1.0

# MODELING QUESION 1:
# The role of non-CO2 gases
include("final_m1.jl")

# MODELING QUESTION 2: 
# How does SCC change when accounting for SEA LEVEL RISE
include("final_m2.jl")

# POLICY QUESTION: 
# Cost benefit analysis of 5 emission policy scenarios and 6 discount rate methods
include("final_policy.jl")
