class Board
  attr_accessor :gameboard
  attr_reader :io

  def initialize(grid_size, input_output)
    @io = input_output
    @grid_size = grid_size
    @gameboard = {}
  end

  def display
    @gameboard.values.each_slice(@grid_size) do |row|
      @io.out(" ____________")
      @io.out("| #{row[0]} | #{row[1]} | #{row[2]} |")
    end
  end

  def create
    (grid_cells).each { |cell| @gameboard[cell] = '_' }
  end

  def grid_cells
    (1..(@grid_size**2))
  end

  def place_game_piece(position, game_piece)
    if @gameboard[position] == '_'
      fill_space(position, game_piece)
    end
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end
end
