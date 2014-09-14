require 'simplecov'
SimpleCov.start

require 'board'
require 'input_output'

describe Board do
  let (:board) { Board.new }

  before(:example) do
    board.create(3)
  end

  describe '#place_game_piece' do
    it 'fills space in available positions only' do
      board.place_game_piece('4', 'x')
      board.place_game_piece('4', 'o')

      expect(board.gameboard['4']).to eq('x')
    end
  end

  describe '#is_full?' do
  end

  describe '#winner?' do
  end

  describe '#available_cells' do
    it 'returns the keys to all available cells' do
      board.gameboard = {
        '1' => 'X', '2' => 'O', '3' => ' ',
        '4' => 'X', '5' => ' ', '6' => ' ',
        '7' => ' ', '8' => ' ', '9' => 'O'
      }

      expect(board.available_cells).to eq(['3', '5', '6', '7', '8'])
    end
  end

  describe '#dimensions' do
    it 'returns the board dimensions' do
      expect(board.dimensions).to eq(3.0)
    end
  end
end
