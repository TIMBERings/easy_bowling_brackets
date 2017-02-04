require 'rails_helper'

RSpec.describe "brackets/new", type: :view do
  before(:each) do
    assign(:bracket, Bracket.new(
      :event => nil
    ))
  end

  it "renders new bracket form" do
    render

    assert_select "form[action=?][method=?]", brackets_path, "post" do

      assert_select "input#bracket_event_id[name=?]", "bracket[event_id]"
    end
  end
end
