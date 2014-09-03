require 'human'
require 'input_output'

describe Human do
  let (:human) { Human.new('X', 'Diana', MockIO.new) }

  it 'has a game piece' do
    expect(human.game_piece).to eq('X')
  end

end
