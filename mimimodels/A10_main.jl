# Anaya Hall
# CCE - Fall 2017

include("parameters.jl")

include("A10_scenarios.jl")
include("A10_plots.jl")

#compare SCC values for ramsey DFs
A10_q1 = [SCCp0 SCCp1 SCCp3]
A10_q1df = convert(DataFrame, A10_q1)

#store SCC values for standard climate sensitivity
A10_cs3 = [SCCp0 SCCp1 SCCp3 SCCr25 SCCr3 SCCr5]
A10_cs3df = convert(DataFrame, A10_cs3)

############ QUESTION 2 ########################
# PLOTS!

# Q2a = damageplot7(xarray=year, yarray1=damage_diff0, yarray2=diffp0, yarray3=diffp1, 
#     yarray4=diffp3, yarray5=diffd25, yarray6=diffd3, yarray7=diffd5)

# Q2b = damageplot6(xarray=year, yarray1=diffp0, yarray2=diffp1, yarray3=diffp3, 
#     yarray4=diffd25, yarray5=diffd3, yarray6=diffd5)

# ############ QUESTION 3 ########################
# # Play with alternate climate sensitivities

# climate_sens = 2 / (5.35 * log(2))
# include("A10_scenarios.jl")
# A10_cs2 = [SCCp0 SCCp1 SCCp3 SCCr25 SCCr3 SCCr5]
# A10_cs2df = convert(DataFrame, A10_cs2)


# climate_sens = 4.5 / (5.35 * log(2))
# include("A10_scenarios.jl")
# A10_cs45 = [SCCp0 SCCp1 SCCp3 SCCr25 SCCr3 SCCr5]
# A10_cs45df = convert(DataFrame, A10_cs45)


# A10 = [A10_cs3, A10_cs2, A10_cs45]
# A10df = convert(DataFrame, A10)
# # writetable("SCC.csv",A10df)