class BracketGroup < ApplicationRecord
  belongs_to :event
  has_many :brackets
end
