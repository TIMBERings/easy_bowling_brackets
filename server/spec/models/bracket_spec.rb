require 'rails_helper'

RSpec.describe Bracket, type: :model do
  let(:bracket) { FactoryGirl.create(:bracket) }
  describe 'validations' do
    it 'requires bracket_group to be present' do
      bracket.bracket_group = nil
      expect(bracket.valid?).to eq false
      expect(bracket.errors.messages[:bracket_group]).to include "can't be blank"
    end
  end
end
