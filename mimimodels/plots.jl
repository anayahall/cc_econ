# Anaya Hall
# CCE - Fall 2017

using Gadfly

function tempplot(;xarray::Array=year, yarray1::Array=test2, yarray2::Array=test3, yarray3::Array=test2)
    
    plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("green"))),     
    Guide.xlabel("Year"), Guide.ylabel("Temperature (C)"), 
    Guide.title("Temperature Anomaly"),
    Guide.manual_color_key("Scenario", ["BAU", "Constant", "IR"], ["red", "blue", "green"]))

end

function concplot(;xarray::Array=year, yarray1::Array=test2, yarray2::Array=test3)
    
    plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
        layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))), 
        Guide.xlabel("Year"), Guide.ylabel("CO2 conc (ppm)"), 
        Guide.title("CO2 Concentration"),
        Guide.manual_color_key("Scenario", ["BAU", "Constant"], ["red", "blue"]))

end

year = collect(2010:2300)
test2 = collect(1:291)
test3 = collect(2:292)

println("*******************************************")
println("PREPARING TO PLOT")
println("*******************************************")


