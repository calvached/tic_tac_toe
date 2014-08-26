require 'board'
require 'messages'
require 'ai'
require 'human'

class Round
  attr_reader :human, :ai, :io, :configurations, :board
  attr_accessor :game_settings

  def initialize(input_output, configurations)
    @io = input_output
    @configurations = configurations
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
    @game_settings = @configurations.setup
  end

  def player_one
    @game_settings[:player_one]
  end

  def player_two
    @game_settings[:player_two]
  end

  def board
    @game_settings[:board]
  end

  def current_player
    board.occupied_cells.even? ? player_one : player_two
  end

  def player_selections
    user_input = @io.in

    if menu[user_input]
      menu[user_input]
    else
      @io.out(Messages::INVALID_OPTION)
    end

  end

  def play
    #until game_over?
      successful_move = @io.prompt(Messages::MAKE_MOVE, 'regex', /\d/)
      @io.out(Messages.prettify_board(board))
      board.place_game_piece(successful_move, 'X')
    #end

    #mock out game_over? when testing loop
  end

  def game_over?
    board.full? || board.winner?
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
