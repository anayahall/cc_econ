# Anaya Hall
# CCE - Fall 2017

using Gadfly

function tempplot3(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),               
    Guide.xlabel("Year"), Guide.ylabel("Temperature (degrees C)"), 
    Guide.title("Temperature Anomaly"),
    Guide.manual_color_key("Scenario: ", ["BAU", "EP1", "EP2"], 
    ["red", "blue", "green"]))
end

function costplot3(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),               
    Guide.xlabel("Year"), Guide.ylabel("Cost (2005 USD)"), 
    Guide.title("Abatement Cost"),
    Guide.manual_color_key("Scenario: ", ["BAU", "EP1", "EP2"], 
    ["red", "blue", "green"]))
end

function tempplot5(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, 
    yarray4::Array=test2, yarray5::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),         
    layer(x=xarray, y=yarray5, Geom.line, Theme(default_color=color("pink"))),             
    Guide.xlabel("Year"), Guide.ylabel("Temperature (degrees C)"), 
    Guide.title("Temperature Anomaly"),
    Guide.manual_color_key("Scenario: ", ["BAU", "Population", "GDP/Pop",
     "Energy Intensity", "Carbon Intensity "], 
    ["red", "blue", "green", "purple", "pink"]))

end

function concplot(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, yarray4::Array=test2)
    
    plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
        layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))),
        layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),  
        layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),                 
        Guide.xlabel("Year"), Guide.ylabel("CO2 conc (ppm)"), 
        Guide.title("CO2 Concentration"),
        Guide.manual_color_key("Scenario:", ["BAU", "Constant", "IR", "LR"], ["red", "blue", "green", "purple"]))
        
end

year = collect(2010:2300)
test2 = collect(1:291)
test3 = collect(2:292)

### Prepare results for plotting

BAU_temp = bau_run[:climatedynamics, :temp]
ep1_temp = ep1_run[:climatedynamics, :temp]
ep2_temp = ep2_run[:climatedynamics, :temp]



# ei_temp = ei_run[:climatedynamics, :temp]
# ci_temp = ci_run[:climatedynamics, :temp]

# constant_temp = con_run[:climatedynamics, :temp]
# ir_temp = ir_run[:climatedynamics, :temp]
# lr_temp = lr_run[:climatedynamics, :temp]
# s5_temp = s5_run[:climatedynamics, :temp]

BAU_cost = bau_run[:abatement, :ab_cost]
ep1_cost = ep1_run[:abatement, :ab_cost]
ep2_cost = ep2_run[:abatement, :ab_cost]
# constant_conc = con_run[:climatedynamics, :CO2ppm]
# ir_conc = ir_run[:climatedynamics, :CO2ppm]
# lr_conc = lr_run[:climatedynamics, :CO2ppm]


println("*******************************************")
println("PREPARING TO PLOT")
println("*******************************************")


