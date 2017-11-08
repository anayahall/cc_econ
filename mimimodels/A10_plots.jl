# Anaya Hall
# CCE - Fall 2017

using Gadfly

#ASSIGNMENT #10
#QUESTION 2
#PLOT ONE - DAMAGES BY INCOME ELASTICITY SPECIFICATION

function damageplot7(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test2, yarray3::Array=test2, yarray4::Array=test2,
    yarray5::Array=test2, yarray6::Array=test2, yarray7::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("black"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("orange"))),
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("yellow"))),
    layer(x=xarray, y=yarray5, Geom.line, Theme(default_color=color("green"))),
    layer(x=xarray, y=yarray6, Geom.line, Theme(default_color=color("blue"))),
    layer(x=xarray, y=yarray7, Geom.line, Theme(default_color=color("purple"))),   
    Guide.xlabel("Year"), Guide.ylabel("Marginal Damages (PV USD)"), 
    Guide.title("Damages of Marginal Ton of CO2"),
    Guide.manual_color_key("Discount Rate: ", ["Undiscounted", "rho = 0.00", "rho = 0.01", "rho = 0.03", 
        "r = 0.025", "r = 0.03", "r = 0.05"], 
    ["black", "red", "orange", "yellow", "green", "blue", "purple"]))

end
year = collect(2010:2300)


function damageplot6(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test2, yarray3::Array=test2, yarray4::Array=test2,
    yarray5::Array=test2, yarray6::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("orange"))),
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("yellow"))),
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("green"))),
    layer(x=xarray, y=yarray5, Geom.line, Theme(default_color=color("blue"))),
    layer(x=xarray, y=yarray6, Geom.line, Theme(default_color=color("purple"))),   
    Guide.xlabel("Year"), Guide.ylabel("Marginal Damages (PV USD)"), 
    Guide.title("Damages of Marginal Ton of CO2"),
    Guide.manual_color_key("Discount Rate: ", ["rho = 0.00", "rho = 0.01", "rho = 0.03", 
    "r = 0.025", "r = 0.03", "r = 0.05"], 
    ["red", "orange", "yellow", "green", "blue", "purple"]))

end
year = collect(2010:2300)

year = collect(2010:2300)
test2 = collect(1:291)
test3 = collect(2:292)



println("*******************************************")
println("PREPARING TO PLOT")
println("*******************************************")


