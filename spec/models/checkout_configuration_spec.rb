require 'rails_helper'

describe CheckoutConfiguration do
  include Bongloy::SpecHelpers::TranslationHelpers

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
    it { is_expected.to validate_numericality_of(:amount_cents).is_greater_than_or_equal_to(50) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:product_description) }

    context "#amount" do
      subject { build(factory, :amount => 0) }

      let(:asserted_error) {
        translate!(
          :activerecord, :errors, :models,
          :checkout_configuration, :attributes, :amount_cents,
          :greater_than_or_equal_to, :count => 50
        )
      }

      it { subject.valid? ; expect(subject.errors[:amount]).to include(asserted_error) }
    end
  end

  it { is_expected.to monetize(:amount_cents) }
end
