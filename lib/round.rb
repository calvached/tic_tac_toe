require 'board'
require 'messages'
require 'ai'
require 'human'

class Round
  attr_reader :human, :ai, :io

  def menu_options
    [@message.board_prompt, @messages.werwae, @message.agszdgdszfg]
  end

  def initialize(board, input_output)
    @io = input_output
    @board = board
    @message = Messages.new(@io)
    @ai = nil
    @human = nil
  end

  MENU = {
  '1' => @messages.how_to_play,
  '2' => @messages.how_to_play,
}


  def configure_game
    @board_size_prompt
    @opponent_prompt
    @player_order_prompt
    @gamepiece_prompt
    @player_name_prompt

  end
{
  :board_size => [@messages.board_prompt, @validations.board_selection, setup_board],
  :board_size => [@messages.board_prompt, @validations.board_selection, setup_board],
  :board_size => [@messages.board_prompt, @validations.board_selection, setup_board],
  :board_size => [@messages.board_prompt, @validations.board_selection, setup_board],
}


  validations

  def gamepiece_validation
    are_you_a_lowercase_letter || are_you_an_uppercase_letter
  end

  end
  private
  def are_you_a_number
  def are you a lowercase letter

# prompt_message
# validations
# configuration

  def board_size_prompt


  end

  def display_menu
    # menu.keys.each |item|
      puts item
    end
  end

  def prompt_for_menu_option

    gets.chomp
    user_input = 1
    if MENU[user_input]
      MENU[user_input]
    else
      @message.invalid_selection
      prompt_for_menu_option
  end

  def start_game
    @message.welcome
    @message.player_options

    player_selections
  end

  def player_selections
    user_input = @io.in
# open for extension, closed for modification
    case user_input
    when '1'
      @message.how_to_play
      player_selections
    when '2'
      play
    when '3'
      @message.player_options
      player_selections
    when '4'
      @message.do_have_friends
      player_selections
    else
      @message.invalid_option
      player_selections
    end
  end

  def play
    @message.ask_for_board_size
    create_players if get_board_size

    # print board
    # ask current player for a move
    # check for win
      # if win or draw
      # print board
      # display game outcome
      # else
        # loop
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
