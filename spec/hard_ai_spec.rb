require 'simplecov'
SimpleCov.start

require 'hard_ai'
require 'board'
require 'input_output'
require 'round'
require 'configurations'

describe HardAI do
  let (:rules) { GameRules.new }
  let (:board) { Board.new }
  let (:hard_ai) { HardAI.new('X', board, rules) }
  let (:mock) { MockIO.new }
  let (:config) { Configurations.new(mock) }
  let (:round) { Round.new(config, mock) }
  let (:human) { Human.new('O', 'diana', mock) }

  describe '#make_move' do
    context 'player one' do
      it 'makes the best move for a higher chance of winning' do
        allow(hard_ai.board).to receive(:available_cells).and_return(
          ['1', '5', '6', '8', '9'])

        #hard_ai.board.gameboard = {
        #  '1' => ' ', '2' => 'X', '3' => 'O',
        #  '4' => 'O', '5' => ' ', '6' => ' ',
        #  '7' => 'X', '8' => ' ', '9' => ' '
        #}
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('8')
      end

      it 'chooses a win over a block' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => 'X', '3' => ' ',
          '4' => 'O', '5' => 'X', '6' => 'O',
          '7' => ' ', '8' => ' ', '9' => 'X'
        }
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('8')
      end

      it 'chooses the winning move' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => 'O', '3' => 'X',
          '4' => ' ', '5' => 'X', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('7')
      end

      it 'blocks the opponent from winning' do
        hard_ai.board.gameboard = {
          '1' => 'X', '2' => 'X', '3' => 'O',
          '4' => ' ', '5' => 'O', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('7')
      end
    end

    context 'player two' do
      it 'chooses the cell in the middle if top right cell occupied' do
        hard_ai.board.gameboard = {
          '1' => ' ', '2' => ' ', '3' => 'O',
          '4' => ' ', '5' => ' ', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('5')
      end

      it 'chooses the cell in the middle if bottom left cell occupied' do
        hard_ai.board.gameboard = {
          '1' => ' ', '2' => ' ', '3' => ' ',
          '4' => ' ', '5' => ' ', '6' => ' ',
          '7' => 'O', '8' => ' ', '9' => ' '
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('5')
      end

      it 'chooses the cell in the middle if top left cell occupied' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => ' ', '3' => ' ',
          '4' => ' ', '5' => ' ', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('5')
      end

      it 'chooses the cell in the middle if bottom right cell occupied' do
        hard_ai.board.gameboard = {
          '1' => ' ', '2' => ' ', '3' => ' ',
          '4' => ' ', '5' => ' ', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => 'O'
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('5')
      end

      it 'chooses a space in one of the corners' do
        hard_ai.board.gameboard = {
          '1' => ' ', '2' => ' ', '3' => ' ',
          '4' => ' ', '5' => 'O', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('1')
      end
    end
  end
end
