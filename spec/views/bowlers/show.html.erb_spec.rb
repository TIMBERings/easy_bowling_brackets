require 'rails_helper'

RSpec.describe "bowlers/show", type: :view do
  before(:each) do
    @bowler = assign(:bowler, Bowler.create!(
      :name => "Name",
      :starting_lane => 2,
      :paid => "9.99",
      :rejected => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/false/)
  end
end
