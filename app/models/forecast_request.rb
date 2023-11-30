class ForecastRequest
  include ActiveModel::API

  attr_accessor :lat, :lon, :exclude

  BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall'.freeze

  def initialize(lat, lon, exclude)
    @lat = CGI.escape(lat.to_s)
    @lon = CGI.escape(lon.to_s)
    @exclude = CGI.escape(exclude.to_s)
    @api_key = CGI.escape(ENV["OPEN_WEATHER_API_KEY"])
  end

  def send
    puts "requesting #{BASE_URL}?lat=#{@lat}&lon=#{@lon}&exclude=#{@exclude}&appid=#{@api_key}&units=imperial"
    response = Excon.get("#{BASE_URL}?lat=#{@lat}&lon=#{@lon}&exclude=#{@exclude}&appid=#{@api_key}&units=imperial")

    # Read saved response from file to avoid calling the API too much while testing
    # fptr = File.open('mock.txt', 'r')
    # body = fptr.read
    # fptr.close

    return nil if response.status != 200

    ForecastResponse.new(JSON.parse(response.body))
  end
end
