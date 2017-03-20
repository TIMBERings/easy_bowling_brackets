require 'rails_helper'

RSpec.describe "Bowlers", type: :request do
  before(:each) do
    FactoryGirl.create_list(:bowler, 10)
  end

  let(:headers) { { "ACCEPT" => "application/json" } }

  describe "GET /api/v1/bowlers" do
    it "returns all of the bowlers" do
      get api_v1_bowlers_path, {}, headers
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body.count).to eq Bowler.count
    end
  end

  describe 'Get /api/v1/bowlers/[:id]' do
    it 'returns the proper bowler based on id' do
      bowler = Bowler.first
      get api_v1_bowler_path(bowler.id), {}, headers

      expect(response).to have_http_status(200)
      expect(bowler).to eq Bowler.new.from_json(response.body)
    end
  end
end
