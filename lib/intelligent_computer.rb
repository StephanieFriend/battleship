class IntelligentComputer
attr_reader :player_board,
            :stored_shot

  def initialize
    @player_board = Board.new
    @stored_shot = []
  end

  def add_shot(coordinate)
    @stored_shot << coordinate
  end
end
