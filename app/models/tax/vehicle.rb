class Tax::Vehicle < ApplicationRecord
  before_create :generate_reference_number

  def generate_reference_number
    self.reference_number = rand(10**5..10**6-1)
  end

  def charge(params)
    update(params)
    Stripe::Charge.create(
      amount: 10000,
      currency: "USD",
      source: token,
      metadata: {reference_number: reference_number }
    )
    true
  rescue Stripe::StripeError => e
    errors.add(:base, e.message)
    puts e.message
    false
  end
end
