class BracketGroup < ApplicationRecord

  belongs_to :event
  has_many :brackets

  def generate_brackets(bowlers)
    CreateBrackets.new(self, bowlers)
  end
end
