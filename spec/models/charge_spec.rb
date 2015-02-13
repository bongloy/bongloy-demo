require 'rails_helper'

describe Charge do
  subject { build(factory) }
  let(:factory) { :charge }
  let(:api_helpers) { Bongloy::SpecHelpers::ApiHelpers.new }

  describe "validations" do
    it { expect(subject).to validate_presence_of(:amount) }
    it { expect(subject).to validate_presence_of(:token) }
    it { expect(subject).to validate_presence_of(:currency) }
  end

  describe "#save" do
    let(:customer_id) { api_helpers.sample_customer_id }

    before do
      api_helpers.stub_create_customer(:customer_id => customer_id)
      api_helpers.stub_create_charge
      subject.save
    end

    it "should create a customer using the Bongloy API" do
      subject.save
      expect(WebMock).to have_requested(:post, api_helpers.customers_url).with { |request|
        payload = WebMock::Util::QueryMapper.query_to_values(request.body)
        expect(payload["card"]).to eq(subject.token)
      }
    end

    it "should create a charge using the Bongloy API" do
      expect(WebMock).to have_requested(:post, api_helpers.charges_url).with { |request|
        payload = WebMock::Util::QueryMapper.query_to_values(request.body)
        expect(payload["customer"]).to eq(customer_id)
        expect(payload["amount"]).to eq(subject.amount.to_s)
        expect(payload["currency"]).to eq(subject.currency)
      }
    end
  end
end
