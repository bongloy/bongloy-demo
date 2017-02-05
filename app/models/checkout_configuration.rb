class CheckoutConfiguration
  attr_accessor :bongloy_js_url, :checkout_js_url, :publishable_key,
                :bongloy_charges_url,
                :bongloy_test_account_email, :bongloy_test_account_password,
                :image_url, :name, :description, :label,
                :amount, :currency,
                :user, :email, :charge_description

  delegate :first_name, :first_name?, :email, :to => :user, :prefix => true, :allow_nil => true

  def initialize(options = {})
    self.user = options[:user]
    self.name = options[:name] || (user_first_name? ? "#{user_first_name}'s Shop" : ENV["BONGLOY_CHECKOUT_DEFAULT_NAME"])
    self.description = options[:description] || ENV["BONGLOY_CHECKOUT_DEFAULT_DESCRIPTION"]
    self.charge_description = options[:charge_description] || "Charge from #{name}"
    self.image_url = options[:image_url] || ENV["BONGLOY_CHECKOUT_DEFAULT_IMAGE_URL"]
    self.publishable_key = options[:publishable_key] || ENV["BONGLOY_DEFAULT_PUBLISHABLE_KEY"]
    self.checkout_js_url = options[:checkout_js_url] || ENV["BONGLOY_CHECKOUT_DEFAULT_JS_URL"]
    self.bongloy_js_url = options[:bongloy_js_url] || ENV["BONGLOY_DEFAULT_JS_URL"]
    self.bongloy_charges_url = options[:bongloy_charges_url] || ENV["BONGLOY_CHARGES_URL"]
    self.bongloy_test_account_email = options[:bongloy_test_account_email] || ENV["BONGLOY_TEST_ACCOUNT_EMAIL"]
    self.bongloy_test_account_password = options[:bongloy_test_account_password] || ENV["BONGLOY_TEST_ACCOUNT_PASSWORD"]
    self.label = options[:label] || ENV["BONGLOY_CHECKOUT_DEFAULT_LABEL"]
    self.amount = options[:amount] || ENV["BONGLOY_CHECKOUT_DEFAULT_AMOUNT"]
    self.currency = options[:currency] || ENV["BONGLOY_CHECKOUT_DEFAULT_CURRENCY"]
    self.email = options[:email] || user_email
  end

  def sample_expiry_date
    Time.now.strftime("%m / %y")
  end
end
