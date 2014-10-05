class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string  :bongloy_charge_id, :null => false
      t.string  :bongloy_customer_id, :null => false
      t.integer :amount, :null => false
      t.string  :currency, :null => false, :limit => 3
      t.references :user, :null => false
      t.timestamps
    end
  end
end
