require 'board'
require 'input_output'

describe Board do
  let (:board) { Board.new(3, MockIO.new) }

  it 'displays the board' do
    board.gameboard = {
      '1' => 'x', '2' => '', '3' => 'x',
      '4' => '', '5' => 'o', '6' => '',
      '7' => '', '8' => 'o', '9' => ''
    }

    expect(board.display).to eq({
      "1"=>"x", "2"=>"", "3"=>"x",
      "4"=>"", "5"=>"o", "6"=>"",
      "7"=>"", "8"=>"o", "9"=>""
    })
  end

  it 'fills space in available positions only' do
    board.create
    board.place_game_piece(4, 'x')
    board.place_game_piece(4, 'o')

    expect(board.gameboard[4]).to eq('x')
  end

  it 'responds with a message to the user if a space is taken' do
    board.create
    board.place_game_piece(4, 'x')
    board.place_game_piece(4, 'o')

    expect(board.io.messages).to eq(["Invalid selection. Please try again."])
  end
end
