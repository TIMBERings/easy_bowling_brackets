  require 'rails_helper'

  describe CreateBracketsIntention do
    let(:bowlers) do
      [
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 1},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 2},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 3},
        {name: 'Aaron Humerickhouse', average: 208, entries: 8, paid: true, starting_lane: 4},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 5},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 6},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 7},
        {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true, starting_lane: 8}
      ]
    end
    let(:bracket_group) { FactoryGirl.create(:bracket_group) }
    let(:cbi) { CreateBracketsIntention.new(bracket_group, bowlers)}

    describe '#initialize' do
      context 'when there are not enough bowlers provided' do
        let(:bowlers) do
          [
            {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
            {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
            {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
            {name: 'Aaron Humerickhouse', average: 208, entries: 8, paid: true},
            {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
            {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true},
            {name: Faker::Name.name, average: rand(150..250), entries: 1, paid: true}
          ]
        end

        it 'raises an error if there aren\'t at least 8 bowlers' do
          expect { cbi }.to raise_error StandardError, 'Not enough bowlers provided. Please ensure there are at least 8 bowlers.'
        end
      end
    end

    describe '#generate_brackets' do
      it 'generates bowlers' do
        expect { cbi.generate_brackets }.to change { Bowler.count }.by 8
      end

      it 'generates brackets' do
        expect { cbi.generate_brackets }.to change { Bracket.count }.by 1
      end

      it 'rejects unbalanced bowlers' do
        cbi.generate_brackets
        expect(Bowler.find_by(name: 'Aaron Humerickhouse').rejected_count).to eq 7
      end
    end

    describe '#sort_bowlers' do
      let(:bowlers) do
        [
          { id: 1, entries: 8, entries_left: 7 },
          { id: 2, entries: 8, entries_left: 3 },
          { id: 3, entries: 8, entries_left: 2 },
          { id: 4, entries: 8, entries_left: 4 },
          { id: 5, entries: 8, entries_left: 8 },
          { id: 6, entries: 4, entries_left: 4 },
          { id: 7, entries: 4, entries_left: 2 },
          { id: 8, entries: 4, entries_left: 3 }
        ]
      end
      before(:each) do
        cbi.instance_variable_set("@bowlers", bowlers)
      end

      it 'sorts by desc entries_left then ascending entries' do
        expect(cbi.send(:sort_bowlers)).to eq [
          { id: 5, entries: 8, entries_left: 8 },
          { id: 1, entries: 8, entries_left: 7 },
          { id: 6, entries: 4, entries_left: 4 },
          { id: 4, entries: 8, entries_left: 4 },
          { id: 8, entries: 4, entries_left: 3 },
          { id: 2, entries: 8, entries_left: 3 },
          { id: 7, entries: 4, entries_left: 2 },
          { id: 3, entries: 8, entries_left: 2 }
        ]
      end
    end

    describe '#create_bowlers' do
      it 'returns creates the bowlers' do
        expect { cbi.send(:create_bowlers) }.to change { Bowler.count }.by 8
      end

      it 'returns an array of bowlers' do
        returned_bowlers = cbi.send(:create_bowlers)

        returned_bowlers.each {|bowler|
          bowler.is_a? Bowler
        }
      end
    end

    describe '#create_bracket' do
      let(:bowlers) do
        [
          { id: FactoryGirl.create(:bowler).id, entries: 8, entries_left: 7 },
          { id: FactoryGirl.create(:bowler).id, entries: 8, entries_left: 3 },
          { id: FactoryGirl.create(:bowler).id, entries: 8, entries_left: 2 },
          { id: FactoryGirl.create(:bowler).id, entries: 8, entries_left: 4 },
          { id: FactoryGirl.create(:bowler).id, entries: 8, entries_left: 8 },
          { id: FactoryGirl.create(:bowler).id, entries: 4, entries_left: 4 },
          { id: FactoryGirl.create(:bowler).id, entries: 4, entries_left: 2 },
          { id: FactoryGirl.create(:bowler).id, entries: 4, entries_left: 3 }
        ]
      end

      before(:each) do
        cbi.instance_variable_set("@bowlers", bowlers)
      end

      it 'decements the entries left' do
        returned_bowlers = cbi.send(:create_bracket, bowlers)
        returned_bowlers.sort_by! { |b| b[:id] }

        expect(returned_bowlers[0][:entries_left]).to eq 6
        expect(returned_bowlers[1][:entries_left]).to eq 2
        expect(returned_bowlers[2][:entries_left]).to eq 1
        expect(returned_bowlers[3][:entries_left]).to eq 3
        expect(returned_bowlers[4][:entries_left]).to eq 7
        expect(returned_bowlers[5][:entries_left]).to eq 3
        expect(returned_bowlers[6][:entries_left]).to eq 1
        expect(returned_bowlers[7][:entries_left]).to eq 2
      end

      it 'creates a bracket with seeds' do
        expect { cbi.send(:create_bracket, bowlers) }.to change{bracket_group.brackets.count}.by 1

        bowler_ids = JSON.parse(Bracket.last.seeds).map { |seed| seed['bowler_id'] }
        expect(bowler_ids).to include bowlers[0][:id]
        expect(bowler_ids).to include bowlers[1][:id]
        expect(bowler_ids).to include bowlers[2][:id]
        expect(bowler_ids).to include bowlers[3][:id]
        expect(bowler_ids).to include bowlers[4][:id]
        expect(bowler_ids).to include bowlers[5][:id]
        expect(bowler_ids).to include bowlers[6][:id]
        expect(bowler_ids).to include bowlers[7][:id]
      end

      it 'assigns the bowlers to the bracket' do
        cbi.send(:create_bracket, bowlers)

        bracket_bowlers = bracket_group.brackets.first.bowlers

        expect(bracket_bowlers.count).to eq 8
        expect(bracket_bowlers).to include Bowler.find(bowlers[0][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[1][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[2][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[3][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[4][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[5][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[6][:id])
        expect(bracket_bowlers).to include Bowler.find(bowlers[7][:id])
      end
    end

    describe '#add_rejections' do
      let(:bowlers) do
        [
          { id: FactoryGirl.create(:bowler).id, entries: 8, entries_left: 7 },
          { id: FactoryGirl.create(:bowler).id, entries: 4, entries_left: 3 },
          { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 0 },
          { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 0 },
          { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 0 },
          { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 0 },
          { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 0 },
          { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 0 }
        ]
      end
      before(:each) do
        cbi.instance_variable_set("@bowlers", bowlers)
      end

      it 'populates a bolwers rejection count with the number of entriels left' do
        cbi.send(:add_rejections)

        expect(Bowler.find(bowlers[0][:id]).rejected_count).to equal 7
        expect(Bowler.find(bowlers[1][:id]).rejected_count).to equal 3
        expect(Bowler.find(bowlers[2][:id]).rejected_count).to equal 0
        expect(Bowler.find(bowlers[3][:id]).rejected_count).to equal 0
        expect(Bowler.find(bowlers[4][:id]).rejected_count).to equal 0
        expect(Bowler.find(bowlers[5][:id]).rejected_count).to equal 0
        expect(Bowler.find(bowlers[6][:id]).rejected_count).to equal 0
        expect(Bowler.find(bowlers[7][:id]).rejected_count).to equal 0
      end
    end

    describe `#create_brackets` do
      before(:each) do
        cbi.instance_variable_set("@bowlers", bowlers)
      end

      context 'not enough for a single bracket' do
        let(:bowlers) do
          [
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 0, entries_left: 0 }
          ]
        end

        it 'raises an error' do
          expect { cbi.send(:create_brackets) }.to raise_error StandardError, "There are not enough bowlers with an entry."
        end
      end

      context 'enough for 1 bracket' do
        let(:bowlers) do
          [
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 0, entries_left: 0 }
          ]
        end

        it 'creates one bracket' do
          cbi.send(:create_brackets)

          expect(bracket_group.brackets.count).to eq 1
        end

        it 'does not include bowlers with 0 entries' do
          cbi.send(:create_brackets)

          expect(Bowler.find(bowlers.last[:id]).brackets.count).to eq 0
        end
      end

      context 'enough for multiple brackets' do
        let(:bowlers) do
          [
            { id: FactoryGirl.create(:bowler).id, entries: 3, entries_left: 3 },
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 2, entries_left: 2 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 },
            { id: FactoryGirl.create(:bowler).id, entries: 1, entries_left: 1 }
          ]
        end

        it 'creates multiple brackets' do
          cbi.send(:create_brackets)

          expect(bracket_group.brackets.count).to eq 2
        end

        it 'rejects the proper bowler' do
          cbi.send(:create_brackets)

          expect(Bowler.find(bowlers[0][:id]).rejected_count).to eq 1
        end
      end
    end
  end
