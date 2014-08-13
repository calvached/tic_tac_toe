class Board
  attr_accessor :gameboard
  attr_reader :io

  MESSAGES = {
    'invalid' => 'Invalid selection. Please try again.'
    }

  def initialize(grid_size, input_output)
    @io = input_output
    @grid_size = grid_size
    @gameboard = {}
  end

  def display
    # need to puts onto the screen
    @gameboard
  end

  def create
    (grid_spaces).each { |space| @gameboard[space] = '' }
  end

  def grid_spaces
    (1..(@grid_size**2))
  end

  def place_game_piece(position, game_piece)
    if @gameboard[position].empty?
      fill_space(position, game_piece)
    else
      @io.out(MESSAGES['invalid'])
    end
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end
end
