require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'dotenv'
Dotenv.load

configure :development, :test do
  require 'pry'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  # params = { From: "11234567890", Body: "30306" } #for testing purposes
  if params.any?
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message Text[params].run
    end
    twiml.text
  else
    "Thanks for visiting us online. Now get off the web and text #{ ENV['TWILIO_NUMBER'] }. Cool beans."
  end
end