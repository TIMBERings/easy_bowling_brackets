require 'rails_helper'

RSpec.describe Bowler, type: :model do
  let(:bowler) { FactoryGirl.create(:bowler) }

  describe 'validations' do
    it 'requires name to be present' do
      bowler.name = nil
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:name]).to include "can't be blank"
    end

    it 'requires paid to be present' do
      bowler.paid = nil
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:paid]).to include "can't be blank"
    end

    it 'requires entries to be present' do
      bowler.entries = nil
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:entries]).to include "can't be blank"
    end

    it 'requires rejected_count to be present' do
      bowler.rejected_count = nil
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:rejected_count]).to include "can't be blank"
    end

    it 'requires starting_lane to be an integer' do
      bowler.starting_lane = '1.1'
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:starting_lane]).to include "must be an integer"
    end

    it 'requires rejected_count to be an integer' do
      bowler.rejected_count = 1.1
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:rejected_count]).to include "must be an integer"
    end

    it 'requires average to be a number' do
      bowler.average = 'a'
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:average]).to include "is not a number"
    end

    it 'requires paid to be a number' do
      bowler.paid = nil
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:paid]).to include "is not a number"
    end

    it 'requires entries to be an integer' do
      bowler.entries = 1.1
      expect(bowler.valid?).to eq false
      expect(bowler.errors.messages[:entries]).to include "must be an integer"
    end

  end

  it 'defaults paid to 0.0' do
    bowler = Bowler.create(name: 'test')
    expect(bowler.paid).to eq 0.0
  end

  it 'defaults rejected_count to 0' do
    bowler = Bowler.create(name: 'test')
    expect(bowler.rejected_count).to eq 0
  end
end
