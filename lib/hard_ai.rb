class HardAI
  attr_reader :game_piece, :name, :board

  def initialize(game_piece, board, rules)
    @game_piece = game_piece
    @board = board
    @rules = rules
    @name = 'GLaDOS'
  end

  def make_move(scores = {}, depth = 0)
    return game_state_scoring(depth) if @rules.game_over? || reached_limit(depth)

    @board.available_cells.each do |cell|
      @board.place_game_piece(cell, @rules.player_piece)
      scores[cell] = make_move({}, depth + 1)
      @board.reset(cell)
    end

    depth == 0 ? best_move_from(scores) : best_score(depth, scores)
  end

  private
  def reached_limit(depth)
    depth == @board.dimensions * 2
  end

  def best_score(depth, scores)
    ai_turn?(depth) ? max_score_from(scores) : min_score_from(scores)
  end

  def max_score_from(scores)
    scores.max_by {|key, value| value}.last
  end

  def min_score_from(scores)
    scores.min_by {|key, value| value}.last
  end

  def ai_turn?(depth)
    depth.even?
  end

  def game_state_scoring(depth)
    if ai_wins
      10 - depth
    elsif opponent_wins
      depth - 10
    else
      0
    end
  end

  def ai_wins
    @rules.winner? && @rules.winning_piece == @game_piece
  end

  def opponent_wins
    @rules.winner?
  end

  def best_move_from(scores)
    scores.max_by {|key, value| value}.first
  end
end
