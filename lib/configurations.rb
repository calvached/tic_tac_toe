require 'messages'
require 'board'
require 'human'
require 'easy_ai'
require 'hard_ai'
require 'game_rules'

class Configurations
  attr_reader :io

  HUMAN_OPTION = 'H'
  EASY_AI_OPTION = 'EA'
  HARD_AI_OPTION = 'HA'

  def initialize(input_output)
    @board = Board.new
    @rules = GameRules.new
    @io = input_output
  end

  def setup
    create_board
    create_players
    setup_rules

    settings
  end

  private
  def settings
    { player_one: @player_one, player_two: @player_two, board: @board, rules: @rules }
  end

  def create_players
    human = create_human
    challenger = determine_challenger
    # need to make sure challenger does not choose the same gamepiece as human

    shuffle_order(challenger, human)
  end

  def setup_rules
    @rules.setup(@player_one, @player_two, @board)
  end

  def create_human
    name = @io.prompt(Messages::ASK_FOR_NAME, 'regex', word_char_only)
    game_piece = @io.prompt(Messages::ASK_FOR_GAMEPIECE, 'regex', special_char_only)

    Human.new(game_piece, name, @io)
  end

  def special_char_only
    /[O$%&*@#?]/
  end

  def word_char_only
    /\w/
  end

  def determine_challenger
    @io.out(Messages::ASK_FOR_GAME_TYPE)
    user_input = @io.input

    if user_input.upcase == HUMAN_OPTION
      create_human
    elsif user_input.upcase == EASY_AI_OPTION
      create_easy_ai
    elsif user_input.upcase == HARD_AI_OPTION
      create_hard_ai
    else
      @io.out(Messages::INVALID_RESPONSE)
      determine_challenger
    end
  end

  def create_easy_ai
    EasyAI.new('X', @board)
  end

  def create_hard_ai
    HardAI.new('X', @board, @rules)
  end

  def create_board
    @io.out(Messages::ASK_FOR_BOARD_SIZE)
    get_board_size
  end

  def shuffle_order(contestant_1, contestant_2)
    @player_one, @player_two = [contestant_1, contestant_2].shuffle
  end

  def get_board_size
    board_size = @io.input

    if board_size =~ digit?
      @board.create(board_size.to_i)
    else
      @io.out(Messages::INVALID_RESPONSE)
      get_board_size
    end
  end

  def digit?
    /\d/
  end
end
