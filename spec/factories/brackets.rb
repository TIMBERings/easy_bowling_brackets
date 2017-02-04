FactoryGirl.define do
  factory :bracket do
    event

    results {
      {
        first_round: [
          { game: 1, winner: 1, loser: 8},
          { game: 2, winner: 7, loser: 2},
          { game: 3, winner: 6, loser: 3},
          { game: 4, winner: 4, loser: 5}
        ],
        second_round: [
          { game: 5, winner: 1, loser: 7 },
          { game: 6, winner: 6, loser: 4 }
        ],
        third_round: [
          { game: 7, winner: 6, loser: 1 }
        ]
      }.to_json
    }

    after(:build) do |b|
      8.times {
        FactoryGirl.create(:bowler, brackets: [b])
      }

      b.seeds = {
        seeds: [
          { seed: 1, bowler: b.bowlers[0] },
          { seed: 2, bowler: b.bowlers[1] },
          { seed: 3, bowler: b.bowlers[2] },
          { seed: 4, bowler: b.bowlers[3] },
          { seed: 5, bowler: b.bowlers[4] },
          { seed: 6, bowler: b.bowlers[5] },
          { seed: 7, bowler: b.bowlers[6] },
          { seed: 8, bowler: b.bowlers[7] }
        ]
      }.to_json
      b.save
    end
  end
end
