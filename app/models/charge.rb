class Charge < ActiveRecord::Base
  attr_accessor :token

  belongs_to :user

  validates :bongloy_customer_id, :presence => true
  validates :bongloy_charge_id, :presence => true
  validates :amount, :currency, :presence => true

  before_validation :execute_charge, :on => :create

  private

  def execute_charge
    return if @bongloy_charge
    @bongloy_customer ||= create_bongloy_customer
    return unless @bongloy_customer
    @bongloy_charge ||= create_bongloy_charge
    return unless @bongloy_charge
    self.bongloy_customer_id = @bongloy_customer.id
    self.bongloy_charge_id = @bongloy_charge.id
    self.currency = @bongloy_charge.currency
    self.amount = @bongloy_charge.amount
  end

  def create_bongloy_charge
    charge = Bongloy::ApiResource::Charge.new
    charge.amount = amount
    charge.currency = currency
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
