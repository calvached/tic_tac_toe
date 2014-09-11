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

  describe '#next_available_cell' do
    it 'returns the next empty cell' do
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => ' ',
          '4' => 'X', '5' => ' ', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => 'O'
        }

      expect(board.next_available_cell).to eq('3')
    end

    it 'returns the next empty cell' do
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => 'O',
          '4' => 'X', '5' => 'O', '6' => 'X',
          '7' => 'O', '8' => 'X', '9' => ' '
        }

      expect(board.next_available_cell).to eq('9')
    end

    xit 'in progress' do
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => 'X',
          '4' => 'X', '5' => 'O', '6' => 'X',
          '7' => 'O', '8' => 'X', '9' => 'O'
        }

      expect(board.next_available_cell).to eq('')
    end
  end

  describe '#dimensions' do
    it 'returns the board dimensions' do
      expect(board.dimensions).to eq(3.0)
    end
  end
end
