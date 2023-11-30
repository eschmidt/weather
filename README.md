# README

Eric Schmidt
<eric.purdue@gmail.com>


To start web application:
```
$ export OPEN_WEATHER_API_KEY=<key>
$ bin/rails server
$ open http://127.0.0.1:3000
```

Sign up for an OpenWeather API key here: https://home.openweathermap.org/api_keys (or ask me nicely for mine 😉)

# Features

* Accepts a wide variety of location formats. Try: `90210`, `Palo Alto`, or `Statue of Liberty`
* If there are ambiguous results, displays up to three `Did you mean?` options (try `Paris` for example)
* Graceful error handling for non-location input
* TK: switch between hourly or daily forecast data
* TK: fancy cards with weather icons

# Front End

I used bootstrap for a mobile-first approach with well known and easy to use components.

[TK] You can switch between hourly or daily forecasts using a bootstrap pill.

[TK] Weather data is displayed pleasantly using cards and icons.

# Back End

I am getting weather data from the Open Weather API. This requires lat/lon data which I extract from the input utilizing
a series of gems.

Gems:
* rspec-rails - for behavior driven development
* geocoder - get lat/lon data for a given search string
* zip-codes - translate zip codes to city/state (otherwise geocoder acts pretty funky)
* excon - to call the openweather API

# Other
* Ruby version
3.2.2

* Rails version
7.1.2

* Configuration

`export OPEN_WEATHER_API_KEY=<key>`

* How to run the test suite

`rspec spec`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
