class CheckoutConfiguration
  attr_accessor :bongloy_js_url, :checkout_js_url, :publishable_key,
                :bongloy_charges_url,
                :bongloy_test_account_email, :bongloy_test_account_password,
                :image_url, :name, :description, :label,
                :amount, :currency,
                :user, :email, :charge_description

  delegate :first_name, :first_name?, :email, :to => :user, :allow_nil => true

  def initialize(options = {})
    self.user = options[:user]
    self.name = options[:name] || (first_name? ? "#{first_name}'s Shop" : rails_secret(:bongloy_checkout_default_name))
    self.description = options[:description] || rails_secret(:bongloy_checkout_default_description)
    self.charge_description = options[:charge_description] || "Charge from #{name}"
    self.image_url = options[:image_url] || rails_secret(:bongloy_checkout_default_image_url)
    self.publishable_key = options[:publishable_key] || rails_secret(:bongloy_default_publishable_key)
    self.checkout_js_url = options[:checkout_js_url] || rails_secret(:bongloy_checkout_default_js_url)
    self.bongloy_js_url = options[:bongloy_js_url] || rails_secret(:bongloy_default_js_url)
    self.bongloy_charges_url = options[:bongloy_charges_url] || rails_secret(:bongloy_charges_url)
    self.bongloy_test_account_email = options[:bongloy_test_account_email] || rails_secret(:bongloy_test_account_email)
    self.bongloy_test_account_password = options[:bongloy_test_account_password] || rails_secret(:bongloy_test_account_password)
    self.label = options[:label] || rails_secret(:bongloy_checkout_default_label)
    self.amount = options[:amount] || rails_secret(:bongloy_checkout_default_amount)
    self.currency = options[:currency] || rails_secret(:bongloy_checkout_default_currency)
    self.email = options[:email] || email
  end

  def prefill_email?
    rails_secret(:prefill_email).to_i == 1
  end

  def require_address?
    rails_secret(:require_address).to_i == 1
  end

  def sample_expiry_date
    Time.now.strftime("%m / %y")
  end

  private

  def rails_secret(key)
    Rails.application.secrets[key]
  end
end
