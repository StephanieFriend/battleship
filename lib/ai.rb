class Ai

  attr_reader :next_shot

  @possible_shots
  @target_board

  def initialize(target_board)
    @target_board = target_board
    @next_shot = @target_board.cells.keys.sample #no need to check if fired upon since this is literally the first shot the computer will take
    @possible_shots = []
  end

  def compute_next_shot(prevTarget, wasHit)
    if(@possible_shots.length == 0 && !wasHit)
      @next_shot = get_random_unshot_cell
    elsif (@possible_shots.length > 0 && !wasHit)
      @next_shot = @possible_shots.pop
    else
      new_possible_shots = get_targetable_surrounding_coords(prevTarget)
      #this makes the possible_shots array a FIFO queue
      #if we get a hit, keep shooting around it, if we get another hit, keep track of those, but keep shooting around the same original hit
      #
      # Could also argue using Array#push (making it a LIFO stack) here is better.  I tried both ways, this one seemed more "real"
      @possible_shots.unshift(new_possible_shots)
      @possible_shots.flatten!
      @next_shot = @possible_shots.pop
    end
  end

  def get_targetable_surrounding_coords(target_coord)
    surroundingCoords = []

    y, x = target_coord.match(/([A-Z]*)(\d*)/).captures
    [find_prev("A", y), y.next].each do |chr|
      if(chr != nil && @target_board.cells.keys.include?(chr + x) && !@target_board.cells[chr + x].fired_upon?)
        surroundingCoords << chr + x
      end
    end

    [find_prev("1", x), x.next].each do |chr|
      if(chr != nil && @target_board.cells.keys.include?(y + chr) && !@target_board.cells[y + chr].fired_upon?)
        surroundingCoords << y + chr
      end
    end
    return surroundingCoords
  end

  def find_prev(start, prev_of)
    current = start
    if (prev_of == "A" || prev_of == "1")
      return nil #no previous
    end

    loop do
      if(current.next == prev_of)
        return current
      end
      current = current.next
    end
  end

  def get_random_unshot_cell
    coordinate = ""
    loop do
      coordinate = @target_board.cells.keys.sample
      break if !@target_board.cells[coordinate].fired_upon?
    end
    return coordinate
  end

end
