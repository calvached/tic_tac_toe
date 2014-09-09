require 'simplecov'
SimpleCov.start

require 'round'
require 'easy_ai'
require 'human'
require 'board'
require 'input_output'
require 'configurations'
require 'game_rules'

describe Round do
  let (:mock) { MockIO.new }
  let (:board) { Board.new }
  let (:easy_ai) { EasyAI.new('X', board) }
  let (:human) { Human.new('O', 'Diana', mock) }
  let (:round) { Round.new(Configurations.new(mock), mock) }
  let (:rules) { GameRules.new }
  let (:game_settings) {{ player_one: easy_ai,
                           player_two: human,
                           board: board,
                           rules: rules }}

  def setup_game
    round.game_settings = game_settings
    board.create(3)
    rules.setup(human, easy_ai, board)
  end

  it "sets up a game with players and a board" do
    allow(round.io).to receive(:out).with(Messages::WELCOME)
    allow(round.configurations).to receive(:setup).and_return(game_settings)
    allow(round.menu).to receive(:call)
    allow(round.io).to receive(:out).with(Messages::PLAYER_OPTIONS)
    allow(round.io).to receive(:input).and_return('3')
    allow(round.io).to receive(:out).with(Messages::QUIT)

    round.start_game
    setup_game

    expect(round.player_one).to be_instance_of(EasyAI)
    expect(round.player_two).to be_instance_of(Human)
    expect(round.board).to be_instance_of(Board)
  end

  xit 'plays the game' do
    allow(rules).to receive(:game_over?).and_return(false, false, false, true)

    setup_game
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
end
