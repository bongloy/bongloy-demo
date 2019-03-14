require 'rails_helper'

RSpec.describe "tax/vehicles/index", type: :view do
  before(:each) do
    assign(:tax_vehicles, [
      Tax::Vehicle.create!(
        :plate_number => "Plate Number",
        :brand => "Brand",
        :type => "Type",
        :color => "Color",
        :engine_number => "Engine Number",
        :year => "Year",
        :power => "Power",
        :name => "Name",
        :en_name => "En Name",
        :gender => "Gender",
        :birth_date => "Birth Date",
        :id_number => "Id Number",
        :home => "Home",
        :street => "Street",
        :vilage => "Vilage",
        :commune => "Commune",
        :district => "District",
        :city => "City",
        :email => "Email",
        :phone_number => "Phone Number",
        :reference_number => "Reference Number"
      ),
      Tax::Vehicle.create!(
        :plate_number => "Plate Number",
        :brand => "Brand",
        :type => "Type",
        :color => "Color",
        :engine_number => "Engine Number",
        :year => "Year",
        :power => "Power",
        :name => "Name",
        :en_name => "En Name",
        :gender => "Gender",
        :birth_date => "Birth Date",
        :id_number => "Id Number",
        :home => "Home",
        :street => "Street",
        :vilage => "Vilage",
        :commune => "Commune",
        :district => "District",
        :city => "City",
        :email => "Email",
        :phone_number => "Phone Number",
        :reference_number => "Reference Number"
      )
    ])
  end

  it "renders a list of tax/vehicles" do
    render
    assert_select "tr>td", :text => "Plate Number".to_s, :count => 2
    assert_select "tr>td", :text => "Brand".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => "Engine Number".to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
    assert_select "tr>td", :text => "Power".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "En Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Birth Date".to_s, :count => 2
    assert_select "tr>td", :text => "Id Number".to_s, :count => 2
    assert_select "tr>td", :text => "Home".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Vilage".to_s, :count => 2
    assert_select "tr>td", :text => "Commune".to_s, :count => 2
    assert_select "tr>td", :text => "District".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    assert_select "tr>td", :text => "Reference Number".to_s, :count => 2
  end
end
