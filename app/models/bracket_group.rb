class BracketGroup < ApplicationRecord
  belongs_to :event
  has_many :brackets



  def generate_brackets(bowlers_object)
    raise 'Not enough bowlers provided.' if bowlers_object[:bowlers].count < 8
  end

  private

  def bowlers_format
  end
end
