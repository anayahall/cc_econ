# Anaya Hall
# CCE - Fall 2017

using StackTraces

#BUILD MODEL
include("carboncycle_m.jl")
include("climatedynamics.jl")


function run_my_model()
       
    my_model = Model()

    setindex(my_model, :time, collect(2010:1:2300))

    addcomponent(my_model, carboncycle)  #Order matters here. 
    addcomponent(my_model, climatedynamics)

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


using Mimi
include("parameters.jl")

run1 = run_my_model()

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

#check results before plotting
BAU_temp = run1[:climatedynamics, :temp]

###### PLOT ##########################################
include("plots.jl")

tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = test3)
# concplot(xarray = year, yarray1 = BAU_temp, yarray2 = test3)
