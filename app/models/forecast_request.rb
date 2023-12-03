class ForecastRequest
  include ActiveModel::API

  BASE_URL = 'https://api.openweathermap.org/data/3.0/onecall'.freeze

  def initialize(lat, lon)
    @lat = CGI.escape(lat.to_s)
    @lon = CGI.escape(lon.to_s)
    @api_key = CGI.escape(ENV["OPEN_WEATHER_API_KEY"] || "")
  end

  def send
    cache_key = "#{@lat},#{@lon}"

    response = Rails.cache.read(cache_key)
    Rails.logger.debug "response after reading from cache: [#{response}]"
    @cached = true

    if response.nil?
      Rails.logger.debug "CACHE MISS"
      @cached = false

      # Read saved response from file to avoid calling the API too much while testing
      # fptr = File.open('mock.txt', 'r')
      # body = fptr.read
      # fptr.close

      Rails.logger.debug "requesting #{BASE_URL}?lat=#{@lat}&lon=#{@lon}&exclude=#{@exclude}&appid=#{@api_key}&units=imperial"
      api_response = Excon.get("#{BASE_URL}?lat=#{@lat}&lon=#{@lon}&exclude=#{@exclude}&appid=#{@api_key}&units=imperial")
      if api_response.status != 200
        Rails.logger.error "Open Weather API returned status #{api_response.status}"
        Rails.logger.error "#{api_response.body}"
        return nil
      end

      response = ForecastResponse.new(@cached, JSON.parse(api_response.body))

      Rails.logger.debug "writing cache_key (#{cache_key}) to the cache so we can use it later"
      Rails.cache.write(cache_key, response, expires_in: 60 * 30)
    end

    response.cached = @cached # don't use the cached value here; cache-ception!
    response
  end
end
