require 'rails_helper'

RSpec.describe Bowler, type: :model do
  let(:bowler) { FactoryGirl.create(:bowler) }

  describe 'validations' do
    it 'requires name to be present' do
      bowler.name = nil
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:name]).to include "can't be blank"
    end
  end
end
