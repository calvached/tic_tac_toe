class GameRules

  def self.game_over?(board)
    board.is_full? || winner?
  end

  def draw?
    @board.is_full? && !winner?
  end

  def player_piece
    current_player.game_piece
  end

  def winner?
    possible_combinations.each do |combo_set|
      return true if combo_set.uniq.length == 1 && !combo_set.include?(' ')
    end

    false
  end

  def winning_piece
    declared_winner.game_piece
  end

  def valid_entry?(move)
    move.to_i <= @board.gameboard.size ? true : false
  end

  def declared_winner(board, player_one, player_two)
    board.even_occupied_cells? ? player_two : player_one
  end

  def current_player(board, player_one, player_two)
    board.even_occupied_cells? ? player_one : player_two
  end

  private
  def possible_combinations
    @board.get_rows + @board.get_columns + @board.get_diagonals
  end
end
