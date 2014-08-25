class Configurations
  def setup
  end
  def play
    @io.out(Messages::ASK_FOR_BOARD_SIZE)
    create_players if get_board_size
  end
end

#Round only cares about Human, AI and Board
#Configuration does the rest of the set up (board size, ai difficulty, player names, etc)
# Display message
# Get config.game_settings
# Save setting as value in hash
# will send instances of Board, Human, and AI back to Round
