class Round
  attr_reader :message

  def initialize(board, ui_messages, input_output)
    @board = board
    @message = ui_messages
    @io = input_output
  end

  def start_game
    @message.welcome
    @message.player_options

  end
end

# if place_game_piece
    # successful move
# else
    # Need to try again. Invalid move
