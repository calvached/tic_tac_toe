class Messages

  WELCOME = "###########################\n" +
    "#                         #\n" +
    "# Welcome to Tic Tac Toe! #\n" +
    "#                         #\n" +
    "###########################\n\n"

  PLAYER_OPTIONS = "\nPlease make a selection from the following: \n" +
    "1. How to Play\n" +
    "2. Play Game\n" +
    "3. Help\n" +
    "4. Quit\n"

  HOW_TO_PLAY = "\n###############\n" +
    "# How to Play #\n" +
    "###############\n" +
    "Each player is assigned a game piece of either 'O' or 'X'\n" +
    "after which each will take turns placing a piece on the board.\n" +
    "The objective of the game is to fill in three of a kind in\n" +
    "a row, column, or diagonal. The first to accomplish this wins the game.\n" +
    "If neither player is declared a winner then the game ends in a draw.\n"

  INVALID_OPTION = "Invalid selection. Please try again or press 3 for help."

  QUIT = 'Goodbye...'

  INVALID_RESPONSE = 'Please input a valid response.'

  ASK_FOR_BOARD_SIZE = "Please input the gameboard size (e.g. '3' for 3x3): "

  MAKE_MOVE = "Please select a cell on the board: "

  ASK_FOR_GAME_TYPE = "Would you like to play against a human or AI? Enter 'H' for Human and 'A' for AI"

  def self.prettify_board(row)
    row.join(' | ') + "\n" + "____" * row.length
  end
end
