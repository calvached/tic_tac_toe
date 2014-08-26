require 'configurations'
require 'input_output'

describe Configurations do
  let(:config) { Configurations.new(MockIO.new) }

  before(:example) do
    allow(config.io).to receive(:input).and_return('3')
  end

  it 'creates game_settings' do
    expect(config.setup).to be_kind_of(Hash)
    expect(config.setup.length).to eq(3)
  end

  it 'creates Player One' do
    expect(config.setup[:player_one]).to be_a_kind_of(Object)
  end

  it 'creates Player Two' do
    expect(config.setup[:player_two]).to be_a_kind_of(Object)
  end

  it 'creates a Board' do
    expect(config.setup[:board]).to be_an_instance_of(Board)
  end

end
