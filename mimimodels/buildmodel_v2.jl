# Anaya Hall
# CCE - Fall 2017

########################################################
################## BUILD MODEL #########################
########################################################

include("emissions.jl")
include("abatement.jl")
include("carboncycle.jl")
include("climatedynamics.jl")

function run_my_model(;scenario::AbstractString="bau")
       
    my_model = Model()

    setindex(my_model, :time, collect(2010:1:2300))

    #Order matters here: 
    addcomponent(my_model, emissions)
    addcomponent(my_model, abatement)
    addcomponent(my_model, carboncycle)  
    addcomponent(my_model, climatedynamics)

    #set parameters for EMISSIONS COMPONENT
    setparameter(my_model, :emissions, :pop, pop)
    setparameter(my_model, :emissions, :gdppc, gdppc)
    setparameter(my_model, :emissions, :energyi, energyi)
    setparameter(my_model, :emissions, :carboni, carboni)
    setparameter(my_model, :emissions, :luco2, luco2)    
    if scenario == "bau"
        setparameter(my_model, :emissions, :epolicy, fill(0.0,291))            
    elseif scenario == "EP1"
        setparameter(my_model, :emissions, :epolicy, epolicy1)
    elseif scenario == "EP2"
        setparameter(my_model, :emissions, :epolicy, epolicy2)
    end   
    
    #set parameters for ABATEMENT COMPONENT
	setparameter(my_model, :abatement, :bkstp0, bkstp0)
    setparameter(my_model, :abatement, :sigma0, sigma0)
    setparameter(my_model, :abatement, :sigma_rate, sigma_rate)
    setparameter(my_model, :abatement, :AC_exponent, AC_exponent)
    if scenario == "bau"
        setparameter(my_model, :abatement, :epolicy, fill(0.0,291))            
    elseif scenario == "EP1"
        setparameter(my_model, :abatement, :epolicy, epolicy1)
    elseif scenario == "EP2"
        setparameter(my_model, :abatement, :epolicy, epolicy2)
    end        
    setparameter(my_model, :abatement, :gdp, gdp)

    #set parameters for CARBON CYCLE COMPONENT
	setparameter(my_model, :carboncycle, :M_atm0, M_atm0)
	setparameter(my_model, :carboncycle, :M_lo0, M_lo0)
    setparameter(my_model, :carboncycle, :M_up0, M_up0)
    connectparameter(my_model, :carboncycle, :CO2emis, :emissions, :emis)    

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
ep1_run = run_my_model(scenario="EP1")
ep2_run = run_my_model(scenario="EP2")

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

########################################################
################### PLOT OUTPUT ########################
########################################################

include("plots.jl")

# tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = constant_temp, yarray3 = ir_temp, yarray4 = lr_temp)
# cplot = concplot(xarray = year, yarray1 = BAU_conc, yarray2 = constant_conc, yarray3 = ir_conc, yarray4 = lr_conc)

# PSET #3 PLOT
tplot = tempplot3(xarray = year, yarray1 = BAU_temp, yarray2 = ep1_temp, 
                yarray3 = ep2_temp)
cplot = costplot3(xarray = year, yarray1 = BAU_temp, yarray2 = ep1_cost, 
                yarray3 = ep2_cost)
