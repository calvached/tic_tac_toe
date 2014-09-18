require 'messages'
require 'human'
require 'easy_ai'
require 'hard_ai'

class Configurations
  attr_reader :io

  HUMAN_OPTION = 'H'
  EASY_AI_OPTION = 'EC'
  HARD_AI_OPTION = 'HC'
  GAME_PIECE_CHOICES = ['X', 'O', '$', '%', '&', '*', '@', '#', '?']

  def initialize(board, rules, input_output)
    @board = board
    @rules = rules
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
    challenger_1 = determine_challenger
    challenger_2 = determine_challenger(challenger_1.game_piece)

    shuffle_order(challenger_1, challenger_2)
  end

  def setup_rules
    @rules.setup(@player_one, @player_two, @board)
  end

  def special_char_only
    /[XO$%&*@#?]/
  end

  def word_char_only
    /\w/
  end

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
    EasyAI.new(piece, @board)
  end

  def create_hard_ai(opponent_piece)
    piece = assign_game_piece(opponent_piece)
    HardAI.new(piece, @board, @rules)
  end

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
