require 'rubygems'
require 'bundler'
require './secrets'

Bundler.require

set :bind, '0.0.0.0'
set :public_folder, 'public'
APP_KEY = SNOWSHOE_APP_KEY || ENV['SNOWSHOE_APP_KEY']
APP_SECRET = SNOWSHOE_APP_SECRET || ENV['SNOWSHOE_APP_SECRET']

before do
  headers 'Access-Control-Allow-Origin' => '*',
  'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'HEAD'],
  'Access-Control-Allow-Headers' => 'Origin, Authorization, Accept, Content-Type'
end

head '/*' do
  status 200
end

get '/' do
  erb :index, layout: :layout
end

get '/waiting-confirmation' do
  erb :waiting_confirmation, layout: :layout
end

post '/stampscreen' do
  snow_client = Snowshoe::Client.new(APP_KEY, APP_SECRET)
  json = {"data" => params[:data]}

  response = snow_client.post(json)
  if response.include? 'stamp'
    erb :confirmation_screen, layout: :layout
  else
    status 401
    erb :error, layout: :layout
  end
end
