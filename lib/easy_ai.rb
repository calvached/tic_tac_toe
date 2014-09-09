class EasyAI
  attr_reader :game_piece, :name

  def initialize(game_piece, board)
    @game_piece = game_piece
    @board = board
    @name = 'HAL9000'
  end

  def make_move
    "#{rand(@board.gameboard.size) + 1}"
  end
end
