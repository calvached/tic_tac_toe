require 'board'
require 'messages'
require 'ai'
require 'human'

class Round
  attr_reader :human, :ai, :io

  def initialize(board, input_output)
    @io = input_output
    @board = board
    @ai = nil
    @human = nil
  end

  def menu
  {
    '1' => @io.out(Messages::HOW_TO_PLAY),
    '2' => play,
    '3' => @io.out(Messages::PLAYER_OPTIONS)
  }
  end

  def start_game
    @io.out(Messages::WELCOME)
    @io.out(Messages::PLAYER_OPTIONS)

    player_selections
  end

  def player_selections
    user_input = @io.in

    if menu.keys.include?(user_input)
      menu[user_input]
    else
      @io.out(Messages::INVALID_OPTION)
    end

  end

  def play
    @io.out(Messages::ASK_FOR_BOARD_SIZE)
    create_players if get_board_size
  end

  def get_board_size
    board_size = @io.in

    if board_size =~ /\d/
      @board.create(board_size.to_i)
    else
      @io.out(Messages::INVALID_CHARACTER)
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
