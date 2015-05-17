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
    open("http://api.wunderground.com/api/#{ ENV['WUNDERGROUND_KEY'] }/hourly/q/#{ zipcode }.json") do |f|
      json_string = f.read
      hourly_forecast = JSON.parse(json_string)['hourly_forecast']
      report(hourly_forecast)
    end
  end

  def report hourly_forecast, num_of_hours = 12
    final_report = ["\nWeather Update for #{ zipcode }"]

    (0...num_of_hours).map do |n| 
      data = hourly_forecast[n]
      hour = data["FCTTIME"]["civil"].rjust(8)
      temp = data["temp"]["english"].rjust(2) + "°"
      rain = data["pop"].rjust(2) + "%"
      condition = data["condition"]
      final_report << "#{ hour }: #{ temp } | rain: #{ rain } | #{ condition }"
    end
    final_report.join("\n")
  end

end