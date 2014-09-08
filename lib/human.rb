class Human
  attr_reader :game_piece, :name

  def initialize(game_piece, name, input_output)
    @game_piece = game_piece
    @name = name
    @io = input_output
  end

  def make_move(board)
    response = @io.prompt(Messages::MAKE_MOVE, 'regex', /\d/)

    while response.to_i > board.gameboard.size
      @io.out(Messages::INVALID_RESPONSE)
      response = @io.prompt(Messages::MAKE_MOVE, 'regex', /\d/)
    end

    response
  end
end
