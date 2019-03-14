require 'rails_helper'

RSpec.describe "tax/vehicles/show", type: :view do
  before(:each) do
    @tax_vehicle = assign(:tax_vehicle, Tax::Vehicle.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Plate Number/)
    expect(rendered).to match(/Brand/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/Engine Number/)
    expect(rendered).to match(/Year/)
    expect(rendered).to match(/Power/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/En Name/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Birth Date/)
    expect(rendered).to match(/Id Number/)
    expect(rendered).to match(/Home/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/Vilage/)
    expect(rendered).to match(/Commune/)
    expect(rendered).to match(/District/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Reference Number/)
  end
end
