require 'round'
require 'board'
require 'input_output'
require 'messages'
require 'ai'
require 'player'

describe Round do
  let(:mock) { MockIO.new }
  let(:ui_messages) { Messages.new(mock) }
  let (:round) { Round.new(Board.new(3, mock), ui_messages, mock, AI.new, Player.new) }

  it "selects an 'O' player" do
    round.random_select_players
    round.assign_game_pieces

    expect(round.o_player.game_piece).to eq('O')
  end

  it "selects an 'X' player" do
    round.random_select_players
    round.assign_game_pieces

    expect(round.x_player.game_piece).to eq('X')
  end
end
