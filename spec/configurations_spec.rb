require 'simplecov'
SimpleCov.start

require 'configurations'
require 'input_output'

describe Configurations do
  let(:mock) { MockIO.new }
  let(:config) { Configurations.new(mock) }

  it 'creates game settings' do
    config.io.inputs = ['3', 'h', 'diana', 'O', 'ec']
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
    expect(game_settings[:rules]).to be_an_instance_of(GameRules)
  end

  it "won't accept a letter for board size" do
    config.io.inputs = ['b', '3', 'h', 'diana', 'O', 'ec']

    game_settings = config.setup

    expect(config.io.received_messages).to include(Messages::INVALID_RESPONSE)
  end

  it "will only accept special characters as game pieces" do
    config.io.inputs = ['3', 'h', 'diana', '4', 'O', 'ec']
    game_settings = config.setup

    expect(config.io.received_messages).to include(Messages::INVALID_RESPONSE)
  end

  it "creates an easy AI player if 'ea' is selected" do
    config.io.inputs = ['3', 'h', 'diana', '4', 'O', 'ec']
    game_settings = config.setup

    expect(game_settings.values).to include(EasyAI)
  end

  it "creates a hard AI player if 'ha' is selected" do
    config.io.inputs = ['3', 'h', 'diana', '4', 'O', 'hc']
    game_settings = config.setup

    expect(game_settings.values).to include(HardAI)
  end

  it "creates a Human player if 'h' is selected" do
    config.io.inputs = ['3', 'h', 'diana', 'O', 'h', 'ruby', '#']
    game_settings = config.setup

    expect(game_settings[:player_one]).to be_an_instance_of(Human)
    expect(game_settings[:player_one].name).to be_a_kind_of(String)
    expect(game_settings[:player_one].game_piece).to be_a_kind_of(String)

    expect(game_settings[:player_two]).to be_an_instance_of(Human)
    expect(game_settings[:player_two].name).to be_a_kind_of(String)
    expect(game_settings[:player_two].game_piece).to be_a_kind_of(String)
  end

  it 'does not allow human players to have the same game pieces' do
    config.io.inputs = ['3', 'h', 'diana', 'O', 'h', 'ruby', 'O', '#']
    game_settings = config.setup

    expect(config.io.received_messages).to include(Messages::TAKEN_GAME_PIECE)
  end

  it 'does not allow AI player to have the same game piece as the human player' do
    config.io.inputs = ['3', 'h', 'diana', 'X', 'ec']
    game_settings = config.setup

    expect(game_settings[:player_one].game_piece).to_not eq(game_settings[:player_two].game_piece)
  end

  it 'does not allow AI players to have the same game piece' do
    config.io.inputs = ['3', 'hc', 'ec']
    game_settings = config.setup

    expect(game_settings[:player_one].game_piece).to_not eq(game_settings[:player_two].game_piece)
  end
end
