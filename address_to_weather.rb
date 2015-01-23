require 'open-uri'
require 'json'
puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"
the_address = gets.chomp
url_safe_address = URI.encode(the_address)

url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_address}"
raw_map_data = open(url).read
parsed_map_data = JSON.parse(raw_map_data)
results = parsed_map_data["results"]
first = results[0]
geometry = first["geometry"]
location = geometry["location"]
the_latitude = location["lat"]
the_longitude =location["lng"]

url = "https://api.forecast.io/forecast/1eca96eac95b937d4da06737228bb716/#{the_latitude},#{the_longitude}"
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)
currently = parsed_data["currently"]
the_temperature = currently["temperature"]

hourly = parsed_data ["hourly"]
hour_data = hourly["data"]
hour_conditions = hour_data[0]
the_hour_outlook = hour_conditions["summary"]

daily = parsed_data ["daily"]
data = daily["data"]
weather_conditions = data[0]
the_day_outlook = weather_conditions["summary"]

puts "The current temperature at #{the_address} is #{the_temperature.round(1)} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}."
puts "The outlook for the next day is: #{the_day_outlook}"
