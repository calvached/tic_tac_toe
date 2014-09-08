require 'messages'

class Round
  attr_reader :human, :ai, :io, :configurations, :board
  attr_accessor :game_settings

  def initialize(configurations, input_output)
    @io = input_output
    @configurations = configurations
  end

  def start_game
    @io.out(Messages::WELCOME)
    @game_settings = @configurations.setup

    menu['options'].call
    player_selections
  end

  def menu
    {
      '1' => Proc.new{@io.out(Messages::HOW_TO_PLAY)},
      '2' => Proc.new{play},
      '3' => Proc.new{@io.out(Messages::QUIT)},
      'options' => Proc.new{@io.out(Messages::PLAYER_OPTIONS)}
    }
  end

  def player_selections
    user_input = @io.input

    if user_input == '3'
      menu['3'].call
    elsif menu[user_input]
      menu[user_input].call
      menu['options'].call
      player_selections
    else
      @io.out(Messages::INVALID_OPTION)
      menu['options'].call
      player_selections
    end

  end

  def play
    until board.game_over?
      @io.out(Messages.print_header(current_player))
      print_board

      unless board.place_game_piece(player_move, game_piece)
        @io.out(Messages::INVALID_MOVE)
      end
    end

    print_board
    round_outcome
  end

  def player_move
    current_player.make_move
  end

  def game_piece
    current_player.game_piece
  end

  def print_board
    @io.out(formatted_rows.join(horizontal_line) + "\n")
  end

  def horizontal_line
    "----" * board.dimensions + "\n"
  end

  def formatted_rows
    rows = []

    board.gameboard.values.each_slice(board.dimensions) do |row|
      rows << Messages.prettify_row(row)
    end
    rows
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

  def round_outcome
    if board.draw?
      @io.out(Messages::DRAW)
    else
      @io.out(Messages.print_round_win(declared_winner))
    end
  end

  def declared_winner
    board.occupied_cells.odd? ? player_one : player_two
  end
end
