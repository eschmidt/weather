# frozen_string_literal: true

require "rails_helper"

RSpec.describe Location do
  it "accepts a valid US postal code" do
    loc = Location.new("90210")
    expect(loc.display_name).to include("Beverly Hills")
  end

  it "accepts a valid US city" do
    loc = Location.new("Denver")
    expect(loc.display_name).to include("Colorado")
  end

  it "handles garbage location searches gracefully" do
    loc = Location.new("this is not a valid location search")
    expect(loc.display_name).to eq("No Location Found")
  end
end