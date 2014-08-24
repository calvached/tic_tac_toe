require 'round'
require 'board'
require 'input_output'

describe Round do
  let(:mock) { MockIO.new }
  let (:round) { Round.new(Board.new, mock) }

  it 'creates an AI player' do
    round.io.inputs = ['1', '2', '3']
    round.start_game

    expect(round.ai).to be_instance_of(AI)
  end

  it 'creates a Human player' do
    round.io.inputs = ['2', '3', '3']
    round.start_game

    expect(round.human).to be_instance_of(Human)
  end

  it "displays 'Welcome'" do
    round.io.inputs = ['1', '2', '3']
    round.start_game

    expect(round.io.messages).to include(Messages::WELCOME)
  end

  it "displays 'How to Play' instructions" do
    round.io.inputs = ['1', '2', '3']
    round.start_game

    expect(round.io.messages).to include(Messages::HOW_TO_PLAY)
  end

  it "displays options for the player to choose from" do
    round.io.inputs = ['3', '2', '3']
    round.start_game

    expect(round.io.messages).to include(Messages::PLAYER_OPTIONS)
  end

  it "displays an 'invalid selection' message if option not available" do
    round.io.inputs = ['hey', '2', '3']
    round.start_game

    expect(round.io.messages).to include(Messages::INVALID_OPTION)
  end

  it 'asks gameboard size input' do
    round.io.inputs = ['2', '3', '3']
    round.start_game

    expect(round.io.messages).to include("Please input the gameboard size (e.g. '3' for 3x3): ")
  end
end
