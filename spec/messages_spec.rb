require 'messages'
require 'input_output'

describe Messages do
  let (:message) { Messages.new(MockIO.new) }

  it 'displays a welcome message' do
    message.welcome

    expect(message.io.messages).to include("# Welcome to Tic Tac Toe! #")
  end

  it 'displays player options' do
    message.player_options

    expect(message.io.messages).to include('Please make a selection from the following: ')
  end

  it 'displays instructions' do
    message.instructions

    expect(message.io.messages).to include("# How to Play #")
  end

  it 'displays an invalid option' do
    message.invalid_option

    expect(message.io.messages).to include("Invalid selection. Please try again.")
  end
end
