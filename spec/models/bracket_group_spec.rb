require 'rails_helper'

RSpec.describe BracketGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'generate_brackets' do
    let(:bracket_group) { FactoryGirl.create(:bracket_group) }
    let(:bowlers) do
     {
        bowlers: [
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
          {name: 'Aaron Humerickhouse', average: 208, entries: 8},
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
          {name: Faker::Name.name, average: rand(150..250), entries: 1},
        ]
      }
    end

    it 'raises an error if there aren\'t at least 8 bowlers' do
      expect { bracket_group.generate_brackets(bowlers) }.to raise_error StandardError, 'Not enough bowlers provided.'
    end

    it 'generates bowlers' do
      expect { bracket_group.generate_brackets(bowlers) }.to change { Bowler.count }.by 8
    end

    it 'generates brackets' do
      expect { bracket_group.generate_brackets(bowlers) }.to change { Bracket.count }.by 1
    end

    it 'rejects unbalanced bowlers' do
      bracket_group.generate_brackets(bowlers)
      expect(Bowler.find_by(name: 'Aaron Humerickhouse').rejected_count).to eq 7
    end
  end
end
