class CheckoutConfiguration
  attr_accessor :checkout_js_url, :publishable_key, :image_url, :name, :description, :label, :amount, :user
  delegate :first_name, :first_name?, :to => :user, :allow_nil => true

  def initialize(options = {})
    self.user = options[:user]
    self.name = options[:name] || (first_name? ? "#{first_name}'s Shop" : rails_secret(:bongloy_checkout_default_name))
    self.description = options[:description] || rails_secret(:bongloy_checkout_default_description)
    self.image_url = options[:image_url] || rails_secret(:bongloy_checkout_default_image_url)
    self.publishable_key = options[:publishable_key] || rails_secret(:bongloy_default_publishable_key)
    self.checkout_js_url = options[:checkout_js_url] || rails_secret(:bongloy_checkout_default_js_url)
    self.label = options[:label] || rails_secret(:bongloy_checkout_default_label)
    self.amount = options[:amount] || rails_secret(:bongloy_checkout_default_amount)
  end

  private

  def rails_secret(key)
    Rails.application.secrets[key]
  end
end
