require 'ai'

describe AI do
  let (:ai) { AI.new }
  it 'returns a position on the board' do
    expect(ai.make_move).to be_between(0, 8)
  end
end
