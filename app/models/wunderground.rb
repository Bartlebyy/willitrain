class Wunderground
  require 'open-uri'
  require 'json'

  attr_reader :zipcode

  def self.[] zipcode
    new(zipcode)
  end

  def initialize zipcode
    @zipcode = zipcode
  end

  def run
    open("http://api.wunderground.com/api/#{ENV['WUNDERGROUND_KEY']}/hourly/q/#{zipcode}.json") do |f|
      json_string = f.read
      hourly_forecast = JSON.parse(json_string)['hourly_forecast']
      report(hourly_forecast)
    end
  end

  def report hourly_forecast, num_of_hours = 12
    final_report = ["Hourly Report"]

    (0...num_of_hours).map do |n| 
      data = hourly_forecast[n]
      hour = data["FCTTIME"]["hour_padded"]
      temp = data["temp"]["english"].rjust(2) + "°"
      probability_of_precipitation = data["pop"].rjust(2) + "%"
      final_report << "#{ hour }: #{ temp } | #{ probability_of_precipitation }"
    end
    final_report.join("\n")
  end

end