require "active_model"

class Charge
  include ActiveModel::Model

  attr_accessor :token, :amount, :currency, :description

  validates :amount, :currency, :token, presence: true

  def save
    return false unless valid?

    execute_charge
  end

  private

  def execute_charge
    Stripe::Charge.create(
      amount: amount,
      currency: currency,
      source: token,
      description: description
    )
    true
  rescue Stripe::StripeError => e
    errors.add(:base, e.message)
    puts e.message
    false
  end
end
