require 'input_output'

class Messages
  attr_reader :io

  def initialize(input_output)
    @io = input_output
  end

  def welcome
    @io.out('###########################')
    @io.out('# Welcome to Tic Tac Toe! #')
    @io.out('###########################')
  end

  def player_options
    @io.out('Please make a selection from the following: ')
    @io.out('1. How to Play')
    @io.out('2. Play Game')
    @io.out('3. Help')
  end

  def instructions
    @io.out('###############')
    @io.out('# How to Play #')
    @io.out('###############')
    @io.out("Each player is assigned a game piece of either 'O' or 'X'")
    @io.out("after which each will take turns placing a piece on the board.")
    @io.out("The objective of the game is to fill in three of a kind in")
    @io.out("a row, column, or diagonal. The first to accomplish this wins the game.")
    @io.out("If neither player is declared a winner then the game ends in a draw.")
  end

  def invalid_option
    @io.out('Invalid selection. Please try again.')
  end
end
