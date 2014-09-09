require 'easy_ai'
require 'board'

describe EasyAI do
  let (:ai) { EasyAI.new('X', Board.new) }

  it 'returns a position on the board' do
    expect(ai.make_move.to_i).to be_between(1, 9)
  end
end
