require 'board'
require 'messages'
require 'ai'
require 'human'

class Round
  attr_reader :human, :ai, :io

  def initialize(input_output)
    @io = input_output
    @board = Board.new
    @message = Messages.new(@io)
    @ai = nil
    @human = nil
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
    @board.create(3)
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
