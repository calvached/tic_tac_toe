class Board
  attr_accessor :gameboard

  def initialize
    @gameboard = {}
  end

  def create(board_size)
    (create_grid_cells(board_size)).each { |cell| @gameboard[cell] = ' ' }
  end

  def place_game_piece(position, game_piece)
    fill_space(position, game_piece) if @gameboard[position] == ' '
  end

  def even_occupied_cells?
    occupied_cells.even?
  end

  def available_cells
    @gameboard.select { |key, value| value == ' '}.keys
  end

  def is_full?
    !@gameboard.values.any? { |cell| cell == ' ' }
  end

  def dimensions
    Math.sqrt(@gameboard.length)
  end

  def reset(cell)
    @gameboard[cell] = ' '
  end

  def get_rows
    @gameboard.values.each_slice(dimensions).to_a
  end

  def get_columns
    get_rows.transpose
  end

  def get_diagonals
    [left_diagonal, right_diagonal]
  end

  private
  def occupied_cells
    @gameboard.reduce(0) do |counter, pair|
      filled_cell?(pair) ? counter + 1 : counter
    end
  end

  def left_diagonal
    (0..get_rows.length - 1).collect { |i| get_rows[i][i] }
  end

  def right_diagonal
    cell_index = get_rows.length

    (0..get_rows.length - 1).collect do |i|
      cell_index -= 1
      get_rows[i][cell_index]
    end
  end

  def create_grid_cells(board_size)
    ('1'.."#{board_size**2}").to_a
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end

  def filled_cell?(pair)
    pair.last != ' '
  end
end
