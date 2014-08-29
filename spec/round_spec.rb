require 'round'
require 'ai'
require 'human'
require 'board'
require 'input_output'
require 'configurations'

describe Round do
  let (:mock) { MyIO.new }
  let (:ai) { AI.new('X') }
  let (:human) { Human.new('O', mock) }
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
    allow(round.io).to receive(:input).and_return('4')
    allow(round.io).to receive(:out).with(Messages::QUIT)

    round.start_game

    expect(round.player_one).to be_instance_of(AI)
    expect(round.player_two).to be_instance_of(Human)
    expect(round.board).to be_instance_of(Board)
  end

  it 'plays the game' do
    allow(round).to receive(:game_over?).and_return(false, false, false, true)
    allow(round.io).to receive(:out).with(Messages.prettify_board(board))
    allow(round.io).to receive(:prompt).with(Messages::MAKE_MOVE, 'regex', /\d/).and_return('1', '2', '3', '4')
    allow(board).to receive(:place_game_piece)

    make_board

    round.play

    expect(round.io).to have_received(:prompt).with(Messages::MAKE_MOVE, 'regex', /\d/).exactly(3)
    expect(round.io).to have_received(:out).with(Messages.prettify_board(board)).exactly(3)
    expect(round.board).to have_received(:place_game_piece).with('1', 'X')

  end

  it 'finishes a round if winning combination is found' do
    allow(board).to receive(:is_full?).and_return(false)
    allow(board).to receive(:winner?).and_return(true)

    make_board

    expect(round.game_over?).to eq(true)
  end

  it 'finishes a round if board is completely full' do
    allow(board).to receive(:is_full?).and_return(true)
    allow(board).to receive(:winner?).and_return(false)

    make_board

    expect(round.game_over?).to eq(true)
  end

  it 'continues the game if no winner and board incomplete' do
    allow(board).to receive(:is_full?).and_return(false)
    allow(board).to receive(:winner?).and_return(false)

    make_board

    expect(round.game_over?).to eq(false)
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

# XOX
# XXO
# OXO

  # LOOP UNTIL GAME_OVER?
  # END
  #
  # GAME_OVER?
  # BOARD FULL/DRAW OR WINNER
  # Display game_over_message
  # Prompt Play_again?
  # END
