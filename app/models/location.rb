# frozen_string_literal: true

class Location
  attr_accessor :display_name, :lat, :lon, :num_results

  def initialize(query)
    search(query)
  end

  def search(query)
    @display_name = []

    if query =~ /^\d+\-*\d*$/
      # force a search by zip code
      zipdata = ZipCodes.identify(query)
      @location = Geocoder.search("#{zipdata[:city]}, #{zipdata[:state_code]}")
    else
      @location = Geocoder.search(query)
    end

    Rails.logger.debug "Location data found: [#{@location.inspect}]"

    @num_results = @location.length
    if @num_results > 0
      @lat, @lon = @location.first.coordinates

      (0..[3, (@num_results-1)].min).each do |index|
        @display_name[index] = @location[index].display_name
      end
    else
      @display_name[0] = "No Location Found"
    end

  end
end
