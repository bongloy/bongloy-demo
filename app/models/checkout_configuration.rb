class CheckoutConfiguration
  attr_accessor :checkout_js_url, :publishable_key, :image_url, :name, :description, :label, :amount

  def checkout_js_url
    @checkout_js_url || rails_secret(:bongloy_checkout_default_js_url)
  end

  def publishable_key
    @publishable_key || rails_secret(:bongloy_default_publishable_key)
  end

  def image_url
    @image_url || rails_secret(:bongloy_checkout_default_image_url)
  end

  def name
    @name || rails_secret(:bongloy_checkout_default_name)
  end

  def description
    @description || rails_secret(:bongloy_checkout_default_description)
  end

  def label
    @label || rails_secret(:bongloy_checkout_default_label)
  end

  def amount
    @amount || rails_secret(:bongloy_checkout_default_amount)
  end

  private

  def rails_secret(key)
    p Rails.application.secrets
    p key
    Rails.application.secrets[key]
  end
end
