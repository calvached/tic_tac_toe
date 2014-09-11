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
      it 'returns a move that blocks the other player from winning' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => 'X', '3' => 'X',
          '4' => ' ', '5' => 'O', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('9')
      end

      xit 'chooses the best move' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => 'O', '3' => 'X',
          '4' => ' ', '5' => 'X', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('6')
      end

      xit '' do
        hard_ai.board.gameboard = {
          '1' => 'X', '2' => 'X', '3' => 'O',
          '4' => 'O', '5' => 'O', '6' => ' ',
          '7' => 'X', '8' => ' ', '9' => ' '
        }
        rules.setup(hard_ai, human, board)

        expect(hard_ai.make_move).to eq('6')
      end
    end

    context 'player two' do
      xit 'returns a move that blocks the other player from winning' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => 'X', '3' => 'X',
          '4' => 'O', '5' => ' ', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('7')
      end

      xit 'chooses the best move' do
        hard_ai.board.gameboard = {
          '1' => 'O', '2' => 'O', '3' => 'X',
          '4' => ' ', '5' => 'X', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        }
        rules.setup(human, hard_ai, board)

        expect(hard_ai.make_move).to eq('6')
      end
    end
  end
end
