class GameRules
  def initialize(player_one, player_two, board)
    @player_one = player_one
    @player_two = player_two
    @board = board
  end

  def game_over?
    @board.is_full? || @board.winner?
  end

  def draw?
    @board.is_full? && !@board.winner?
  end

  def current_player
    @board.even_occupied_cells? ? @player_one : @player_two
  end
end
