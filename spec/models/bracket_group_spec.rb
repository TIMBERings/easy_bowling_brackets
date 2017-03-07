require 'rails_helper'

RSpec.describe BracketGroup, type: :model do
  let(:event) { FactoryGirl.create(:event) }
  it 'requires a name' do
    bracket_group = BracketGroup.new(event: event)

    expect(bracket_group.save).to eq false
    expect(bracket_group.errors.messages).to eq({ name: ["can't be blank"] })
  end

  describe '#generate_brackets' do
    let(:bracket_group) { FactoryGirl.create(:bracket_group) }
    it 'calls GenerateBracketsIntention#generate_brackets' do
      expect_any_instance_of(GenerateBracketsIntention).to receive(:generate_brackets)
      bracket_group.generate_brackets [
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
        {name: 'Aaron Humerickhouse', average: 208, entries: 8, paid: true},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true}
      ]
    end
  end
end
