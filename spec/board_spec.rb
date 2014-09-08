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

  describe '#game_over?' do
    it 'finishes a round if winning combination is found' do
      allow(board).to receive(:is_full?).and_return(false)
      allow(board).to receive(:winner?).and_return(true)

      expect(board.game_over?).to eq(true)
    end

    it 'finishes a round if board is completely full' do
      allow(board).to receive(:is_full?).and_return(true)
      allow(board).to receive(:winner?).and_return(false)

      expect(board.game_over?).to eq(true)
    end

    it 'continues the game if no winner and board incomplete' do
      allow(board).to receive(:is_full?).and_return(false)
      allow(board).to receive(:winner?).and_return(false)

      expect(board.game_over?).to eq(false)
    end
  end

  describe '#draw?' do
    it 'declares a draw if board is full and no winner' do
      allow(board).to receive(:is_full?).and_return(true)
      allow(board).to receive(:winner?).and_return(false)

      expect(board.draw?).to eq(true)
    end

    it 'is not a draw if there is a winner' do
      allow(board).to receive(:is_full?).and_return(true)
      allow(board).to receive(:winner?).and_return(true)

      expect(board.draw?).to eq(false)
    end

    it 'is not a draw if the board is not full' do
      allow(board).to receive(:is_full?).and_return(false)
      allow(board).to receive(:winner?).and_return(true)

      expect(board.draw?).to eq(false)
    end

    it 'is not a draw if the board is not full' do
      allow(board).to receive(:is_full?).and_return(false)
      allow(board).to receive(:winner?).and_return(false)

      expect(board.draw?).to eq(false)
    end
  end

  describe '#occupied_cells' do
    it 'returns the number of cells occupied' do
      board.place_game_piece('4', 'x')
      board.place_game_piece('5', 'o')

      expect(board.occupied_cells).to eq(2)
    end
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
