class Round
  attr_reader :message, :o_player, :x_player

  def initialize(board, ui_messages, input_output, ai, player)
    @board = board
    @message = ui_messages
    @io = input_output
    @ai = ai
    @player = player
    @o_player = nil
    @x_player = nil
  end

  def start_game
    @message.welcome
    @message.player_options

    user_input = @io.in

    case user_input
    when '1'
      @message.how_to_play
    when '2'
      play
    when '3'
      @message.player_options
    else
      @message.invalid_option
    end
  end

  def play
    @board.create
    random_select_players
    assign_game_pieces

    p @board.gameboard
    @board.place_game_piece(1, 'x')
    p @board.gameboard
  end

  def random_select_players
    @o_player, @x_player = [@ai, @player].shuffle
  end

  def assign_game_pieces
    @o_player.game_piece = 'O'
    @x_player.game_piece = 'X'
  end
end

# if place_game_piece
    # successful move
# else
    # Need to try again. Invalid move
