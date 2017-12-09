########################################################
################## BUILD MODEL #########################
########################################################

include("economy.jl")
include("emissions.jl")
include("abatement.jl")
include("carboncycle.jl")
include("climatedynamics.jl")
include("sealevelrise.jl")
include("damages.jl")
include("discountfactor.jl")
include("welfare.jl")

function run_my_model(;scenario::AbstractString="bau")
       
    my_model = Model()

    setindex(my_model, :time, collect(2010:1:2300))

    #Order matters here: 
    addcomponent(my_model, grosseconomy)
    addcomponent(my_model, emissions)
    addcomponent(my_model, abatement)
    addcomponent(my_model, carboncycle)  
    addcomponent(my_model, climatedynamics)
    addcomponent(my_model, damages)
    addcomponent(my_model, sealevelrise)
    addcomponent(my_model, neteconomy)
    addcomponent(my_model, discountfactor)
    addcomponent(my_model, welfare)

    #set parameters for GROSS ECONOMIC GROWTH COMPONENT
    setparameter(my_model, :grosseconomy, :L, L)
    setparameter(my_model, :grosseconomy, :s, s)
    setparameter(my_model, :grosseconomy, :depk, depk)
    setparameter(my_model, :grosseconomy, :k0, k0)
    setparameter(my_model, :grosseconomy, :alpha, alpha)
    setparameter(my_model, :grosseconomy, :kaya_gdp, kaya_gdp)
    setparameter(my_model, :grosseconomy, :A, A)
    connectparameter(my_model,:grosseconomy, :YNET, :neteconomy, :YNET)

    #set parameters for EMISSIONS COMPONENT
    # setparameter(my_model, :emissions, :pop, pop)
    # setparameter(my_model, :emissions, :gdppc, gdppc)
    connectparameter(my_model, :emissions, :YGROSS, :grosseconomy, :YGROSS)
    setparameter(my_model, :emissions, :energyi, energyi)
    setparameter(my_model, :emissions, :carboni, carboni)
    setparameter(my_model, :emissions, :luco2, luco2)    
    setparameter(my_model, :emissions, :epolicy, epolicy)
    if scenario == "bau"            
        setparameter(my_model, :emissions, :marginalton, 0.0)
    elseif scenario == "mar"
        setparameter(my_model, :emissions, :marginalton, (1/(10^6))*(44/12))        
    end            
    
    #set parameters for ABATEMENT COMPONENT
	# setparameter(my_model, :abatement, :bkstp0, bkstp0)
    # setparameter(my_model, :abatement, :sigma0, sigma0)
    # setparameter(my_model, :abatement, :sigma_rate, sigma_rate)
    setparameter(my_model, :abatement, :backstop, backstop)
    setparameter(my_model, :abatement, :sigma, sigma)
    setparameter(my_model, :abatement, :AC_exponent, AC_exponent)
    setparameter(my_model, :abatement, :epolicy, epolicy)            
    connectparameter(my_model, :abatement, :YGROSS, :grosseconomy, :YGROSS)
    
    #set parameters for CARBON CYCLE COMPONENT
	setparameter(my_model, :carboncycle, :M_atm0, M_atm0)
	setparameter(my_model, :carboncycle, :M_lo0, M_lo0)
    setparameter(my_model, :carboncycle, :M_up0, M_up0)
    connectparameter(my_model, :carboncycle, :CO2emis, :emissions, :emis)    

	# CLIMATE DYNAMICS COMPONENT
    setparameter(my_model, :climatedynamics, :CO2ppm0, CO2ppm0)
    setparameter(my_model, :climatedynamics, :RF_Other, RF_Other)
    setparameter(my_model, :climatedynamics, :climate_sens, climate_sens)
    setparameter(my_model, :climatedynamics, :delay, delay)
    setparameter(my_model, :climatedynamics, :temp0, temp0)
	connectparameter(my_model, :climatedynamics, :CO2ppm, :carboncycle, :CO2ppm)
    
    # SEA LEVEL RISE COMPONENT
    setparameter(my_model, :sealevelrise, :ef, ef)
    setparameter(my_model, :sealevelrise, :slsens, slsens)
    setparameter(my_model, :sealevelrise, :psi, psi)
    setparameter(my_model, :sealevelrise, :omega, omega)
    connectparameter(my_model, :sealevelrise, :temp, :climatedynamics, :temp)
    
    # Set parameters for DAMAGE COMPONENT
    setparameter(my_model, :damages, :d_coeff, d_coeff)
    setparameter(my_model, :damages, :d_coeff_sq, d_coeff_sq)
    setparameter(my_model, :damages, :d_exp, d_exp)
    setparameter(my_model, :damages, :d_elast, d_elast)
    connectparameter(my_model, :damages, :temp, :climatedynamics, :temp)
    connectparameter(my_model, :damages, :slr_damages, :sealevelrise, :slr_damages)    
    connectparameter(my_model, :damages, :YGROSS, :grosseconomy, :YGROSS)
    
    #set parameters for NET ECONOMIC GROWTH COMPONENT
    setparameter(my_model, :neteconomy, :pop, pop)
    setparameter(my_model, :neteconomy, :savings, s)    
    connectparameter(my_model, :neteconomy, :YGROSS, :grosseconomy, :YGROSS)
    connectparameter(my_model, :neteconomy, :abatement, :abatement, :ab_cost)
    connectparameter(my_model, :neteconomy, :d_dollars, :damages, :d_dollars)

    #set parameters for DISCOUNT FACTOR COMPONENT
    setparameter(my_model, :discountfactor, :year, Array(1:291))
    setparameter(my_model, :discountfactor, :rho, rho)    
    setparameter(my_model, :discountfactor, :eta, eta)        
    connectparameter(my_model, :discountfactor, :pccons, :neteconomy, :cons_pc)

    #set parameters for WELFARE COMPONENT
    setparameter(my_model, :welfare, :pop, pop)
    setparameter(my_model, :welfare, :rho, rho)
    connectparameter(my_model, :welfare, :pccons, :neteconomy, :cons_pc)

    run(my_model)
	return(my_model)

end
