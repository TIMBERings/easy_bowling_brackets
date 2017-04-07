json.extract! event, :id, :name, :event_date, :user_id, :winner_cut, :runner_up_cut, :organizer_cut, :entry_cost, :created_at, :updated_at
json.url event_url(event, format: :json)