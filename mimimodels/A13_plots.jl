# Anaya Hall
# CCE - Fall 2017

using Gadfly

#ASSIGNMENT #13

year = collect(2010:2300)

test2 = collect(1:291)
test3 = collect(2:292)

# The final step is to create two graphs that compare the optimal policies for 
# the three pure rate of time preferences. The first graph should compare the 
# emission control rate over time for the three discount rates. 


#QUESTION 2
#PLOT ONE - EMISSION POLICY FOR THREE RHOs

function emissionrate(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test2, yarray3::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("orange"))),
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("blue"))),   
    Guide.xlabel("Year"), Guide.ylabel("Emission Control Rate"), 
    Guide.title("Emission Control Policy under Different Discount Rates"),
    Guide.manual_color_key("Discount Rate: ", ["rho = 0.1%", "rho = 1%", "rho = 3%"], 
    ["red", "orange","blue"]))

end

#PLOT TWO - TEMPERATURE TRAJECTORIES FOR THREE RHOs

# The second graph should compare the temperature trajectories for the three discount rates over 
# time and also include the temperature trajectory for a no-policy scenario. 
# Add a description of your findings in a short paragraph.

function tempplot(;xarray::Array=year, yarray1::Array=test2, 
    yarray2::Array=test2, yarray3::Array=test2, yarray4::Array=test2)
    
    Gadfly.plot(layer(x=xarray, y=yarray1, Geom.line, Theme(default_color=color("red"))),
    layer(x=xarray, y=yarray2, Geom.line, Theme(default_color=color("orange"))),
    layer(x=xarray, y=yarray3, Geom.line, Theme(default_color=color("blue"))),
    layer(x=xarray, y=yarray4, Geom.line, Theme(default_color=color("black"))),   
    Guide.xlabel("Year"), Guide.ylabel("Temperature (Degrees Celsius)"), 
    Guide.title("Temperature Trajectories under Different Discount Rates"),
    Guide.manual_color_key("Discount Rate: ", ["rho = 0.1%", "rho = 1%", "rho = 3%", "no emission policy"], 
    ["red", "orange","blue", "black"]))

end