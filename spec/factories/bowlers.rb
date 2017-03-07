FactoryGirl.define do
  factory :bowler do
    name { Faker::Name.name }
    paid 0.0
    rejected_count 0
    entries 0
  end
end
