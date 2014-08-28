require 'configurations'
require 'input_output'

describe Configurations do
  let(:config) { Configurations.new(MockIO.new) }

  it 'creates game_settings' do
    allow(config.io).to receive(:input).and_return('3')
    allow(config).to receive(:create_players)

    expect(config.setup).to be_kind_of(Hash)
    expect(config.setup.length).to eq(3)
  end

  it 'creates Player One' do
    allow(config.io).to receive(:input).and_return('3')
    allow(config).to receive(:create_players)

    expect(config.setup[:player_one]).to be_a_kind_of(Object)
  end

  it 'creates Player Two' do
    allow(config.io).to receive(:input).and_return('3')
    allow(config).to receive(:create_players)

    expect(config.setup[:player_two]).to be_a_kind_of(Object)
  end

  it 'creates a Board' do
    allow(config.io).to receive(:input).and_return('3')
    allow(config).to receive(:create_players)

    expect(config.setup[:board]).to be_an_instance_of(Board)
  end

  it 'returns a Human opponent' do
    allow(config.io).to receive(:input).and_return('H')

    p config.send(:challenger)
  end

  xit 'returns an AI opponent' do
    allow(config.io).to receive(:input).and_return('A')

    p config.send(:challenger)
  end
end
