class AI
  attr_reader :game_piece, :name

  def initialize(game_piece)
    @game_piece = game_piece
    @name = 'HAL9000'
  end

  def make_move
    "#{rand(9) + 1}"
  end
end
