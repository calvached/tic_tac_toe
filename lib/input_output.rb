class MyIO
  def input
    gets.chomp
  end

  def out(message)
    puts "\n" + message
  end

  def prompt(message, validation_type, validation)
    out(message)

    validate_against_regex(input, message, validation_type, validation)
  end

  def validate_against_regex(input, message, validation_type, validation)
    if input =~ validation
      input
    else
      out(Messages::INVALID_RESPONSE)
      prompt(message, validation_type, validation)
    end
  end
end

class MockIO
  attr_accessor :inputs
  attr_reader :received_messages

  def initialize
    @inputs = nil
    @received_messages = []
  end

  def input
    @inputs.shift
  end

  def out(message)
    @received_messages << message
  end

  def prompt(message, validation_type, validation)
    @received_messages << message
    @inputs.shift
  end
end
