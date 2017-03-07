class Bowler < ApplicationRecord
  has_and_belongs_to_many :brackets

  validates :name,           presence: true
  validates :starting_lane,  numericality: { only_integer: true }, allow_nil: true
  validates :paid,           presence: true, numericality: true
  validates :rejected_count, presence: true, numericality: { only_integer: true }
  validates :average,        numericality: true, allow_nil: true
  validates :entries,        presence: true, numericality: { only_integer: true }
end
