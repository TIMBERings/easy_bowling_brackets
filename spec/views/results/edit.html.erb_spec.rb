require 'rails_helper'

RSpec.describe "results/edit", type: :view do
  before(:each) do
    @result = assign(:result, Result.create!(
      :bracket => nil,
      :results => ""
    ))
  end

  it "renders the edit result form" do
    render

    assert_select "form[action=?][method=?]", result_path(@result), "post" do

      assert_select "input#result_bracket_id[name=?]", "result[bracket_id]"

      assert_select "input#result_results[name=?]", "result[results]"
    end
  end
end
