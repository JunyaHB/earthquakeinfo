require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'line/bot'

class Tasks::Earthquakeinfo
end

uri = URI.parse('https://api.p2pquake.net/v1/human-readable')
response = Net::HTTP.get(uri)
json = JSON.parse(response)

json.each { |record|
  lastinfo = Information.last
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
    
    unless @information.location == lastinfo.location && @information.scale == lastinfo.scale && @information.latitude == lastinfo.latitude && @information.longitude == lastinfo.longitude && @information.disastertime == lastinfo.disastertime && @information.tsunami == lastinfo.tsunami
      @information.save

      if record.fetch("earthquake").fetch("maxScale") > 30
        client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV["LINE_SECRET_TOKEN"]
          config.channel_token = ENV["LINE_ACCESS_TOKEN"]
        } 

        message={
          type: 'text',
          text: '震度4以上の地震が発生しました。建物への影響をご確認下さい'
        }

        user_id = ENV["LINE_USER_ID"]
        response = client.push_message(user_id, message)
      end
      
    end
    
    break
    
  end

}