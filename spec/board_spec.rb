require 'board'
require 'input_output'

describe Board do
  let (:board) { Board.new }

  before(:example) do
    board.create(3)
  end

  it 'fills space in available positions only' do
    board.place_game_piece(4, 'x')
    board.place_game_piece(4, 'o')

    expect(board.gameboard[4]).to eq('x')
  end

  it 'returns true if board is completely filled' do
    board.gameboard = {1=>"O", 2=>"X", 3=>"O", 4=>"X", 5=>"O", 6=>"X", 7=>"O", 8=>"X", 9=>"O"}

    expect(board.is_full?).to eq(true)
  end

  it 'returns false if board is not completely filled' do
    board.gameboard = {1=>"", 2=>"X", 3=>"", 4=>"", 5=>"", 6=>"X", 7=>"O", 8=>"X", 9=>"O"}

    expect(board.is_full?).to eq(false)
  end
end
