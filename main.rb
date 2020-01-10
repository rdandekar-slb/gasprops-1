require 'sinatra'
require './gas.rb'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'



get '/' do
  erb :index
end


post '/calc' do
  
  @press=params["press"].to_f
  @temp=params["temp"].to_f
  @mygas = Gas.new(params["gasname"],params["specificgravity"].to_f, params["co2"].to_f,params["h2s"].to_f,params["n2"].to_f)
  @mygas.calculate_properties(@press,@temp)
  erb :cast
end


get '/results' do

end