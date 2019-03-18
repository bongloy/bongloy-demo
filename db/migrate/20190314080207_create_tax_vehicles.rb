class CreateTaxVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :tax_vehicles do |t|
      t.string :plate_number
      t.string :brand
      t.string :vehicle_type
      t.string :color
      t.string :engine_number
      t.string :year
      t.string :power
      t.string :name
      t.string :en_name
      t.string :gender
      t.date :birth_date
      t.string :id_number
      t.string :home
      t.string :street
      t.string :vilage
      t.string :commune
      t.string :district
      t.string :city
      t.string :email
      t.string :phone_number
      t.string :reference_number
      t.string :token

      t.timestamps
    end
  end
end
