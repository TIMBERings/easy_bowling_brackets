require 'rails_helper'

RSpec.describe "Bowlers", type: :request do
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:valid_params) do
    {
       name: 'Scooby Doo',
       usbc_id: '1234-5432'
    }
  end

  let(:invalid_params) do
    {
       name: nil,
       usbc_id: '1234-5432'
    }
  end

  describe "GET /api/v1/bowlers" do
    context 'when there are bowlers' do
      it "returns all of the bowlers" do
        FactoryGirl.create_list(:bowler, 10)

        get api_v1_bowlers_path, headers: headers
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body.count).to eq Bowler.count
        body.each do |bowler|
          expect(Bowler.all).to include Bowler.new(bowler)
        end
      end
    end

    context 'when there are no bowlers' do
      it 'returns an empty array' do
        get api_v1_bowlers_path, headers: headers
        expect(response).to have_http_status(200)

        body = JSON.parse(response.body)
        expect(body).to be_empty
      end
    end
  end

  describe 'GET /api/v1/bowlers/:id' do
    let(:bowler) { FactoryGirl.create(:bowler) }
    context 'when the resource is found' do
      it 'returns the proper bowler based on id' do
        get api_v1_bowler_path(bowler.id), headers: headers

        expect(response).to have_http_status(200)
        expect(bowler).to eq Bowler.new.from_json(response.body)
      end
    end

    context 'when the resource is not found' do
      it 'returns a 404' do
        get api_v1_bowler_path(bowler.id + 1000), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PATCH /api/v1/bowlers/:id' do
    let!(:bowler) { FactoryGirl.create(:bowler, :with_usbc_id) }
    let(:partial_valid_params) do
      {
         name: 'Scooby Doo'
      }
    end

    let(:partial_invalid_params) do
      {
         name: nil
      }
    end

    context 'with invalid params' do
      it 'responds with unprocessable_entity' do
        patch api_v1_bowler_path(bowler, bowler: partial_invalid_params), headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid params' do
      it 'updates the correct bowler' do
        initial_attributes = bowler.attributes
        patch api_v1_bowler_path(bowler, bowler: partial_valid_params), headers: headers
        expect(Bowler.last.attributes.except('created_at', 'updated_at')).to eq({
          'id' => initial_attributes['id'],
          'name' => partial_valid_params[:name],
          'usbc_id' => initial_attributes['usbc_id']
        })
      end

      it 'responds with success' do
        patch api_v1_bowler_path(bowler, bowler: partial_valid_params), headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the resource is not found' do
      it 'returns not_found' do
        patch api_v1_bowler_path(id: Bowler.last.id + 100000000000, bowler: partial_valid_params), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /api/v1/bowlers/:id' do
    let!(:bowler) { FactoryGirl.create(:bowler) }

    context 'with invalid params' do
      it 'responds with unprocessable_entity' do
        put api_v1_bowler_path(bowler, bowler: invalid_params), headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid params' do
      it 'updates the correct bowler' do
        put api_v1_bowler_path(bowler, bowler: valid_params), headers: headers
        expect(Bowler.last.attributes.except('id', 'created_at', 'updated_at')).to eq Bowler.new(valid_params).attributes.except('id', 'created_at', 'updated_at')
      end

      it 'responds with success' do
        put api_v1_bowler_path(bowler, bowler: valid_params), headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the resource is not found' do
      it 'returns not_found' do
        put api_v1_bowler_path(id: Bowler.last.id + 100000000000, bowler: valid_params), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /api/v1/bowlers/:id' do
    let(:bowler) { FactoryGirl.create(:bowler) }
    context 'when the resource is found' do
      it 'deletes the bowler' do
        id = bowler.id
        delete api_v1_bowler_path(id), headers: headers
        expect(response).to have_http_status(:no_content)
        expect { Bowler.find(id) }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the resource is not found' do
      it 'returns a 404' do
        delete api_v1_bowler_path(100000000000), headers: headers
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/brackets/:id/bowlers' do
    let(:bracket) { FactoryGirl.create(:bracket) }

    context 'with invalid params' do
      it 'responds with unprocessable_entity' do
        post api_v1_bracket_bowlers_path(bracket_id: bracket.id, bowler: invalid_params), headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with valid params' do
      it 'creates the bowler' do
        post api_v1_bracket_bowlers_path(bracket_id: bracket.id, bowler: valid_params), headers: headers
        expect(Bowler.last.brackets.last).to eq bracket
        expect(Bowler.last.attributes.except('id', 'created_at', 'updated_at')).to eq Bowler.new(valid_params).attributes.except('id', 'created_at', 'updated_at')
      end

      it 'responds with created' do
        post api_v1_bracket_bowlers_path(bracket_id: bracket.id, bowler: valid_params), headers: headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with an invalid bracket' do
      it 'responds with not_found' do
        bracket
        post api_v1_bracket_bowlers_path(bracket_id: Bracket.last.id + 10000, bowler: valid_params), headers: headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
