require 'rails_helper'

RSpec.describe "styles/index", type: :view do
  before(:each) do
    assign(:styles, [
      Style.create!(
        :name => "Name"
      ),
      Style.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of styles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
