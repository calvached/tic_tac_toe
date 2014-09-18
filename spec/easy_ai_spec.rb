require 'easy_ai'
require 'board'

describe EasyAI do
  let (:ai) { EasyAI.new('X', Board.new) }

  it 'returns a position on the board' do
    allow(ai.board).to receive(:gameboard).and_return({
          '1' => ' ', '2' => ' ', '3' => ' ',
          '4' => ' ', '5' => ' ', '6' => ' ',
          '7' => ' ', '8' => ' ', '9' => ' '
        })
    expect(ai.make_move.to_i).to be_between(1, 9)
  end
end
