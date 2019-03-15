class Tax::Vehicle < ApplicationRecord
  GENDERS = ["ប្រុស", "ស្រី"].freeze
  TYPES = [
    "រថយន្តទេសចរណ៍",
    "រថយន្តដឹកទំនិញធន់តូច(PICK UP)ទ្វារ២",
    "រថយន្តដឹកទំនិញធន់តូច​(PICK UP)ទ្វារ៤",
    "រថយន្តដឹកទំនិញធន់ធ្ងន់",
    "រ៉ឺម៉កសណ្តោង",
    "រថយន្តដឹកអ្នកដំណើរ",
    "មធ្យោបាយដឹកជញ្ជូនកែឆ្នៃផ្សេងទៀត"
  ].freeze

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
