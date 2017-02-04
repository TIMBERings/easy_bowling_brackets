require 'rails_helper'

RSpec.describe "brackets/show", type: :view do
  before(:each) do
    @bracket = assign(:bracket, Bracket.create!(
      :event => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
