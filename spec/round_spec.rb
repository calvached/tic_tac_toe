require 'round'
require 'input_output'

describe Round do
  let(:mock) { MockIO.new }
  let (:round) { Round.new(mock) }

  it 'creates an AI player' do
    round.create_ai_player

    expect(round.ai).to be_instance_of(AI)
  end

  it 'creates a Human player' do
    round.create_human_player

    expect(round.human).to be_instance_of(Human)
  end

  it "displays 'How to Play' instructions" do
    round.io.inputs = ['1']
    round.start_game

    expect(round.io.messages).to include("# How to Play #")
  end

  it "displays options for the player to choose from" do
    round.io.inputs = ['3']
    round.start_game

    expect(round.io.messages).to include("Please make a selection from the following: ")
  end

  it "displays an 'invalid selection' message if option not available" do
    round.io.inputs = ['hey']
    round.start_game

    expect(round.io.messages).to include("Invalid selection. Please try again or press 3 for help.")
  end
end
