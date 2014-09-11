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
  let (:hard_ai) { HardAI.new('X', board, rules) }
  let (:easy_settings) {{ player_one: easy_ai,
                           player_two: human,
                           board: board,
                           rules: rules }}
  let (:hard_settings) {{ player_one: hard_ai,
                           player_two: human,
                           board: board,
                           rules: rules }}

  def setup_easy_game
    round.game_settings = easy_settings
    board.create(3)
    rules.setup(human, easy_ai, board)
  end

  def setup_hard_game
    round.game_settings = hard_settings
    board.create(3)
    rules.setup(human, hard_ai, board)
  end

  it "sets up an easy game with players and a board" do
    allow(round.io).to receive(:out).with(Messages::WELCOME)
    allow(round.configurations).to receive(:setup).and_return(easy_settings)
    allow(round.menu).to receive(:call)
    allow(round.io).to receive(:out).with(Messages::PLAYER_OPTIONS)
    allow(round.io).to receive(:input).and_return('3')
    allow(round.io).to receive(:out).with(Messages::QUIT)

    round.start_game
    setup_easy_game

    expect(round.player_one).to be_instance_of(EasyAI)
    expect(round.player_two).to be_instance_of(Human)
    expect(round.board).to be_instance_of(Board)
  end

  it "sets up a hard game with players and a board" do
    allow(round.io).to receive(:out).with(Messages::WELCOME)
    allow(round.configurations).to receive(:setup).and_return(hard_settings)
    allow(round.menu).to receive(:call)
    allow(round.io).to receive(:out).with(Messages::PLAYER_OPTIONS)
    allow(round.io).to receive(:input).and_return('3')
    allow(round.io).to receive(:out).with(Messages::QUIT)

    round.start_game
    setup_hard_game

    expect(round.player_one).to be_instance_of(HardAI)
    expect(round.player_two).to be_instance_of(Human)
    expect(round.board).to be_instance_of(Board)
  end
end
