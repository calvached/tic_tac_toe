class MyIO
  def input
    gets.chomp
  end

  def out(message)
    puts message
  end

  def prompt(message, validation_type, validation)
    out(message)

    if validation_type == 'method'
      validate_against_method(input, message, validation_type, validation)
    else
      validate_against_regex(input, message, validation_type, validation)
    end
  end

  def validate_against_method(input, message, validation_type, validation)
     if send(validation, input)
       input
     else
       prompt(message, validation_type, validation)
     end
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
  attr_reader :messages

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
