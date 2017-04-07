FactoryGirl.define do
  factory :bowler do
    name { Faker::Name.name }

    trait :with_usbc_id do
      usbc_id { "#{rand(1000..9999)}-#{rand(10000..99999)}" }
    end
  end
end
