FactoryGirl.define do
  factory :event do
    name "MyString"
    event_date "2017-02-04"
    user nil
    winner_cut "9.99"
    runner_up_cut "9.99"
    organizer_cut "9.99"
    entry_cost "9.99"
  end
end
