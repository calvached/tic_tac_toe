require 'simplecov'
SimpleCov.start

require 'game_rules'
require 'board'
require 'human'
require 'easy_ai'
require 'input_output'

describe GameRules do
  let (:mock) { MockIO.new }
  let (:human) { Human.new('O', 'diana', mock) }
  let (:board) { Board.new }
  let (:easy_ai) { EasyAI.new('X', board) }
  let (:rules) { GameRules.new }

  def setup_game
    rules.setup(human, easy_ai, board)
  end

  describe '#game_over?' do
    it 'declares game over false if no winner found and board not full' do
      setup_game
      allow(rules.board).to receive(:is_full?).and_return(false)
      allow(rules.board).to receive(:get_rows).and_return([
          ["X", "X", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_columns).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_diagonals).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])

      expect(rules.game_over?).to eq(false)
    end

    it 'declares game over if board full' do
      setup_game
      allow(rules.board).to receive(:is_full?).and_return(true)
      allow(rules.board).to receive(:get_rows).and_return([
          ["X", "X", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_columns).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_diagonals).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])

      expect(rules.game_over?).to eq(true)
    end
  end

  describe '#draw?' do
    it 'declares a draw' do
      setup_game
      allow(rules.board).to receive(:is_full?).and_return(true)
      allow(rules.board).to receive(:get_rows).and_return([
          ["X", "X", "O"], ["O", "X", "O"], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_columns).and_return([
          ["X", "X", "O"], ["O", "X", "O"], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_diagonals).and_return([
          ["X", "X", "O"], ["O", "X", "O"], ["O", "X", "X"]
        ])

      expect(rules.draw?).to eq(true)
    end

    it 'returns false if no draw' do
      setup_game
      allow(rules.board).to receive(:is_full?).and_return(false)
      allow(rules.board).to receive(:get_rows).and_return([
          ["X", "X", "O"], ["O", "X", "O"], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_columns).and_return([
          ["X", "X", "O"], ["O", "X", "O"], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_diagonals).and_return([
          ["X", "X", "O"], ["O", "X", "O"], ["O", "X", "X"]
        ])

      expect(rules.draw?).to eq(false)
    end
  end

  describe '#player_piece' do
    it 'returns the game piece of the current player' do
      setup_game
      allow(rules.board).to receive(:even_occupied_cells?).and_return(true)

      expect(rules.player_piece).to eq('O')
    end
  end

  describe '#winner?' do
    it 'declares game over if winner exists' do
      setup_game
      allow(rules.board).to receive(:get_rows).and_return([
          ["X", "X", "X"], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_columns).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_diagonals).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])

      expect(rules.winner?).to eq(true)
    end

    it 'continues game if winner does not exist' do
      setup_game
      allow(rules.board).to receive(:get_rows).and_return([
          ["X", "X", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_columns).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])
      allow(rules.board).to receive(:get_diagonals).and_return([
          ["X", "O", " "], [" ", " ", " "], ["O", "X", "X"]
        ])

      expect(rules.winner?).to eq(false)
    end
  end

  describe '#winning_piece' do
    it 'returns the winning game piece' do
      setup_game
      allow(rules.board).to receive(:even_occupied_cells?).and_return(false)

      expect(rules.winning_piece).to eq('O')
    end
  end

  describe '#valid_entry?' do
    it 'returns true if the move is within the board' do
      setup_game
      allow(rules.board).to receive(:gameboard).and_return({
        '1' => ' ', '2' => ' ', '3' => ' ',
        '4' => ' ', '5' => ' ', '6' => ' ',
        '7' => ' ', '8' => ' ', '9' => ' '
      })

      expect(rules.valid_entry?('3')).to eq(true)
    end

    it 'returns false if the move is out of bounds of the board' do
      setup_game
      allow(rules.board).to receive(:gameboard).and_return({
        '1' => ' ', '2' => ' ', '3' => ' ',
        '4' => ' ', '5' => ' ', '6' => ' ',
        '7' => ' ', '8' => ' ', '9' => ' '
      })

      expect(rules.valid_entry?('39')).to eq(false)
    end
  end

  describe '#declared_winner' do
    it 'declares the player one winner if cell count is odd' do
      setup_game
      allow(rules.board).to receive(:even_occupied_cells?).and_return(false)

      expect(rules.declared_winner).to be_instance_of(Human)
    end

    it 'declares player two winner if cell count is not odd' do
      setup_game
      allow(rules.board).to receive(:even_occupied_cells?).and_return(true)

      expect(rules.declared_winner).to be_instance_of(EasyAI)
    end
  end

  describe '#current_player' do
    it 'returns the current player for an even cell count' do
      setup_game
      allow(rules.board).to receive(:even_occupied_cells?).and_return(true)

      expect(rules.current_player).to be_instance_of(Human)
    end

    it 'returns the current player for an odd cell count' do
      setup_game
      allow(rules.board).to receive(:even_occupied_cells?).and_return(false)

      expect(rules.current_player).to be_instance_of(EasyAI)
    end
  end
end
