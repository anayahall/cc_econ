# Anaya Hall
# CCE - Fall 2017

using Gadfly

function tempplot(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, 
    yarray4::Array=test2, yarray5::Array=test2)
    
    plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),         
    layer(x=xarray, y=yarray5, Geom.line, Theme(default_color=color("pink"))),             
    Guide.xlabel("Year"), Guide.ylabel("Temperature (degrees C)"), 
    Guide.title("Temperature Anomaly"),
    Guide.manual_color_key("Scenario: ", ["BAU", "Constant", "Immediate Reduction", "Later Reduction", "5"], 
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
# constant_temp = con_run[:climatedynamics, :temp]
# ir_temp = ir_run[:climatedynamics, :temp]
# lr_temp = lr_run[:climatedynamics, :temp]
# s5_temp = s5_run[:climatedynamics, :temp]

BAU_conc = bau_run[:climatedynamics, :CO2ppm]
# constant_conc = con_run[:climatedynamics, :CO2ppm]
# ir_conc = ir_run[:climatedynamics, :CO2ppm]
# lr_conc = lr_run[:climatedynamics, :CO2ppm]


println("*******************************************")
println("PREPARING TO PLOT")
println("*******************************************")


