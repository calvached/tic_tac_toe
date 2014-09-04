require 'configurations'
require 'input_output'

describe Configurations do
  let(:config) { Configurations.new(MockIO.new) }

  it 'creates game settings' do
    config.io.inputs = ['diana', 'O', 'a', '3']
    game_settings = config.setup

    expect(game_settings[:player_one].name).to be_a_kind_of(String)
    expect(game_settings[:player_one].game_piece).to be_a_kind_of(String)
    expect(game_settings[:player_two].name).to be_a_kind_of(String)
    expect(game_settings[:player_two].game_piece).to be_a_kind_of(String)
    expect(game_settings[:board]).to be_an_instance_of(Board)
  end
end
