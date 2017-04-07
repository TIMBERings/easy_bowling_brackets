class BracketGroup < ApplicationRecord

  belongs_to :event
  has_many :brackets
  has_many :entries

  validates :name, presence: true

  def generate_brackets(bowlers)
    GenerateBracketsIntention.new(self, bowlers).generate_brackets
  end
end
