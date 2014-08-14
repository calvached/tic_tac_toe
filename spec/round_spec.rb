require 'round'
require 'board'
require 'input_output'
require 'messages'

describe Round do
  let(:mock) { MockIO.new }
  let(:ui_messages) { Messages.new(mock) }
  let (:round) { Round.new(Board.new(3, mock), ui_messages, mock) }

end
