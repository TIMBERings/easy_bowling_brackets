require 'rails_helper'

RSpec.describe "results/new", type: :view do
  before(:each) do
    assign(:result, Result.new(
      :bracket => nil,
      :results => ""
    ))
  end

  it "renders new result form" do
    render

    assert_select "form[action=?][method=?]", results_path, "post" do

      assert_select "input#result_bracket_id[name=?]", "result[bracket_id]"

      assert_select "input#result_results[name=?]", "result[results]"
    end
  end
end
