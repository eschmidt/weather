class ForecastRequest
  include ActiveModel::API

  BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall'.freeze

  def initialize(lat, lon, exclude)
    @lat = CGI.escape(lat.to_s)
    @lon = CGI.escape(lon.to_s)
    @exclude = CGI.escape(exclude.to_s)
    @api_key = CGI.escape(ENV["OPEN_WEATHER_API_KEY"])
  end

  def send
    cache_key = "#{@lat},#{@lon}"

    response = Rails.cache.read(cache_key)
    puts "DEBUG: response(#{response})"
    @cached = true

    if response.nil?
      puts "DEBUG: CACHE MISS"
      @cached = false

      puts "DEBUG: requesting #{BASE_URL}?lat=#{@lat}&lon=#{@lon}&exclude=#{@exclude}&appid=#{@api_key}&units=imperial"
      api_response = Excon.get("#{BASE_URL}?lat=#{@lat}&lon=#{@lon}&exclude=#{@exclude}&appid=#{@api_key}&units=imperial")

      # Read saved response from file to avoid calling the API too much while testing
      # fptr = File.open('mock.txt', 'r')
      # body = fptr.read
      # fptr.close

      return nil if api_response.status != 200

      response = ForecastResponse.new(@cached, JSON.parse(api_response.body))

      puts "DEBUG: writing cache_key (#{cache_key}) to the cache so we can use it later"
      Rails.cache.write(cache_key, response, expires_in: 60 * 30)
    end

    response.cached = @cached # don't use the cached value here; cache-ception!
    response
  end
end
