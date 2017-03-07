class Event < ApplicationRecord
  belongs_to :user
  has_many :brackets

  validates :name, presence: true
  validates :user, presence: true
  validates :winner_cut, presence: true, numericality: true
  validates :runner_up_cut, presence: true, numericality: true
  validates :organizer_cut, presence: true, numericality: true
  validates :entry_cost, presence: true, numericality: true

  before_validation :ensure_date_format

  private

  def ensure_date_format
    return if event_date.is_a? Date
    raise StandardError unless event_date.is_a?(String) || event_date.is_a?(DateTime)
    self.event_date = Date.parse(event_date) if event_date.is_a? String
    self.event_date = event_date.to_date if event_date.is_a? DateTime
  rescue StandardError => ex
    raise StandardError, "#{event_date} could not be coerced into a date." unless event_date.is_a?(String) || event_date.is_a?(DateTime)
  end
end
