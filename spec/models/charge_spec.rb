require 'rails_helper'

describe Charge do
  describe "validations" do
    it "validates attributes" do
      expect(subject).to validate_presence_of(:amount)
      expect(subject).to validate_presence_of(:token)
      expect(subject).to validate_presence_of(:currency)
    end
  end

  describe "#save" do
    it "creates a charge using the Bongloy API" do
      charge = build(:charge)
      WebMock.stub_request(:post, "https://api.bongloy.com/v1/charges").and_return(
        :body => File.read(Rails.root.join("spec/fixtures/charge.succeeded.json")),
        :status => 201,
        :headers => {'Content-Type' => "application/json;charset=utf-8"}
      )

      result = charge.save

      expect(result).to eq(true)
      expect(WebMock).to have_requested(:post, "https://api.bongloy.com/v1/charges").with { |request|
        payload = WebMock::Util::QueryMapper.query_to_values(request.body)
        expect(payload["source"]).to eq(charge.token)
        expect(payload["amount"]).to eq(charge.amount.to_s)
        expect(payload["currency"]).to eq(charge.currency)
        expect(payload["description"]).to eq(charge.description)
      }
    end
  end
end
