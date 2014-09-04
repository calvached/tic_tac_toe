require 'round'
require 'configurations'
require 'input_output'
require 'ai'
require 'human'
require 'board'
require 'messages'

describe Round do
  let (:mock) { MockIO.new }
  let (:board) { Board.new }
  let (:round) { Round.new(Configurations.new(mock), mock) }
  let (:human) { Human.new('O', 'diana', mock) }
  let (:ai) { AI.new('X') }
  let (:game_settings) {{ player_one: human,
                          player_two: ai,
                          board: board }}

  it 'plays the game' do
    board.gameboard = {
        '1' => 'X', '2' => 'O', '3' => ' ',
        '4' => 'O', '5' => ' ', '6' => ' ',
        '7' => 'X', '8' => 'O', '9' => 'X'
      }

    allow(round.configurations).to receive(:setup).and_return(game_settings)

    round.io.inputs = ['2', '5', '3']
    round.start_game

    expect(round.io.received_messages).to include(Messages.print_round_win(human))
  end
end

#it 'creates an AI player' do
#    round.io.inputs = ['2', '3']
#
#    require 'pry'
#    binding.pry
#
#    round.start_game
#
#    expect(round.ai).to be_instance_of(AI)
#  end
#
#  it 'creates a Human player' do
#    round.io.inputs = ['2', '3', '3']
#    round.start_game
#
#    expect(round.human).to be_instance_of(Human)
#  end
#
#  it "displays 'Welcome'" do
#    round.io.inputs = ['1', '2', '3']
#    round.start_game
#
#    expect(round.io.received_messages).to include(Messages::WELCOME)
#  end
#
#  it "displays 'How to Play' instructions" do
#    round.io.inputs = ['1', '2', '3']
#    round.start_game
#
#    expect(round.io.received_messages).to include(Messages::HOW_TO_PLAY)
#  end
#
#  it "displays options for the player to choose from" do
#    round.io.inputs = ['3', '2', '3']
#    round.start_game
#
#    expect(round.io.received_messages).to include(Messages::PLAYER_OPTIONS)
#  end
#
#  it "displays an 'invalid selection' message if option not available" do
#    round.io.inputs = ['hey', '2', '3']
#    round.start_game
#
#    expect(round.io.received_messages).to include(Messages::INVALID_OPTION)
#  end
#
#  it 'asks gameboard size input' do
#    round.io.inputs = ['2', '3', '3']
#    round.start_game
#
#    expect(round.io.received_messages).to include("Please input the gameboard size (e.g. '3' for 3x3): ")
#  end
#
