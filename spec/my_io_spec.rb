require 'simplecov'
SimpleCov.start

require 'input_output'

describe MyIO do
  let (:message) { 'Please enter number 1: ' }
  let (:message_2) { 'Please enter a number: ' }
  let (:message_3) { 'Please input a cell number: ' }
  let (:io) { MyIO.new }

  before(:example) do
    allow(io).to receive(:out)
  end

  it 'prompts user for input and returns input' do
    allow(io).to receive(:input).and_return('1')

    expect(io.prompt(message,'regex', /1/)).to eq('1')
  end

  it 'prompts user for input until correct input is entered' do
    allow(io).to receive(:input).and_return('2', '1')

    expect(io.prompt(message, 'regex',/1/)).to eq('1')
  end

  it 'prompts user for input until condition is satisfied' do
    allow(io).to receive(:input).and_return('d', '1')

    expect(io.prompt(message_2, 'regex',/\d/)).to eq('1')
  end

end
