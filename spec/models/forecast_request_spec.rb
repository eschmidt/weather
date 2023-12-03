# frozen_string_literal: true

require "rails_helper"

RSpec.describe ForecastRequest do
  describe '.send' do
    let(:lat) { "0" }
    let(:lon) { "0" }
    let(:exclude) { nil }

    subject { ForecastRequest.new(lat, lon).send }

    context 'when there is a problem with the response' do
      before do
        unauth_response = instance_double("response", status: 401, body: { cod: 401, message: "Unauthorized" })
        allow(Excon).to receive(:get).and_return(unauth_response)
      end

      it { is_expected.to be_nil }
    end
  end
end