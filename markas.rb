# frozen_string_literal: true

require_relative 'stamp_calculation'
require_relative 'sentence_forming'
require_relative 'input_data_validation'

def main(input_data)
  high_stamp_value = 5
  high_value_as_word = 'piecu'
  low_stamp_value = 3
  low_value_as_word = 'trīs'
  minimal_cost = 8

  valid_input = validate_input(input_data, minimal_cost)

  calculate_and_output_sentence(high_stamp_value, low_stamp_value, high_value_as_word, low_value_as_word, valid_input)
end

def validate_input(data, minimum)
  InputDataValidation.validate(data, minimum)
rescue StandardError => e
  puts "Kļūda: #{e}"
  exit(1)
end

def calculate_and_output_sentence(high_value, low_value, high_as_word, low_as_word, input_data)
  calc = StampCalculation.new(high_value, low_value)
  stamp_count = calc.calculate_high_and_low(input_data)
  sentence = SentenceForming.new(
    stamp_count[:high_value_count],
    stamp_count[:low_value_count],
    high_as_word,
    low_as_word
  )
  puts sentence.output_sentence
end

main(ARGV) if $PROGRAM_NAME == __FILE__
