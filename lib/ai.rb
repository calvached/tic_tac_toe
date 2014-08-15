class AI
  attr_accessor :game_piece

  def initialize
    @game_piece = nil
  end

  def make_move
    rand(9)
  end
end
