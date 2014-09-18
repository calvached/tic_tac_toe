require 'messages'
require 'human'
require 'easy_ai'
require 'hard_ai'
require 'board'
require 'game_rules'

class Configurations
  attr_reader :io, :settings

  HUMAN_OPTION = 'H'
  EASY_AI_OPTION = 'EC'
  HARD_AI_OPTION = 'HC'
  GAME_PIECE_CHOICES = ['X', 'O', '$', '%', '&', '*', '@', '#', '?']

  def initialize(input_output)
    @io = input_output
    @settings = {}
  end

  def setup
    create_board
    create_players
    create_rules
  end

  private
  def create_board
    board_size = @io.prompt(Messages::ASK_FOR_BOARD_SIZE, 'regex', digit?)

    @settings[:board] = Board.new.create(board_size)
  end

  def create_rules
    @settings[:rules] = GameRules
  end

  def create_players
    challenger_1 = determine_challenger
    challenger_2 = determine_challenger(challenger_1.game_piece)

    @settings[:player_one], @settings[:player_two] = shuffle_order(challenger_1, challenger_2)
  end

  # create menu
  def determine_challenger(opponent_piece = ' ')
    @io.out(Messages::ASK_FOR_GAME_TYPE)
    user_input = @io.input

    if user_input.upcase == HUMAN_OPTION
      create_human(opponent_piece)
    elsif user_input.upcase == EASY_AI_OPTION
      create_easy_ai(opponent_piece)
    elsif user_input.upcase == HARD_AI_OPTION
      create_hard_ai(opponent_piece)
    else
      @io.out(Messages::INVALID_RESPONSE)
      determine_challenger(opponent_piece)
    end
  end

  def create_human(opponent_piece)
    name = get_name
    game_piece = get_game_piece(opponent_piece)

    Human.new(game_piece, name, @io)
  end

  def get_name
    @io.prompt(Messages::ASK_FOR_NAME, 'regex', word_char_only)
  end

  def get_game_piece(opponent_piece)
    game_piece = @io.prompt(Messages::ASK_FOR_GAMEPIECE, 'regex', special_char_only)

    while game_piece == opponent_piece
      @io.out(Messages::TAKEN_GAME_PIECE)
      game_piece = @io.prompt(Messages::ASK_FOR_GAMEPIECE, 'regex', special_char_only)
    end

    game_piece
  end

  def create_easy_ai(opponent_piece)
    piece = assign_game_piece(opponent_piece)
    EasyAI.new(piece, @settings[:board])
  end

  public
  def create_hard_ai(opponent_piece)
    piece = assign_game_piece(opponent_piece)
    HardAI.new(piece, @settings[:board], GameRules)
  end

  private
  def assign_game_piece(opponent_piece)
     piece = select_piece

     while piece == opponent_piece
       piece = select_piece
     end

     piece
  end

  def select_piece
    GAME_PIECE_CHOICES.shift
  end

  def shuffle_order(contestant_1, contestant_2)
    [contestant_1, contestant_2].shuffle
  end

  def digit?
    /\d/
  end

  # maybe create a validation class
  def special_char_only
    /[XO$%&*@#?]/
  end

  def word_char_only
    /\w/
  end
end
