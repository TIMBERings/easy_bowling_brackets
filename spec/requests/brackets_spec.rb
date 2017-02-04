require 'rails_helper'

RSpec.describe "Brackets", type: :request do
  describe "GET /brackets" do
    it "works! (now write some real specs)" do
      get brackets_path
      expect(response).to have_http_status(200)
    end
  end
end
