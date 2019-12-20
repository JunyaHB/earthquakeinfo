require 'net/http'
require 'uri'
require 'json'
require 'time'

class Tasks::Earthquakeinfo
end

uri = URI.parse('https://api.p2pquake.net/v1/human-readable')
response = Net::HTTP.get(uri)
json = JSON.parse(response)

json.each { |record|
  if record.fetch("code") == 551
    @information = Information.new
    @information.location = record.fetch("earthquake").fetch("hypocenter").fetch("name")
    @information.scale = record.fetch("earthquake").fetch("maxScale")
  
    latitude = record.fetch("earthquake").fetch("hypocenter").fetch("latitude")
    latitude.slice!(0)
    @information.latitude = latitude
  
    longitude = record.fetch("earthquake").fetch("hypocenter").fetch("longitude")
    longitude.slice!(0)
    @information.longitude = longitude
  
    disastertime = record.fetch("time")
    disastertime.slice!(-4..-1)
    @information.disastertime = disastertime
    @information.tsunami = record.fetch("earthquake").fetch("domesticTsunami")
    
    @information.save
 
  end

}