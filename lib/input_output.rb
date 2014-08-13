class MyIO
  def in
    gets
  end

  def out(message)
    puts message
  end
end

class MockIO
  attr_reader :messages

  def initialize
    @messages = []
  end

  def in
  end

  def out(message)
    @messages << message
  end
end
