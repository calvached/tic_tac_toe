require 'simplecov'
SimpleCov.start

require 'round'
require 'ai'
require 'human'
require 'board'
require 'input_output'
require 'configurations'

describe Round do
  let (:mock) { MockIO.new }
  let (:ai) { AI.new('X') }
  let (:human) { Human.new('O', 'Diana', mock) }
  let (:board) { Board.new }
  let (:round) { Round.new(Configurations.new(mock), mock) }
  let (:game_settings) { { player_one: ai, player_two: human, board: board } }

  def make_board
    round.game_settings = game_settings
    board.create(3)
  end

  it "sets up a game with players and a board" do
    allow(round.io).to receive(:out).with(Messages::WELCOME)
    allow(round.configurations).to receive(:setup).and_return(game_settings)
    allow(round.menu).to receive(:call)
    allow(round.io).to receive(:out).with(Messages::PLAYER_OPTIONS)
    allow(round.io).to receive(:input).and_return('3')
    allow(round.io).to receive(:out).with(Messages::QUIT)

    round.start_game
    make_board

    expect(round.player_one).to be_instance_of(AI)
    expect(round.player_two).to be_instance_of(Human)
    expect(round.board).to be_instance_of(Board)
  end

  it 'plays the game' do
    allow(board).to receive(:game_over?).and_return(false, false, false, true)

    make_board
    board.gameboard = {
      '1'=>"O", '2'=>"X", '3'=>"O",
      '4'=>"X", '5'=>"O", '6'=>"X",
      '7'=>"O", '8'=>"X", '9'=>"O"
    }

    allow(round).to receive(:print_board)
    allow(round.io).to receive(:prompt).with(Messages::MAKE_MOVE, 'regex', /\d/).and_return('1', '2', '3', '4')
    allow(board).to receive(:place_game_piece)

    round.play

    expect(round.io).to have_received(:prompt).with(Messages::MAKE_MOVE, 'regex', /\d/).exactly(3)
    expect(round).to have_received(:print_board).exactly(4)
    expect(round.board).to have_received(:place_game_piece).with('1', 'O')

  end

  it 'returns the current player for an even cell count' do
    make_board

    expect(round.current_player).to be_instance_of(AI)
  end

  it 'returns the current player for an odd cell count' do
    make_board
    board.place_game_piece('1', 'X')

    expect(round.current_player).to be_instance_of(Human)
  end
end
