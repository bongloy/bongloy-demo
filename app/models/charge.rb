class Charge
  extend ActiveModel::Naming
  extend ActiveModel::Callbacks
  include ActiveModel::Model

  attr_accessor :token, :amount, :currency, :description

  validates :amount, :currency, :token, :presence => true

  def save
    return false unless valid?
    execute_charge
    errors.empty?
  end

  private

  def execute_charge
    return if @bongloy_charge
    @bongloy_customer ||= create_bongloy_customer
    return unless @bongloy_customer
    @bongloy_charge ||= create_bongloy_charge
  end

  def create_bongloy_charge
    charge = Bongloy::ApiResource::Charge.new
    charge.amount = amount
    charge.currency = currency
    charge.description = description
    charge.customer = @bongloy_customer.id
    execute_bongloy_transaction { charge.save! }
    charge if charge.id
  end

  def create_bongloy_customer
    customer = Bongloy::ApiResource::Customer.new
    customer.card = token
    execute_bongloy_transaction { customer.save! }
    customer if customer.id
  end

  def execute_bongloy_transaction(&block)
    begin
      yield
    rescue Bongloy::Error::Api::BaseError => e
      errors.add(:base, e.message)
    end
  end
end
