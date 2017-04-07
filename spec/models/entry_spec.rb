require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:entry) { FactoryGirl.create(:entry) }

  describe 'validations' do
    it 'requires paid to be present' do
      entry.paid = nil
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:paid]).to include "can't be blank"
    end

    it 'requires entry_count to be present' do
      entry.entry_count = nil
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:entry_count]).to include "can't be blank"
    end

    it 'requires rejected_count to be present' do
      entry.rejected_count = nil
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:rejected_count]).to include "can't be blank"
    end

    it 'requires starting_lane to be an integer' do
      entry.starting_lane = '1.1'
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:starting_lane]).to include "must be an integer"
    end

    it 'requires rejected_count to be an integer' do
      entry.rejected_count = 1.1
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:rejected_count]).to include "must be an integer"
    end

    it 'requires average to be a number' do
      entry.average = 'a'
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:average]).to include "is not a number"
    end

    it 'requires entry_count to be an integer' do
      entry.entry_count = 1.1
      expect(entry.valid?).to eq false
      expect(entry.errors.messages[:entry_count]).to include "must be an integer"
    end
  end

  it 'defaults paid to false' do
    entry = Entry.create
    expect(entry.paid).to eq false
  end

  it 'defaults rejected_count to 0' do
    entry = Entry.create
    expect(entry.rejected_count).to eq 0
  end

  it 'defaults entry_count to 0' do
    entry = Entry.create
    expect(entry.entry_count).to eq 0
  end
end
