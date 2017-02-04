require 'rails_helper'

RSpec.describe "Bowlers", type: :request do
  describe "GET /bowlers" do
    it "works! (now write some real specs)" do
      get bowlers_path
      expect(response).to have_http_status(200)
    end
  end
end
