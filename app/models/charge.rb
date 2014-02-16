class Charge
  include ::ActiveModel::Validations
  include ::ActiveModel::Conversion
  extend ::ActiveModel::Naming

  def initialize(attributes = {})
  end

  def persisted?
    false
  end
end
