require './gas.rb'

mygas = Gas.new("test",0.65,0.05)

mygas.calculate_properties(2500,110)

p mygas.zfactor_g, mygas.b_g
