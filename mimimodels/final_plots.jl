# PREPARES PLOT FUNCTIONS FOR GRAPHS IN FINAL TAKE-HOME

function temp2(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("blue"))),        
    Guide.xlabel("Year"), Guide.ylabel("Temperature Anomaly (C)"), 
    Guide.title("Temperature Anomaly - Role of Non-CO2 Gases"),
    Guide.manual_color_key("Scenario: ", ["BAU", "RF of NON-CO2 = 0"], 
    ["red", "blue"]))

end


function rf2(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test3)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("green"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("purple"))),        
    Guide.xlabel("Year"), Guide.ylabel("Radiative Forcing (W/m^2)"), 
    Guide.title("Radiative Forcing - Role of Non-CO2 Gases"),
    Guide.manual_color_key("Scenario: ", ["BAU", "RF of NON-CO2 = 0"], 
    ["green", "purple"]))

end