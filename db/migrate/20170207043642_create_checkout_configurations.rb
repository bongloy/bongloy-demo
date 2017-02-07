class CreateCheckoutConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :checkout_configurations do |t|
      t.references :user, :index => true, :foreign_key => true
      t.monetize :amount,
                 :amount => {:default => nil},
                 :currency => {:column_name => :currency, :default => nil}
      t.string :name, :null => false
      t.string :description, :null => false
      t.string :label, :null => false
      t.text   :product_description, :null => false
      t.timestamps
    end
  end
end
