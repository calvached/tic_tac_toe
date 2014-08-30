require 'board'
require 'input_output'

describe Board do
  let (:board) { Board.new }

  before(:example) do
    board.create(3)
  end

  it 'fills space in available positions only' do
    board.place_game_piece('4', 'x')
    board.place_game_piece('4', 'o')

    expect(board.gameboard['4']).to eq('x')
  end

  it 'returns true if board is completely filled' do
    board.gameboard = {
      '1'=>"O", '2'=>"X", '3'=>"O",
      '4'=>"X", '5'=>"O", '6'=>"X",
      '7'=>"O", '8'=>"X", '9'=>"O"
    }

    expect(board.is_full?).to eq(true)
  end

  it 'returns false if board is not completely filled' do
    board.gameboard = {
      '1'=>"O", '2'=>"X", '3'=>" ",
      '4'=>" ", '5'=>" ", '6'=>"X",
      '7'=>"O", '8'=>" ", '9'=>"O"
    }

    expect(board.is_full?).to eq(false)
  end

  it 'returns the number of cells occupied' do
    board.place_game_piece('4', 'x')
    board.place_game_piece('5', 'o')

    expect(board.occupied_cells).to eq(2)
  end

  it 'returns true if a winning pattern is found' do
    board.gameboard = {
      '1'=>"X", '2'=>" ", '3'=>"X",
      '4'=>" ", '5'=>" ", '6'=>"X",
      '7'=>"O", '8'=>"O", '9'=>"O"
    }

    expect(board.winner?).to eq(true)
  end

  it 'returns false if a winning pattern is not found' do
    board.gameboard = {
      '1'=>"X", '2'=>" ", '3'=>"X",
      '4'=>" ", '5'=>" ", '6'=>"X",
      '7'=>"O", '8'=>" ", '9'=>"O"
    }

    expect(board.winner?).to eq(false)
  end

  it "returns 3 sets of rows" do
    board.gameboard = {
      '1'=>"O", '2'=>"X", '3'=>"O",
      '4'=>" ", '5'=>" ", '6'=>"O",
      '7'=>"X", '8'=>" ", '9'=>"X"}

    expect(board.get_rows).to eq([
      ["O", "X", "O"],
      [" ", " ", "O"],
      ["X", " ", "X"]
    ])
  end

  it "returns 3 sets of columns" do
    board.gameboard = {
      '1'=>"O", '2'=>"X", '3'=>"O",
      '4'=>"O", '5'=>" ", '6'=>"O",
      '7'=>"O", '8'=>" ", '9'=>"X"
    }

    expect(board.get_columns).to eq([
      ["O", "O", "O"],
      ["X", " ", " "],
      ["O", "O", "X"]
    ])
  end

  it "returns 2 sets of diagonals" do
    board.gameboard = {
      '1'=>" ", '2'=>"X", '3'=>"O",
      '4'=>" ", '5'=>"O", '6'=>"X",
      '7'=>"O", '8'=>" ", '9'=>"X"
    }

    expect(board.get_diagonals).to eq([
      [" ", "O", "X"],
      ["O", "O", "O"]])
  end
end
