require 'messages'
require 'board'
require 'human'
require 'ai'

class Configurations
  attr_reader :io

  def initialize(input_output)
    @board = Board.new
    @io = input_output
  end

  def setup
    create_board
    create_players

    settings = { player_one: @player_one, player_two: @player_two, board: @board }
  end

  private
  def create_players
    @io.out(Messages::ASK_FOR_GAME_TYPE)
    shuffle_player_order(challenger, Human.new('O', @io))
  end

  def challenger
    user_input = @io.input

    if user_input == 'H'
      Human.new('X', @io)
    elsif user_input == 'A'
      AI.new('X')
    else
      @io.out(Messages::INVALID_RESPONSE)
      challenger
    end
  end

  def create_board
    @io.out(Messages::ASK_FOR_BOARD_SIZE)
    get_board_size
  end

  def shuffle_player_order(contestant_1, contestant_2)
    @player_one, @player_two = [contestant_1, contestant_2].shuffle
  end

  def get_board_size
    board_size = @io.input

    if board_size =~ /\d/
      @board.create(board_size.to_i)
    else
      @io.out(Messages::INVALID_RESPONSE)
      get_board_size
    end
  end
end

# Config = [Human, AI, Board]

#Round only cares about Human, AI and Board
#Configuration does the rest of the set up (board size, ai difficulty, player names, etc)
# Display message
# Get config.game_settings
# Save setting as value in hash
# will send instances of Board, Human, and AI back to Round
