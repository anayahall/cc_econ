# Anaya Hall
# CCE - Fall 2017

########################################################
################## BUILD MODEL #########################
########################################################

include("economy.jl")
include("emissions.jl")
include("abatement.jl")
include("carboncycle.jl")
include("climatedynamics.jl")
include("damages.jl")

function run_my_model(;scenario::AbstractString="bau")
       
    my_model = Model()

    setindex(my_model, :time, collect(2010:1:2300))

    #Order matters here: 
    addcomponent(my_model, grosseconomy)
    addcomponent(my_model, neteconomy)
    addcomponent(my_model, emissions)
    addcomponent(my_model, abatement)
    addcomponent(my_model, carboncycle)  
    addcomponent(my_model, climatedynamics)
    addcomponent(my_model, damages)

    #set parameters for GROSS ECONOMIC GROWTH COMPONENT
    setparameter(my_model, :grosseconomy, :L, L)
    setparameter(my_model, :grosseconomy, :s, s)
    setparameter(my_model, :grosseconomy, :depk, depk)
    setparameter(my_model, :grosseconomy, :k0, k0)
    setparameter(my_model, :grosseconomy, :alpha, alpha)
    setparameter(my_model, :grosseconomy, :kaya_gdp, kaya_gdp)
    setparameter(my_model, :grosseconomy, :A, A)
    #set parameters for NET ECONOMIC GROWTH COMPONENT
    # setparameter(my_model, :neteconomy, :s, s)
    connectparameter(my_model, :neteconomy, :YGROSS, :grosseconomy, :YGROSS)
    connectparameter(my_model, :neteconomy, :abatement, :abatement, :ab_cost)
    connectparameter(my_model, :neteconomy, :d_dollars, :damages, :d_dollars)
    

    #set parameters for EMISSIONS COMPONENT
    # setparameter(my_model, :emissions, :pop, pop)
    # setparameter(my_model, :emissions, :gdppc, gdppc)
    connectparameter(my_model, :emissions, :YGROSS, :grosseconomy, :YGROSS)
    setparameter(my_model, :emissions, :energyi, energyi)
    setparameter(my_model, :emissions, :carboni, carboni)
    setparameter(my_model, :emissions, :luco2, luco2)    
    if scenario == "bau"
        setparameter(my_model, :emissions, :epolicy, fill(0.0,291))            
    elseif scenario == "EP1"
        setparameter(my_model, :emissions, :epolicy, epolicy1)
    elseif scenario == "EP2"
        setparameter(my_model, :emissions, :epolicy, epolicy2)
    elseif scenario == "EP3"
        setparameter(my_model, :abatement, :epolicy, epolicy3)
    elseif scenario == "EP4"
        setparameter(my_model, :abatement, :epolicy, epolicy4)
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
    elseif scenario == "EP3"
        setparameter(my_model, :abatement, :epolicy, epolicy3)
    elseif scenario == "EP4"
        setparameter(my_model, :abatement, :epolicy, epolicy4)
    end        
    connectparameter(my_model, :abatement, :gdp, :grosseconomy, :YGROSS)
    
    #set parameters for CARBON CYCLE COMPONENT
	setparameter(my_model, :carboncycle, :M_atm0, M_atm0)
	setparameter(my_model, :carboncycle, :M_lo0, M_lo0)
    setparameter(my_model, :carboncycle, :M_up0, M_up0)
    connectparameter(my_model, :carboncycle, :CO2emis, :emissions, :emis)    

	# Set parameters for CLIMATE DYNAMICS COMPONENT
    setparameter(my_model, :climatedynamics, :CO2ppm0, CO2ppm0)
    setparameter(my_model, :climatedynamics, :RF_Other, RF_Other)
    setparameter(my_model, :climatedynamics, :climate_sens, climate_sens)
    setparameter(my_model, :climatedynamics, :delay, delay)
    setparameter(my_model, :climatedynamics, :temp0, temp0)
	connectparameter(my_model, :climatedynamics, :CO2ppm, :carboncycle, :CO2ppm)
    
    # Set parameters for CLIMATE DYNAMICS COMPONENT
    setparameter(my_model, :damages, :d_coeff, d_coeff)
    setparameter(my_model, :damages, :d_coeff_sq, d_coeff_sq)
    setparameter(my_model, :damages, :d_exp, d_exp)
    setparameter(my_model, :damages, :pop, pop)
    setparameter(my_model, :damages, :savings, s)    
    connectparameter(my_model, :damages, :temp, :climatedynamics, :temp)
    connectparameter(my_model, :damages, :YGROSS, :grosseconomy, :YGROSS)
    connectparameter(my_model, :damages, :YNET, :neteconomy, :YNET)
    
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
# ep2_run = run_my_model(scenario="EP2")

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")

########################################################
################### PLOT OUTPUT ########################
########################################################

include("plots.jl")
include("scenarios.jl")

# tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = constant_temp, yarray3 = ir_temp, yarray4 = lr_temp)
# cplot = concplot(xarray = year, yarray1 = BAU_conc, yarray2 = constant_conc, yarray3 = ir_conc, yarray4 = lr_conc)

#A5 PLOT
netplot = netoutput(xarray = collect(2011:2300), yarray1 = delta_ynet[2:291])


#A6 PLOT
#Policy Q1

#Policy Q2