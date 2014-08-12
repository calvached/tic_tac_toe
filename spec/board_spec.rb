require 'board'

describe Board do
  let (:board) { Board.new }

  it 'fills in a space on the board' do
    board.fill_space('4', 'x')

    expect(board.gameboard['4']).to eq('x')
  end

  it 'fills space in available positions only' do
    board.place_game_piece('4', 'x')
    board.place_game_piece('4', 'o')

    expect(board.gameboard['4']).to eq('x')
  end
end
