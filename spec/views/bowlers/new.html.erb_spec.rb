require 'rails_helper'

RSpec.describe "bowlers/new", type: :view do
  before(:each) do
    assign(:bowler, Bowler.new(
      :name => "MyString",
      :starting_lane => 1,
      :paid => "9.99",
      :rejected => false
    ))
  end

  it "renders new bowler form" do
    render

    assert_select "form[action=?][method=?]", bowlers_path, "post" do

      assert_select "input#bowler_name[name=?]", "bowler[name]"

      assert_select "input#bowler_starting_lane[name=?]", "bowler[starting_lane]"

      assert_select "input#bowler_paid[name=?]", "bowler[paid]"

      assert_select "input#bowler_rejected[name=?]", "bowler[rejected]"
    end
  end
end
