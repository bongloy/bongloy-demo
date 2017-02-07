class CheckoutConfiguration < ApplicationRecord
  DEFAULT_CURRENCY = "USD"
  CURRENCIES = [DEFAULT_CURRENCY]

  belongs_to :user

  validates :currency, :presence => true, :inclusion => {:in => CURRENCIES}
  validates :name, :presence => true
  validates :description, :presence => true
  validates :label, :presence => true
  validates :product_description, :presence => true

  monetize :amount_cents, :with_model_currency => :currency

  before_validation :set_defaults, :on => :create

  attr_accessor :bongloy_js_url, :checkout_js_url, :publishable_key,
                :bongloy_charges_url,
                :bongloy_test_account_email, :bongloy_test_account_password,
                :image_url, :charge_description,
                :load_checkout

  delegate :first_name, :first_name?, :email, :to => :user, :prefix => true, :allow_nil => true

  def sample_expiry_date
    Time.now.strftime("%m / %y")
  end

  def charge_description
    @charge_description || "Charge from #{name}"
  end

  def image_url
    @image_url || ENV["BONGLOY_CHECKOUT_DEFAULT_IMAGE_URL"]
  end

  def publishable_key
    @publishable_key || ENV["BONGLOY_DEFAULT_PUBLISHABLE_KEY"]
  end

  def checkout_js_url
    @checkout_js_url || ENV["BONGLOY_CHECKOUT_DEFAULT_JS_URL"]
  end

  def bongloy_js_url
    @bongloy_js_url || ENV["BONGLOY_DEFAULT_JS_URL"]
  end

  def bongloy_charges_url
    @bongloy_charges_url || ENV["BONGLOY_CHARGES_URL"]
  end

  def bongloy_test_account_email
    @bongloy_test_account_email ||= ENV["BONGLOY_TEST_ACCOUNT_EMAIL"]
  end

  def bongloy_test_account_password
    @bongloy_test_account_password ||= ENV["BONGLOY_TEST_ACCOUNT_PASSWORD"]
  end

  def load_checkout
    @load_checkout.to_s == "1" ? "1" : "0"
  end

  def checkout_url_options
    {
      :amount_cents => amount_cents,
      :currency => currency,
      :name => name,
      :description => description,
      :label => label,
      :load_checkout => "1"
    }
  end

  def qr_code(url)
    RQRCode::QRCode.new(url)
  end

  def set_defaults
    self.name ||= (user_first_name? ? "#{user_first_name}'s Shop" : ENV["BONGLOY_CHECKOUT_DEFAULT_NAME"])
    self.description ||= ENV["BONGLOY_CHECKOUT_DEFAULT_DESCRIPTION"]
    self.product_description ||= ENV["BONGLOY_CHECKOUT_DEFAULT_PRODUCT_DESCRIPTION"]
    self.label ||= ENV["BONGLOY_CHECKOUT_DEFAULT_LABEL"]
    self.amount_cents ||= ENV["BONGLOY_CHECKOUT_DEFAULT_AMOUNT"].to_i
    self.currency ||= ENV["BONGLOY_CHECKOUT_DEFAULT_CURRENCY"].to_s.upcase.presence || DEFAULT_CURRENCY
  end
end
