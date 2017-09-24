# Anaya Hall
# CCE - Fall 2017

########################################################
################## BUILD MODEL #########################
########################################################

include("emissions.jl")
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

    if scenario == "bau"
        setparameter(my_model, :emissions, :pop, pop)
        setparameter(my_model, :emissions, :gdppc, gdppc)
        setparameter(my_model, :emissions, :energyi, energyi)
        setparameter(my_model, :emissions, :carboni, carboni)
    elseif scenario == "dpop"
        setparameter(my_model, :emissions, :pop, pop)
        setparameter(my_model, :emissions, :gdppc, fill(gdppc[1], 291))
        setparameter(my_model, :emissions, :energyi, fill(energyi[1], 291))
        setparameter(my_model, :emissions, :carboni, fill(carboni[1],291))
    elseif scenario == "dgdp"
        setparameter(my_model, :emissions, :pop, fill(pop[1],291))
        setparameter(my_model, :emissions, :gdppc, gdppc)
        setparameter(my_model, :emissions, :energyi, fill(energyi[1], 291))
        setparameter(my_model, :emissions, :carboni, fill(carboni[1],291))
    elseif scenario == "denergyi"
        setparameter(my_model, :emissions, :pop, fill(pop[1],291))
        setparameter(my_model, :emissions, :gdppc, fill(gdppc[1], 291))
        setparameter(my_model, :emissions, :energyi, energyi)
        setparameter(my_model, :emissions, :carboni, fill(carboni[1],291))
    elseif scenario == "dcarboni"
        setparameter(my_model, :emissions, :pop, fill(pop[1],291))
        setparameter(my_model, :emissions, :gdppc, fill(gdppc[1], 291))
        setparameter(my_model, :emissions, :energyi, fill(energyi[1], 291))
        setparameter(my_model, :emissions, :carboni, carboni)
    end
    setparameter(my_model, :emissions, :luco2, luco2)
    
    #set parameters for EMISSIONS REDUCTION / ABATEMENT COMPONENT
	setparameter(my_model, :abatement, #:M_atm0, M_atm0)
	setparameter(my_model, :abatement, #:M_lo0, M_lo0)
    setparameter(my_model, :abatement, #:M_up0, M_up0)
    connectparameter(my_model, :abatement, :CO2emis, :carboncycle, :emis) 


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
pop_run = run_my_model(scenario="dpop")
gdp_run = run_my_model(scenario="dgdp")
ei_run  = run_my_model(scenario="denergyi")
ci_run  = run_my_model(scenario="dcarboni")
# con_run = run_my_model(scenario="constant")
# ir_run = run_my_model(scenario="imm_red")
# lr_run = run_my_model(scenario="later_red")
# s5_run = run_my_model(scenario=="s5")

println("*******************************************")
println("MODEL DONE RUNNING")
println("*******************************************")


########################################################
################### PLOT OUTPUT ########################
########################################################

include("plots.jl")


# Gadfly.plot(x = year, y = BAU_temp)

# tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = constant_temp, yarray3 = ir_temp, yarray4 = lr_temp)
# cplot = concplot(xarray = year, yarray1 = BAU_conc, yarray2 = constant_conc, yarray3 = ir_conc, yarray4 = lr_conc)

# PSET #3 PLOT
tplot = tempplot(xarray = year, yarray1 = BAU_temp, yarray2 = pop_temp, 
                yarray3 = gdp_temp, yarray4 = ei_temp, yarray5 = ci_temp)
