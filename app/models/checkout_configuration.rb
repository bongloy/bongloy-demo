class CheckoutConfiguration
  def sample_expiry_date
    1.month.from_now.strftime("%m / %y")
  end

  def publishable_key
    ENV.fetch("BONGLOY_DEFAULT_PUBLISHABLE_KEY")
  end
end
