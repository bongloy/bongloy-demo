require 'rails_helper'

RSpec.describe "tax/vehicles/edit", type: :view do
  before(:each) do
    @tax_vehicle = assign(:tax_vehicle, Tax::Vehicle.create!(
      :plate_number => "MyString",
      :brand => "MyString",
      :type => "",
      :color => "MyString",
      :engine_number => "MyString",
      :year => "MyString",
      :power => "MyString",
      :name => "MyString",
      :en_name => "MyString",
      :gender => "MyString",
      :birth_date => "MyString",
      :id_number => "MyString",
      :home => "MyString",
      :street => "MyString",
      :vilage => "MyString",
      :commune => "MyString",
      :district => "MyString",
      :city => "MyString",
      :email => "MyString",
      :phone_number => "MyString",
      :reference_number => "MyString"
    ))
  end

  it "renders the edit tax_vehicle form" do
    render

    assert_select "form[action=?][method=?]", tax_vehicle_path(@tax_vehicle), "post" do

      assert_select "input[name=?]", "tax_vehicle[plate_number]"

      assert_select "input[name=?]", "tax_vehicle[brand]"

      assert_select "input[name=?]", "tax_vehicle[type]"

      assert_select "input[name=?]", "tax_vehicle[color]"

      assert_select "input[name=?]", "tax_vehicle[engine_number]"

      assert_select "input[name=?]", "tax_vehicle[year]"

      assert_select "input[name=?]", "tax_vehicle[power]"

      assert_select "input[name=?]", "tax_vehicle[name]"

      assert_select "input[name=?]", "tax_vehicle[en_name]"

      assert_select "input[name=?]", "tax_vehicle[gender]"

      assert_select "input[name=?]", "tax_vehicle[birth_date]"

      assert_select "input[name=?]", "tax_vehicle[id_number]"

      assert_select "input[name=?]", "tax_vehicle[home]"

      assert_select "input[name=?]", "tax_vehicle[street]"

      assert_select "input[name=?]", "tax_vehicle[vilage]"

      assert_select "input[name=?]", "tax_vehicle[commune]"

      assert_select "input[name=?]", "tax_vehicle[district]"

      assert_select "input[name=?]", "tax_vehicle[city]"

      assert_select "input[name=?]", "tax_vehicle[email]"

      assert_select "input[name=?]", "tax_vehicle[phone_number]"

      assert_select "input[name=?]", "tax_vehicle[reference_number]"
    end
  end
end
