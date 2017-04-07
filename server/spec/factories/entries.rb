FactoryGirl.define do
  factory :entry do
    paid 0.0
    rejected_count 0
    entry_count 4
    average { rand 120..230 }
    starting_lane { rand 1..24 }
    bowler
    bracket_group
  end
end
