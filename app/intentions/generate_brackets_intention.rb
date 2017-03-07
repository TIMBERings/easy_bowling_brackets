class GenerateBracketsIntention
  BRACKET_SIZE = 8

  def initialize(bracket_group, bowlers)
    @given_bowlers = bowlers
    @bowlers = nil
    @bracket_group = bracket_group

    raise "Not enough bowlers provided. Please ensure there are at least #{BRACKET_SIZE} bowlers." if @given_bowlers.count < BRACKET_SIZE
  end

  def generate_brackets
    create_bowlers
    create_brackets
  end

  private

  def create_bowlers
    @bowlers = @given_bowlers.dup.map do |bowler|
      {
        id: Bowler.create(name: bowler[:name],
                          average: bowler[:average],
                          entries: bowler[:entries],
                          paid: bowler[:paid],
                          starting_lane: bowler[:starting_lane]).id,
        entries: bowler[:entries],
        entries_left: bowler[:entries]
      }
    end
  end

  def create_brackets
    @bowlers = @bowlers.reject { |b| b[:entries] <  1 }
    raise "There are not enough bowlers with an entry." if @bowlers.count < BRACKET_SIZE

    while @bowlers.count >= BRACKET_SIZE do
      sort_bowlers

      #add bowlers to bracket and create
      create_bracket(@bowlers[0..BRACKET_SIZE-1])

      #remove bowlers with 0 entries left
      @bowlers.reject! { |b| b[:entries_left] == 0 }
    end

    add_rejections
  end

  def sort_bowlers
    #sort by entries left desc, then by number of entries asc
    @bowlers.sort! { |a, b| [b[:entries_left], a[:entries]] <=> [a[:entries_left], b[:entries]] }
  end

  def create_bracket(bowlers)
    raise "#{BRACKET_SIZE} bowlers needed to create a bracket" unless bowlers.count == BRACKET_SIZE
    bowlers.shuffle!

    seeds = []
    bowlers.each_with_index { |b, index| seeds << { seed: index + 1, bowler_id: b[:id] } }
    bracket = Bracket.create(bracket_group: @bracket_group, seeds: seeds.to_json)
    bowlers.each { |b| bracket.bowlers << Bowler.find(b[:id]) }

    # decrement # entries
    bowlers.each { |bowler|
      @bowlers.find { |b| b[:id] == bowler[:id] }[:entries_left] = bowler[:entries_left] - 1
    }
  end

  def add_rejections
    @bowlers.each do |bowler|
      Bowler.find(bowler[:id]).update_attributes(rejected_count: bowler[:entries_left])
    end
  end
end