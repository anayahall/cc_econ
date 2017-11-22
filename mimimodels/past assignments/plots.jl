# Anaya Hall
# CCE - Fall 2017

using Gadfly

#ASSIGNMENT #6
#QUESTION 2
#PLOT ONE - DIFF IN PER CAPITA CONSUMPTION

function pccons4(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, 
    yarray4::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),                    
    Guide.xlabel("Year"), Guide.ylabel("Difference in Per Capita Consumption (1000 USD)"), 
    Guide.title("Difference in Per Capita Consumption by Emissions Scenario"),
    Guide.manual_color_key("Scenario: ", ["10% EP", "20% EP", "30% EP",
     "40% EP"], 
    ["red", "blue", "green", "purple"]))

end

#PLOT TWO - DIFF IN ABATEMENT COST

function abcost4(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, 
    yarray4::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),                    
    Guide.xlabel("Year"), Guide.ylabel("Abatement Cost (1000 USD)"), 
    Guide.title("Abatement Cost by Emissions Scenario"),
    Guide.manual_color_key("Scenario: ", ["10% EP", "20% EP", "30% EP",
     "40% EP"], 
    ["red", "blue", "green", "purple"]))

end

#PLOT THREE - DAMAGES AS PERCENT OF OUTPUT

function damages4(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, 
    yarray4::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),                    
    Guide.xlabel("Year"), Guide.ylabel("Damages (% of GDP)"), 
    Guide.title("Damages as Percent of GDP, by Emissions Scenario"),
    Guide.manual_color_key("Scenario: ", ["10% EP", "20% EP", "30% EP",
     "40% EP"], 
    ["red", "blue", "green", "purple"]))

end





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

function netoutput(;xarray::Array=year, yarray1::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),                 
        Guide.xlabel("Year"), Guide.ylabel("Net Output of Economy"), 
        Guide.title("Difference in Net Output of Economy: BAU - Emissions Control"))
        # Guide.manual_color_key("KEY:", ["BAU"], ["red"]))
        
end


year = collect(2010:2300)
test2 = collect(1:291)
test3 = collect(2:292)



println("*******************************************")
println("PREPARING TO PLOT")
println("*******************************************")


