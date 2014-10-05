class ChargesGrid
  include Datagrid

  scope do
    Charge.all
  end

  filter(:id, :integer)
  filter(:created_at, :date, :range => true)

  column(:bongloy_charge_id)
  column(:currency)
  column(:amount)
  column(:created_at) do |model|
    model.created_at.to_date
  end
end
