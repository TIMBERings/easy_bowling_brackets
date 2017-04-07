class Entry < ActiveRecord::Base
  belongs_to :bracket_group
  belongs_to :bowler

  validates :starting_lane,     numericality: { only_integer: true }, allow_nil: true
  validates :paid,              presence: true
  validates :rejected_count,    presence: true, numericality: { only_integer: true }
  validates :average,           numericality: true, allow_nil: true
  validates :entry_count,       presence: true, numericality: { only_integer: true }
  validates :bowler_id,         presence: true
  validates :bracket_group_id,  presence: true
end
