require "rails_helper"

RSpec.describe ForecastController do
  describe "GET index" do
    it "fails with an error for bad input" do
      get :index, params: { search: "not a valid location" }
      expect(flash).to_not be_empty
      expect(response).to have_http_status(:ok)
    end

    it "does not display an error for good input" do
      get :index, params: { search: "90210" }
      expect(flash).to be_empty
      expect(response).to have_http_status(:ok)
    end
  end
end