require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryGirl.create(:event) }
  describe 'validations' do
    it 'ensures name is present' do
      event.name = nil
      expect(event.valid?).to eq false
      expect(event.errors.messages[:name]).to include "can't be blank"
    end

    it 'ensures a user is present' do
      event.user = nil
      expect(event.valid?).to eq false
      expect(event.errors.messages[:user]).to include "can't be blank"
    end

    it 'ensures winner_cut is present' do
      event.winner_cut = nil
      expect(event.valid?).to eq false
      expect(event.errors.messages[:winner_cut]).to include "can't be blank"
    end

    it 'ensures runner_up_cut is present' do
      event.runner_up_cut = nil
      expect(event.valid?).to eq false
      expect(event.errors.messages[:runner_up_cut]).to include "can't be blank"
    end

    it 'ensures organizer_cut is present' do
      event.organizer_cut = nil
      expect(event.valid?).to eq false
      expect(event.errors.messages[:organizer_cut]).to include "can't be blank"
    end

    it 'ensures entry_cost is present' do
      event.entry_cost = nil
      expect(event.valid?).to eq false
      expect(event.errors.messages[:entry_cost]).to include "can't be blank"
    end

    it 'ensures winner_cut is a number' do
      bad_value = 'a'
      event.winner_cut = bad_value
      expect { event.valid? }.to raise_error ArgumentError, "invalid value for BigDecimal(): \"#{bad_value}\""
    end

    it 'ensures runner_up_cut is a number' do
      bad_value = 'a'
      event.runner_up_cut = bad_value
      expect { event.valid? }.to raise_error ArgumentError, "invalid value for BigDecimal(): \"#{bad_value}\""
    end

    it 'ensures organizer_cut is a number' do
      bad_value = 'a'
      event.organizer_cut = bad_value
      expect { event.valid? }.to raise_error ArgumentError, "invalid value for BigDecimal(): \"#{bad_value}\""
    end

    it 'ensures entry_cost is a number' do
      bad_value = 'a'
      event.entry_cost = bad_value
      expect { event.valid? }.to raise_error ArgumentError, "invalid value for BigDecimal(): \"#{bad_value}\""
    end
  end

  describe '#ensure_date_format' do
    it 'converts a string to a date' do
      event.update_attribute(:event_date, 'June 30, 2017')
      event.send(:ensure_date_format)
      expect(event.event_date).to eq Date.new(2017, 6, 30)

    end

    it 'converts a date time into a date' do
      event.update_attribute(:event_date, DateTime.new(2017,6,30,3,45,42))
      event.send(:ensure_date_format)
      expect(event.event_date).to eq Date.new(2017, 6, 30)

    end

    it 'raises an error if the date cannot be converted' do
      event.event_date = 'Hello'
      expect { event.send(:ensure_date_format) }.to raise_error StandardError, "#{event.event_date} could not be coerced into a date."

      event.event_date = 3
      expect { event.send(:ensure_date_format) }.to raise_error StandardError, "#{event.event_date} could not be coerced into a date."

      event.event_date = nil
      expect { event.send(:ensure_date_format) }.to raise_error StandardError, "#{event.event_date} could not be coerced into a date."
    end

    it 'remains a date if given a date' do
      event.update_attribute(:event_date, Date.new(2017,6,30))
      event.send(:ensure_date_format)
      expect(event.event_date).to eq Date.new(2017, 6, 30)
    end
  end
end
