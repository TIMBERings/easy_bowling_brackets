FactoryGirl.define do
  factory :bowler do
    name { Faker::Name.name }
    paid 0.0
    rejected_count 0
    entries 4
    average { rand 120..230 }
    starting_lane { rand 1..24 }
  end
end
