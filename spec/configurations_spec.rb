require 'configurations'
require 'input_output'

describe Configurations do
  let(:mock) { MockIO.new }
  let(:human) { Human.new('O', 'diana', mock) }
  let(:ai) { AI.new('X') }
  let(:config) { Configurations.new(mock) }

  it 'creates game settings' do
    config.io.inputs = ['diana', 'O', 'a', '3']
    #allow(config).to receive(:shuffle_order).with(ai, human)

    # mock out the shuffling so that I know exactly what is being returned
    # player_one.name == 'Diana'
    # player_one.game_piece == 'O'
    # player_one to be a kind of Human
    game_settings = config.setup

    expect(game_settings[:player_one].name).to be_a_kind_of(String)
    expect(game_settings[:player_one].game_piece).to be_a_kind_of(String)
    expect(game_settings[:player_two].name).to be_a_kind_of(String)
    expect(game_settings[:player_two].game_piece).to be_a_kind_of(String)
    expect(game_settings[:board]).to be_an_instance_of(Board)
    expect(game_settings[:board].gameboard.size).to eq(9)
  end

  it "won't accept a letter for board size" do
    config.io.inputs = ['diana', 'O', 'a', 'b', '3']

    game_settings = config.setup

    expect(config.io.received_messages).to include(Messages::INVALID_RESPONSE)
  end

  it "will only accept special characters as game pieces" do
    config.io.inputs = ['diana', '4', 'O', 'a', '3']
    game_settings = config.setup

    expect(config.io.received_messages).to include(Messages::INVALID_RESPONSE)
  end

  it "creates an AI player if 'a' is selected" do
    config.io.inputs = ['diana', '4', 'O', 'a', '3']
    game_settings = config.setup

    expect(game_settings.values).to include(AI)
  end

  it "creates a Human player if 'h' is selected" do
    config.io.inputs = ['diana', '4', 'O', 'a', '3']
    game_settings = config.setup

    expect(game_settings.values).to include(Human)
  end
end
