class Board
  attr_reader :gameboard

  def initialize
    @gameboard = {
      '1' => '', '2' => '', '3' => '',
      '4' => '', '5' => '', '6' => '',
      '7' => '', '8' => '', '9' => '' }
  end

  def place_game_piece(position, game_piece)
    if @gameboard[position].empty?
      fill_space(position, game_piece)
    else
      puts 'Invalid selection. Please try again'
    end
  end

  def fill_space(position, game_piece)
    @gameboard[position] = game_piece
  end
end
