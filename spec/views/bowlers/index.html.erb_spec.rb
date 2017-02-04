require 'rails_helper'

RSpec.describe "bowlers/index", type: :view do
  before(:each) do
    assign(:bowlers, [
      Bowler.create!(
        :name => "Name",
        :starting_lane => 2,
        :paid => "9.99",
        :rejected => false
      ),
      Bowler.create!(
        :name => "Name",
        :starting_lane => 2,
        :paid => "9.99",
        :rejected => false
      )
    ])
  end

  it "renders a list of bowlers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
