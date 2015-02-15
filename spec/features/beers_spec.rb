require 'rails_helper'

describe "Beer" do
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
    @breweries = ["Koff", "Karjala", "Schlenkerla"]
    year = 1896
    @breweries.each do |brewery_name|
    FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
    end
  end
  it "with a proper name gets added" do
    visit new_beer_path
    fill_in('beer[name]', with: 'testikalja')
    expect {
      click_button('Create Beer')
    }.to change { Beer.count }.by(1)
  end

  it "without a proper name doesnt get added" do
    visit new_beer_path
    expect {
      click_button('Create Beer')
    }.to change { Beer.count }.by(0)

  end
end