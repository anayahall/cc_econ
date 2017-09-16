# Anaya Hall
# CCE - Fall 2017

########################################################
################## BUILD MODEL #########################
########################################################

include("carboncycle_m.jl")
include("climatedynamics.jl")

function run_my_model(;scenario::AbstractString="bau")
       
    my_model = Model()

    setindex(my_model, :time, collect(2010:1:2300))

    addcomponent(my_model, carboncycle)  #Order matters here. 
    addcomponent(my_model, climatedynamics)

    if scenario == "bau"
        CO2emis = emission_data()
    elseif scenario == "constant"
        CO2emis = fill(9.9693, 291)
    elseif scenario == "imm_red"
        CO2emis = fill(9.9693 * 0.33, 291)
    end

    #set parameters for CARBON CYCLE COMPONENT
	setparameter(my_model, :carboncycle, :CO2emis, CO2emis)
	setparameter(my_model, :carboncycle, :M_atm0, M_atm0)
	setparameter(my_model, :carboncycle, :M_lo0, M_lo0)
	setparameter(my_model, :carboncycle, :M_up0, M_up0)

	# #set parameters for CLIMATE DYNAMICS COMPONENT
    setparameter(my_model, :climatedynamics, :CO2ppm0, CO2ppm0)
    setparameter(my_model, :climatedynamics, :RF_Other, RF_Other)
    setparameter(my_model, :climatedynamics, :climate_sens, climate_sens)
    setparameter(my_model, :climatedynamics, :delay, delay)
    setparameter(my_model, :climatedynamics, :temp0, temp0)
	connectparameter(my_model, :climatedynamics, :CO2ppm, :carboncycle, :CO2ppm)
    
    run(my_model)
	return(my_model)

end

########################################################
##################### RUN MODEL ########################
########################################################


using Mimi
include("parameters.jl")

bau_run = run_my_model(scenario="bau")
con_run = run_my_model(scenario="constant")
ir_run = run_my_model(scenario="imm_red")

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

#prepare results for plotting
BAU_temp = bau_run[:climatedynamics, :temp]
constant_temp = con_run[:climatedynamics, :temp]
ir_temp = ir_run[:climatedynamics, :temp]

BAU_conc = bau_run[:climatedynamics, :CO2ppm]
constant_conc = con_run[:climatedynamics, :CO2ppm]

########################################################
################### PLOT OUTPUT ########################
########################################################

include("plots.jl")

tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = constant_temp, yarray3 = ir_temp)
cplot = concplot(xarray = year, yarray1 = BAU_conc, yarray2 = constant_conc)
