class HardAI
  attr_reader :game_piece, :name, :board

  def initialize(game_piece, board, rules)
    @game_piece = game_piece
    @board = board
    @rules = rules
    @name = 'GladOS'
  end

  def make_move(depth = 0, scores = {})
    return 0 if @rules.draw?
    return -1 if @rules.game_over?

    #space = @board.next_available_cell
    @board.available_cells.each do |cell|
      @board.place_game_piece(cell, @rules.player_piece)
      scores[cell] = -1 * make_move(depth + 1, {})
      @board.reset(cell)
    end

    depth == 0 ? best_move_from(scores) : highest_from(scores)
  end

  def best_move_from(scores)
    scores.max_by {|key, value| value}[0]
  end

  def highest_from(scores)
    scores.max_by {|key, value| value}[1]
  end
end

# Need to figure out a way to send a method as a parameter
# @io.prompt()

# if @rules.current_player == @player_one
# then do stuff
# else
# end

  # MINIMAX
  # Until game_over? place game pieces on the board
  # Search through all available_cells and place the current_player gamepiece
  # Keep track of a score for each outcome
  # if ai player wins then + 10
  # if human wins then - 10
  # if draw game then + 0

  # Start by creating recursive method that places a
  # gamepiece on the next available position
