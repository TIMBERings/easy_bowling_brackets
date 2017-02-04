require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :name => "MyString",
      :user => nil,
      :winner_cut => "9.99",
      :runner_up_cut => "9.99",
      :organizer_cut => "9.99",
      :entry_cost => "9.99"
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_name[name=?]", "event[name]"

      assert_select "input#event_user_id[name=?]", "event[user_id]"

      assert_select "input#event_winner_cut[name=?]", "event[winner_cut]"

      assert_select "input#event_runner_up_cut[name=?]", "event[runner_up_cut]"

      assert_select "input#event_organizer_cut[name=?]", "event[organizer_cut]"

      assert_select "input#event_entry_cost[name=?]", "event[entry_cost]"
    end
  end
end
