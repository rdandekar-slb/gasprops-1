require 'sinatra'
require 'yaml/store'
require './gas.rb'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'

# Choices = {
#   'HAM' => 'Hamburger',
#   'PIZ' => 'Pizza',
#   'CUR' => 'Curry',
#   'NOO' => 'Noodles',
# }

get '/' do
  # @title="Gas Properties Calculator"
 
  erb :index
end


post '/calc' do
  # params.each do |k,v|
  #   p k,v
  # end
  
  @press=params["press"].to_f
  @temp=params["temp"].to_f
  @mygas = Gas.new(params["gasname"],params["specificgravity"].to_f, params["co2"].to_f,params["h2s"].to_f,params["n2"].to_f)
  @mygas.calculate_properties(@press,@temp)
  erb :cast
end


get '/results' do
  # @title = 'Results so far:'
  # @store = YAML::Store.new 'votes.yml'
  # @votes = @store.transaction { @store['votes'] }
  # erb :results
end