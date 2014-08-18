require 'board'
require 'messages'
require 'ai'
require 'human'

class Round
  attr_reader :human, :ai, :io

  def initialize(board, input_output)
    @io = input_output
    @board = board
    @message = Messages.new(@io)
    @ai = nil
    @human = nil
  end

  def start_game
    @message.welcome
    @message.player_options

    player_selections
  end

  def player_selections
    user_input = @io.in

    case user_input
    when '1'
      @message.how_to_play
      player_selections
    when '2'
      play
    when '3'
      @message.player_options
      player_selections
    else
      @message.invalid_option
      player_selections
    end
  end

  def play
    @message.ask_for_board_size
    create_players if get_board_size
  end

  def get_board_size
    board_size = @io.in

    if board_size =~ /\d/
      @board.create(board_size.to_i)
    else
      @message.invalid_character
      get_board_size
    end
  end

  def create_players
    create_human_player
    create_ai_player
  end

  def create_human_player
    @human = Human.new('O', @io)
  end

  def create_ai_player
    @ai = AI.new('X')
  end
end

# if place_game_piece
    # successful move
# else
    # Need to try again. Invalid move
