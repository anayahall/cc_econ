# Anaya Hall
# CCE - Fall 2017

using Gadfly

#ASSIGNMENT #7
#QUESTION 1
#PLOT ONE - DAMAGES BY INCOME ELASTICITY SPECIFICATION


function A7plot(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2, 
    yarray4::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("purple"))),                    
    Guide.xlabel("Year"), Guide.ylabel("Damages (2005 USD)"), 
    Guide.title("Damages by Elasticity Specification"),
    Guide.manual_color_key("Scenario: ", ["BAU", "Elast = -0.25", "Elast = 0.0",
     "Elast = 0.25"], 
    ["red", "blue", "green", "purple"]))

end

function A7plotb(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3, yarray3::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    Guide.xlabel("Year"), Guide.ylabel("Damages (Trillions of 2005 USD)"), 
    Guide.title("Damages by Elasticity Specification"),
    Guide.manual_color_key("Scenario: ", ["Elast = -0.25", "Elast = 0.0",
     "Elast = 0.25"], 
    ["red", "blue", "green"]))

end


year = collect(2010:2300)
test2 = collect(1:291)
test3 = collect(2:292)



println("*******************************************")
println("PREPARING TO PLOT")
println("*******************************************")


