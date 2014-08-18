class MyIO
  def in
    gets
  end

  def out(message)
    puts message
  end
end

class MockIO
  attr_accessor :inputs
  attr_reader :messages

  def initialize
    @inputs = nil
    @messages = []
  end

  def in
    @inputs.shift
  end

  def out(message)
    @messages << message
  end
end
