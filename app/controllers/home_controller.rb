require 'net/http'
require 'json'

class HomeController < ApplicationController

  

  def index        
    @countries = Country.all

    if(request.post?)            
      url = "http://api.openweathermap.org/data/2.5/weather?"+"q="+weather['city']+","+weather['country']+"&units=metric&appid=" + ENV['API_KEY']      
      uri = URI(url)
      response = Net::HTTP.get(uri)
      apiResp = JSON.parse(response)
      @resp = Hash.new

      if apiResp['cod'] == "404"
        @resp[:error] = true        
      else        
        @resp[:error] = false        
        @resp[:name] = apiResp['name']
        @resp[:temp_min] = apiResp['main']['temp_min']
        @resp[:temp_max] = apiResp['main']['temp_max']
        @resp[:humidity] = apiResp['main']['humidity']
        @resp[:main] = apiResp['weather'][0]['main']      
        @resp[:icon] = apiResp['weather'][0]['icon']        
      end        
    end
  end 
  
  private 
  def weather
    params.require(:weather).permit(:country, :city)
  end 
end
