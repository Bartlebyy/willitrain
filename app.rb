require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'dotenv'
Dotenv.load
require 'sinatra/activerecord'
require 'sinatra/reloader'
require './config/environments'
require './app/models/user'

configure :development, :test do
  require 'pry'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end
 
# get '/' do
#   sender = params[:From]
#   text = params[:Body]
#   friends = {
#     ENV['PLAYER_1_CELL_NUMBER'] => "Player 1",
#   }
#   name = friends[sender] || "Mobile Monkey"
#   twiml = Twilio::TwiML::Response.new do |r|
#     r.Message "Hello, #{ name }. Thanks for the message."
#   end
#   twiml.text
# end

get '/test' do
  if params.any?
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message User[params].run
    end
    twiml.text
  else
    "Thanks for visiting us online."
  end
end