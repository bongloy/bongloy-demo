class CheckoutConfiguration
  def sample_expiry_date
    1.month.from_now.strftime("%m / %y")
  end

  def publishable_key
    ENV.fetch("BONGLOY_DEFAULT_PUBLISHABLE_KEY")
  end

  def bongloy_test_account_email
    ENV.fetch("BONGLOY_TEST_ACCOUNT_EMAIL")
  end

  def bongloy_test_account_password
    ENV.fetch("BONGLOY_TEST_ACCOUNT_PASSWORD")
  end
end
