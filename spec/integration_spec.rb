require 'simplecov'
SimpleCov.start

require 'round'
require 'configurations'
require 'input_output'
require 'easy_ai'
require 'hard_ai'
require 'human'
require 'board'
require 'messages'
require 'game_rules'

describe Round do
  let (:mock) { MockIO.new }
  let (:board) { Board.new }
  let (:round) { Round.new(Configurations.new(mock), mock) }
  let (:rules) { GameRules.new }
  let (:human) { Human.new('O', 'diana', mock) }
  let (:easy_ai) { EasyAI.new('X', board) }
  let (:hard_ai) { HardAI.new('X', board, rules) }
  let (:game_settings) {{ player_one: human,
                          player_two: easy_ai,
                          board: board,
                          rules: rules }}
  let (:game_settings_2) {{ player_one: human,
                          player_two: hard_ai,
                          board: board,
                          rules: rules }}

  it 'quits out of the program' do
    rules.setup(human, easy_ai, board)
    board.gameboard = {
        '1' => 'X', '2' => 'O', '3' => ' ',
        '4' => 'O', '5' => ' ', '6' => ' ',
        '7' => 'X', '8' => 'O', '9' => 'X'
      }

    allow(round.configurations).to receive(:setup).and_return(game_settings)

    round.io.inputs = ['3']
    round.start

    expect(round.io.received_messages).to include(Messages::QUIT)
  end

  describe '#hard_ai' do
    it 'plays the game and displays the winner' do
      rules.setup(hard_ai, human, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => ' ',
          '4' => 'O', '5' => ' ', '6' => ' ',
          '7' => 'X', '8' => 'O', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings_2)

      round.io.inputs = ['2']
      round.start

      expect(round.io.received_messages).to include(Messages.print_round_win(hard_ai))
    end
  end

  describe '#easy_ai' do
    it 'plays the game and displays the winner' do
      rules.setup(human, easy_ai, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => ' ',
          '4' => 'O', '5' => ' ', '6' => ' ',
          '7' => 'X', '8' => 'O', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings)

      round.io.inputs = ['2', '5']
      round.start

      expect(round.io.received_messages).to include(Messages.print_round_win(human))
    end

    it "displays a 'How to Play' message if player selects the option" do
      rules.setup(human, easy_ai, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => ' ',
          '4' => 'O', '5' => ' ', '6' => ' ',
          '7' => 'X', '8' => 'O', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings)

      round.io.inputs = ['1', '2', '5']
      round.start

      expect(round.io.received_messages).to include(Messages::HOW_TO_PLAY)
    end

    it "displays an 'Invalid Option' message if player selects an unavailable option" do
      rules.setup(human, easy_ai, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => ' ',
          '4' => 'O', '5' => ' ', '6' => ' ',
          '7' => 'X', '8' => 'O', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings)

      round.io.inputs = ['hey', '2', '5']
      round.start

      expect(round.io.received_messages).to include(Messages::INVALID_OPTION)
    end

    it "plays the game and displays 'Draw' if tie game" do
      rules.setup(human, easy_ai, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => 'X',
          '4' => 'X', '5' => 'O', '6' => ' ',
          '7' => 'O', '8' => 'X', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings)

      round.io.inputs = ['1', '2', '6']
      round.start

      expect(round.io.received_messages).to include(Messages::DRAW)
    end

    it "outputs an 'Invalid Response' message if player inputs a number that is greater than the board size" do
      rules.setup(human, easy_ai, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => 'X',
          '4' => 'X', '5' => 'O', '6' => ' ',
          '7' => 'O', '8' => 'X', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings)

      round.io.inputs = ['2', '99', '6']
      round.start

      expect(round.io.received_messages).to include(Messages::INVALID_RESPONSE)
    end

    it "outputs an 'Invalid Move' message if player inputs a number that already has a game piece" do
      rules.setup(human, easy_ai, board)
      board.gameboard = {
          '1' => 'X', '2' => 'O', '3' => 'X',
          '4' => 'X', '5' => 'O', '6' => ' ',
          '7' => 'O', '8' => 'X', '9' => 'X'
        }

      allow(round.configurations).to receive(:setup).and_return(game_settings)

      round.io.inputs = ['2', '1', '6']
      round.start

      expect(round.io.received_messages).to include(Messages::INVALID_MOVE)
    end
  end
end
