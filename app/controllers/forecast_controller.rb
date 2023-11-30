class ForecastController < ApplicationController
  attr_accessor :forecast, :location

  def index
    @location = Location.new(params[:search])
    flash[:alert] = "Location not found. Please try again." if @location.num_results < 1

    @forecast = ForecastRequest.new(@location.lat, @location.lon, []).send
    flash[:alert] += "Forecast data not found. Please check the logs (STDOUT)." if @forecast.nil?
  end
end
