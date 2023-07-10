# frozen_string_literal: true

# Module for input data validation.
module InputDataValidation
  def self.validate(input, minimum)
    validate_input_length(input)
    validate_positive_integer(input[0])
    validate_minimum_value(input[0].to_i, minimum)

    input[0].to_i
  end

  def self.validate_input_length(input)
    raise StandardError, 'Palaižot programmu jānorāda tieši viens parametrs!' unless input.length == 1
  end

  def self.validate_positive_integer(input)
    raise StandardError, 'Ievades dati nav pozitīvs vesels skaitlis!' unless input.match?(/^\d+$/)
  end

  def self.validate_minimum_value(input, minimum)
    raise StandardError, 'Ievades dati ir mazāki par minimālajām izmaksām!' unless input >= minimum
  end
end
