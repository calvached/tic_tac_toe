require 'ai'

describe AI do
  let (:ai) { AI.new('X') }
  it 'returns a position on the board' do
    expect(ai.make_move.to_i).to be_between(1, 9)
  end
end
