class CheckoutConfiguration
  DEFAULT_CURRENCY = "USD"
  CURRENCIES = [DEFAULT_CURRENCY]

  DEFAULT_AMOUNT_CENTS = 1400

  DEFAULT_NAME="Demo Site"
  DEFAULT_DESCRIPTION="Shampoo (\$14.00)"
  DEFAULT_PRODUCT_DESCRIPTION="This shampoo has rich organic Argan oil which provides moisture and nutrition for severely damaged hair. Rosehip oil and Primrose oil give a glossy, tangle free finish."
  DEFAULT_LABEL="Buy"

  def sample_expiry_date
    1.month.from_now.strftime("%m / %y")
  end

  def charge_description
    "Charge from #{name}"
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
