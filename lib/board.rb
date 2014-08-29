class Board
  attr_accessor :gameboard
  attr_reader :io

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

  def winner?
    # need to find look for a winning combo in row, column, and diagonal
  end

  def get_rows
    @gameboard.values.each_slice(3).to_a
  end

  def get_columns
    get_rows.transpose
  end

  def get_diagonals
    [left_diagonal, right_diagonal]
  end

  def left_diagonal
    (0..get_rows.length - 1).collect { |i| get_rows[i][i] }
  end

  def right_diagonal
    index = get_rows.length

    (0..get_rows.length - 1).collect do |i|
      index -= 1
      get_rows[i][index]
    end
  end

  def occupied_cells
    @gameboard.reduce(0) { |counter, pair| empty_cell?(pair) ? counter + 1 : counter }
  end

  private
  def create_grid_cells(board_size)
    ('1'.."#{board_size**2}").to_a
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end

  def empty_cell?(pair)
    !pair.last.empty?
  end

  # Need to add winning pattern check
end
