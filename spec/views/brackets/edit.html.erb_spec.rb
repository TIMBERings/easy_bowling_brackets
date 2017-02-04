require 'rails_helper'

RSpec.describe "brackets/edit", type: :view do
  before(:each) do
    @bracket = assign(:bracket, Bracket.create!(
      :event => nil
    ))
  end

  it "renders the edit bracket form" do
    render

    assert_select "form[action=?][method=?]", bracket_path(@bracket), "post" do

      assert_select "input#bracket_event_id[name=?]", "bracket[event_id]"
    end
  end
end
