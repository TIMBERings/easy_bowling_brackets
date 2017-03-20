require 'rails_helper'

RSpec.describe "Bowlers", type: :request do
  before(:each) do
    10.times { FactoryGirl.create(:bowler) }
  end

  describe "GET /bowlers" do
    it "returns all of the bowlers" do
      get bowlers_path, format: :json
      expect(response).to have_http_status(200)
      binding.pry
      expect(response.body)
    end
  end
end
