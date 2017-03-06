FactoryGirl.define do
  factory :bowler do
    name { Faker::Name.name }
    average { rand(150..230) }
    entries { rand(2..8) }
    paid true
  end
end
