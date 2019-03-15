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

  validates :plate_number, :brand, :vehicle_type, :color, :engine_number, :year, :power, :name, :en_name, :gender, :birth_date, :id_number, :home, :street, :vilage, :commune, :district, :city, :email, :phone_number, presence: true


  def self.prefill
    new(
      plate_number: '1AX-1212',
      brand: 'Audi Q7',
      vehicle_type: TYPES.first,
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
