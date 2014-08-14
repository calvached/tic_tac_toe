require 'round'
require 'board'
require 'input_output'
require 'messages'

describe Round do
  let(:mock) { MockIO.new }
  let(:ui_messages) { Messages.new(mock) }
  let (:round) { Round.new(Board.new(3, mock), ui_messages, mock) }

  it 'displays a welcome message' do
    round.start_game
    expect(round.message.io.messages).to include("# Welcome to Tic Tac Toe! #")
  end

  it 'displays options for a player to choose from' do
    round.start_game
    expect(round.message.io.messages).to include("Please make a selection from the following: ")
  end

  #it 'responds with a message to the user if a space is taken' do
  #  board.create
  #  board.place_game_piece(4, 'x')
  #  board.place_game_piece(4, 'o')

  #    expect(board.io.messages).to eq(["Invalid selection. Please try again."])
  #end
end
