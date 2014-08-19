class Board
  attr_accessor :gameboard

  def initialize
    @gameboard = {}
  end

  def create(board_size)
    (create_grid_cells(board_size)).each { |cell| @gameboard[cell] = '' }
  end

  def place_game_piece(position, game_piece)
    fill_space(position, game_piece) if @gameboard[position].empty?
  end

  def is_full?
    !@gameboard.any? { |cell| cell[1].empty? }
  end

  private
  def create_grid_cells(board_size)
    (1..(board_size**2))
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end

  # Need to add winning pattern check
end
