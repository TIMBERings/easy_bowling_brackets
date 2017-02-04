require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :name => "Name",
        :user => nil,
        :winner_cut => "9.99",
        :runner_up_cut => "9.99",
        :organizer_cut => "9.99",
        :entry_cost => "9.99"
      ),
      Event.create!(
        :name => "Name",
        :user => nil,
        :winner_cut => "9.99",
        :runner_up_cut => "9.99",
        :organizer_cut => "9.99",
        :entry_cost => "9.99"
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
