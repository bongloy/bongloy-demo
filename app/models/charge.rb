require "active_model"

class Charge
  include ActiveModel::Model

  attr_accessor :token, :amount, :currency, :description

  validates :token, presence: true

  def save
    return false unless valid?

    execute_charge
  end

  private

  def execute_charge
    Bongloy::Charge.create(
      amount: 10000,
      currency: "USD",
      source: token,
      description: description
    )
    true
  rescue Bongloy::StripeError => e
    errors.add(:base, e.message)
    false
  end
end
