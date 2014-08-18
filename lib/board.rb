class Board
  attr_accessor :gameboard
  attr_reader :io

  def initialize(grid_size)
    @grid_size = grid_size
    @gameboard = {}
  end

  def create
    (grid_cells).each { |cell| @gameboard[cell] = '' }
  end

  def place_game_piece(position, game_piece)
    fill_space(position, game_piece) if @gameboard[position].empty?
  end

  def is_full?
    !@gameboard.any? { |cell| cell[1].empty? }
  end

  private
  def grid_cells
    (1..(@grid_size**2))
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end

  # Need to add winning pattern check
end
