class ForecastController < ApplicationController
  attr_accessor :forecast, :location

  def index
    @location = Location.new(params[:search])

    if @location.num_results > 0
      @forecast = ForecastRequest.new(@location.lat, @location.lon).send
      flash[:alert] = "Forecast data not found. Please check the logs (STDOUT)." if @forecast.nil?
    else
      flash[:alert] = "Location not found. Please try again."
    end
  end
end
