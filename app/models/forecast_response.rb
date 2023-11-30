# frozen_string_literal: true

class ForecastResponse
  include ActiveModel::API

  attr_accessor :current_dt, :current_feels_like, :current_temp, :current_weather_description, :current_weather_icon,
                :daily_dew_point, :daily_humidity, :daily_pressure, :daily_summary, :daily_sunrise, :daily_sunset,
                :daily_temp_day, :daily_temp_eve, :daily_temp_morn, :daily_temp_night, :daily_uvi, :daily_wind_speed,
                :daily, :hourly, :timezone

  def initialize(json_body)
    # parse the response from the OpenWeather API
    # docs at https://openweathermap.org/api/one-call-3#data

    @daily = [
      {
        'dt': 0,
        'temp': {
          'max': 0,
          'min': 0
        },
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': {
          'max': 0,
          'min': 0
        },
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': {
          'max': 0,
          'min': 0
        },
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': {
          'max': 0,
          'min': 0
        },
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': {
          'max': 0,
          'min': 0
        },
        'weather_icon': ''
      }
    ]

    pp @daily

    @hourly = [
      {
        'dt': 0,
        'temp': 0,
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': 0,
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': 0,
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': 0,
        'weather_icon': ''
      }, {
        'dt': 0,
        'temp': 0,
        'weather_icon': ''
      }
    ]

    @current_dt = json_body['current']['dt']
    @current_feels_like = json_body['current']['feels_like']
    @current_temp = json_body['current']['temp']
    @current_weather_description = json_body['current']['weather'][0]['description']
    @current_weather_icon = json_body['current']['weather'][0]['icon']
    @daily_dew_point = json_body['daily'][0]['dew_point']
    @daily_humidity = json_body['daily'][0]['humidity']
    @daily_pressure = json_body['daily'][0]['pressure']
    @daily_summary = json_body['daily'][0]['summary']
    @daily_sunrise = json_body['daily'][0]['sunrise']
    @daily_sunset = json_body['daily'][0]['sunset']
    @daily_temp_day = json_body['daily'][0]['temp']['day']
    @daily_temp_eve = json_body['daily'][0]['temp']['eve']
    @daily_temp_morn = json_body['daily'][0]['temp']['morn']
    @daily_temp_night = json_body['daily'][0]['temp']['night']
    @daily_uvi = json_body['daily'][0]['uvi']
    @daily_wind_speed = json_body['daily'][0]['wind_speed']

    (0..4).each { |d| @daily[d][:temp][:max] = json_body['daily'][d]['temp']['max'] }
    (0..4).each { |d| @daily[d][:temp][:min] = json_body['daily'][d]['temp']['min'] }
    (1..4).each { |d| @daily[d][:dt] = json_body['daily'][d]['dt'] }
    (0..4).each { |d| @daily[d][:weather_icon] = json_body['daily'][d]['weather'][0]['icon'] }

    (0..4).each { |d| hourly[d][:temp] = json_body['hourly'][d]['temp'] }
    (0..4).each { |d| hourly[d][:weather_icon] = json_body['hourly'][d]['weather'][0]['icon'] }
    (1..4).each { |d| hourly[d][:dt] = json_body['hourly'][d]['dt'] }

    @timezone = json_body['timezone']
  end
end
