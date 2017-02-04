FactoryGirl.define do
  factory :event do
    name { Faker::StarWars.character }
    event_date { Date.today }
    user

    after(:build) do |e|
      e.entry_cost = [3.00, 5.00].sample

      e.winner_cut = e.entry_cost * 5
      e.runner_up_cut = e.entry_cost * 2
      e.organizer_cut = e.entry_cost
    end
  end
end
