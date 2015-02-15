require 'rails_helper'
Beerclub
BeerclubsController
MembershipsController



describe "User" do

  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      #Rivikattavuuden toimintaa varten


      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end


  it "page shows ratings" do
    sign_in(username: "Pekka", password: "Foobar1")
    brewery = FactoryGirl.create :brewery, name:"Koff"
    FactoryGirl.create :style

    b1 = FactoryGirl.create :beer, name:"iso 3", brewery:brewery
    user = User.first
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"


    visit user_path(user)
    expect(page).to have_content 'Pekka Has 1 rating, average 15'
    expect(page).to have_content 'iso 3 15 Destroy '
  end

  it "removing ratings remove them drom db" do
    sign_in(username: "Pekka", password: "Foobar1")
    brewery = FactoryGirl.create :brewery, name:"Koff"
    FactoryGirl.create :style
    FactoryGirl.create :beer, name:"iso 3", brewery:brewery
    user = User.first
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"
    expect(Rating.all.count).to eq(1)
    click_link "Destroy"
    expect(Rating.all.count).to eq(0)
  end


  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect {
      click_button('Create User')
    }.to change { User.count }.by(1)
  end

end