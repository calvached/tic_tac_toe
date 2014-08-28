require 'board'
require 'messages'
require 'ai'
require 'human'

class Round
  attr_reader :human, :ai, :io, :configurations, :board
  attr_accessor :game_settings

  def initialize(configurations, input_output)
    @io = input_output
    @configurations = configurations
  end

  def menu
    {
      '1' => Proc.new{@io.out(Messages::HOW_TO_PLAY)},
      '2' => Proc.new{play},
      '3' => Proc.new{@io.out(Messages::PLAYER_OPTIONS)},
      '4' => Proc.new{@io.out(Messages::QUIT)}
    }
  end

  def start_game
    @io.out(Messages::WELCOME)
    @game_settings = @configurations.setup

    menu['3'].call
    player_selections
  end

  def player_selections
    user_input = @io.input

    if user_input == '4'
      menu['4'].call
    elsif menu[user_input]
      menu[user_input].call
      player_selections
    else
      @io.out(Messages::INVALID_OPTION)
      player_selections
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

  def game_over?
    board.is_full? || board.winner?
  end
end

# if place_game_piece
    # successful move
# else
    # Need to try again. Invalid move
