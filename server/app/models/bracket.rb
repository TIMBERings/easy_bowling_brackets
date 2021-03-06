class Bracket < ActiveRecord::Base
  belongs_to :bracket_group
  has_and_belongs_to_many :bowlers

  validates :bracket_group, presence: true
end
