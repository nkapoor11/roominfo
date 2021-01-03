require 'http'
require 'json'
class Destination < ApplicationRecord
  def api_key
    "GRoH87noZyoYA7fjRoe11fD9VQQLdcwf"
  end
    
  def min_temp
    loc_id = query_for_location_id
    result = query_for_forecast(loc_id)
    result["Temperature"]["Minimum"]["Value"]
  end
  
  def max_temp
    loc_id = query_for_location_id
    result = query_for_forecast(loc_id)
    result["Temperature"]["Maximum"]["Value"]
  end

  def query_for_location_id
    base_url = "http://dataservice.accuweather.com/locations/v1/cities/search"
    query = "#{base_url}?apikey=#{api_key}&q=#{self.city_name}"
    resp = HTTP.get(query)
    json = JSON.parse(resp)
    json[0]["Key"]
  end

  def weather
    loc_id = query_for_location_id
    result = query_for_forecast(loc_id)
    weather = result["Day"]["IconPhrase"]
    min_temp  = result["Temperature"]["Minimum"]["Value"]
    max_temp = result["Temperature"]["Maximum"]["Value"]
    [weather, min_temp, max_temp]
  end

  def query_for_forecast(loc_id)
    base_url = "http://dataservice.accuweather.com/forecasts/v1/daily/1day/" 
    query = "#{base_url}#{loc_id}?apikey=#{api_key}"
    resp = HTTP.get(query)
    json = JSON.parse(resp)
    json["DailyForecasts"][0]
  end   
end

