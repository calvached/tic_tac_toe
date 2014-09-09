require 'simplecov'
SimpleCov.start

require 'game_rules'
require 'board'
require 'human'
require 'easy_ai'
require 'input_output'

describe GameRules do
  let (:mock) { MockIO.new }
  let (:human) { Human.new('diana', 'O', mock) }
  let (:board) { Board.new }
  let (:easy_ai) { EasyAI.new('X', board) }
  let (:rules) { GameRules.new }

  def setup_game
    board.create(3)
    rules.setup(human, easy_ai, board)
  end

  it 'declares game over false if no winner found or board not full' do
    setup_game
    board.gameboard = { "1"=>" ", "2"=>" ", "3"=>" ",
                        "4"=>" ", "5"=>" ", "6"=>" ",
                        "7"=>" ", "8"=>" ", "9"=>" " }

    expect(rules.game_over?).to eq(false)
  end

  it 'declares game over if winner found or board full' do
    setup_game
    board.gameboard = { "1"=>"X", "2"=>"X", "3"=>"O",
                        "4"=>"O", "5"=>"O", "6"=>"X",
                        "7"=>"X", "8"=>"X", "9"=>"O" }

    expect(rules.game_over?).to eq(true)
  end

  it 'declares a draw' do
    setup_game
    board.gameboard = { "1"=>"X", "2"=>"X", "3"=>"O",
                        "4"=>"O", "5"=>"O", "6"=>"X",
                        "7"=>"X", "8"=>"X", "9"=>"O" }

    expect(rules.draw?).to eq(true)
  end

  it 'returns false if no draw' do
    setup_game
    board.gameboard = { "1"=>"X", "2"=>"X", "3"=>"O",
                        "4"=>"X", "5"=>"O", "6"=>"X",
                        "7"=>"X", "8"=>"X", "9"=>"O" }

    expect(rules.draw?).to eq(false)
  end

  it 'returns the current player for an even cell count' do
    setup_game

    expect(rules.current_player).to be_instance_of(Human)
  end

  it 'returns the current player for an odd cell count' do
    setup_game
    board.place_game_piece('1', 'X')

    expect(rules.current_player).to be_instance_of(EasyAI)
  end

  it 'returns true if the move is valid' do
    setup_game

    expect(rules.valid_entry?('3')).to eq(true)
  end

  it 'returns false if the move is invalid' do
    setup_game

    expect(rules.valid_entry?('39')).to eq(false)
  end
end
