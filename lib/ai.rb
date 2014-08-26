class AI
  attr_accessor :game_piece

  def initialize(game_piece)
    @game_piece = game_piece
  end

  def make_move
    "#{rand(9) + 1}"
  end
end
