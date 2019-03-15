class Tax::Vehicle < ApplicationRecord
  GENDERS = ["ប្រុស", "ស្រី"].freeze
  PRICES = {
    "រថយន្តទេសចរណ៍" => 160000,
    "រថយន្តដឹកទំនិញធន់តូច(PICK UP)ទ្វារ២" => 200000,
    "រថយន្តដឹកទំនិញធន់តូច​(PICK UP)ទ្វារ៤" => 250000,
    "រថយន្តដឹកទំនិញធន់ធ្ងន់" => 500000,
    "រ៉ឺម៉កសណ្តោង" => 500000,
    "រថយន្តដឹកអ្នកដំណើរ" => 250000,
    "មធ្យោបាយដឹកជញ្ជូនកែឆ្នៃផ្សេងទៀត" => 2000000
  }.freeze

  validates :plate_number, :brand, :vehicle_type, :color, :engine_number, :year, :power, :name, :en_name, :gender, :birth_date, :id_number, :home, :street, :vilage, :commune, :district, :city, :email, :phone_number, presence: true


  def self.prefill
    new(
      brand: 'Audi Q7',
      color: 'ស',
      engine_number: '1D4GP25B34B579630',
      year: '2010',
      power: '329',
      name: 'លី ពិសិទ្ធ',
      en_name: 'Ly Piseth',
      gender: 'ប្រុស',
      birth_date: '1980-05-23',
      id_number: '010334455',
      home: '24',
      street: '271',
      vilage: 'ដំណាក់ធំ',
      commune: 'ស្ទឹងមានជ័យ',
      district: 'មានជ័យ',
      city: 'ភ្នំពេញ',
      email: 'demo@bongloy.com',
      phone_number: '012345678'
    )
  end

  before_create :generate_reference_number

  def generate_reference_number
    self.reference_number = rand(10**5..10**6-1)
  end

  def amount_in_riel
    PRICES[vehicle_type]
  end

  def amount
    amount_in_riel / 4000
  end

  def amount_in_cents
    amount * 100
  end

  def charge(params)
    update(params)
    Stripe::Charge.create(
      amount: amount_in_cents,
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
