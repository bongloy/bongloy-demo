require 'rails_helper'

describe CheckoutConfiguration do
  let(:factory) { :checkout_configuration }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "factory" do
    subject { build(factory) }
    it { is_expected.to be_valid }
  end

  describe "validations" do
    subject { create(factory) }
    it { is_expected.to validate_inclusion_of(:currency).in_array(described_class::CURRENCIES ) }
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:product_description) }
  end

  it { is_expected.to monetize(:amount_cents) }
end
