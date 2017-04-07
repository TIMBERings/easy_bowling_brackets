require 'rails_helper'

RSpec.describe "BracketGroups", type: :request do
  describe "GET /bracket_groups" do
    it "works! (now write some real specs)" do
      get bracket_groups_path
      expect(response).to have_http_status(200)
    end
  end
end
