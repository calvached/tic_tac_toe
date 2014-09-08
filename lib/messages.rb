class Messages

  WELCOME = "###########################\n" +
    "#                         #\n" +
    "# Welcome to Tic Tac Toe! #\n" +
    "#                         #\n" +
    "###########################\n\n"

  PLAYER_OPTIONS = "\nPlease make a selection from the following: \n" +
    "1. How to Play\n" +
    "2. Play Game\n" +
    "3. Quit\n"

  HOW_TO_PLAY = "\n###############\n" +
    "# How to Play #\n" +
    "###############\n" +
    "Each player is assigned a game piece after which\n" +
    "each will take turns placing a piece on the board.\n" +
    "The objective of the game is to fill in three of a kind in\n" +
    "a row, column, or diagonal. The first to accomplish this wins the game.\n" +
    "If neither player is declared a winner then the game ends in a draw.\n" +
    "\n" +
    "In order to place a game piece on the board you must select a number from 1-9.\n" +
    " 1 | 2 | 3 \n" +
    "-----------\n" +
    " 4 | 5 | 6 \n" +
    "-----------\n" +
    " 7 | 8 | 9 \n"

  INVALID_OPTION = "Invalid selection."

  QUIT = 'Goodbye...'

  INVALID_RESPONSE = 'Please input a valid response.'

  ASK_FOR_BOARD_SIZE = "Please input the gameboard size (e.g. '3' for 3x3): "

  MAKE_MOVE = "Please select a cell on the board: "

  INVALID_MOVE= "That space is already taken. Please choose again."

  ASK_FOR_GAME_TYPE = "Would you like to play against a human or AI? Enter 'H' for Human and 'A' for AI"

  ASK_FOR_NAME = 'What is your name? (Use only letters and numbers)'

  ASK_FOR_GAMEPIECE = "Please choose a game piece from the following: 'O, $, %, &, *, @, #, ?'"

  DRAW = "DRAW!"

  def self.prettify_row(row)
    " " + row.join(' | ') + "\n"
  end

  def self.print_header(player)
    "#{player.name.capitalize}'s Turn. Your game piece is: #{player.game_piece}"
  end

  def self.print_round_win(winner)
    "#{winner.name.capitalize} has won!!!"
  end
end
