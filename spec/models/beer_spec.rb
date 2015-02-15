require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with proper name and style" do
    test = FactoryGirl.create :style
    beer = Beer.create(name:"Test", style: test)
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is NOT saved without proper name" do
    test = FactoryGirl.create :style
    beer = Beer.create(style: test)
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is NOT saved without proper style" do
    beer = Beer.create(name:"Test")
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
