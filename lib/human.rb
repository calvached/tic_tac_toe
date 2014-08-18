class Human
  attr_accessor :game_piece

  def initialize(game_piece, input_output)
    @game_piece = game_piece
    @io = input_output
  end

  def make_move
    @io.in
  end
end
