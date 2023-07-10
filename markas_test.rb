# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'stamp_calculation'
require_relative 'sentence_forming'
require_relative 'input_data_validation'

# Class for testing Markas functionality
class MarkasTest < Minitest::Test
  def test_input_data_validation_validate_valid_input
    assert_equal 55, InputDataValidation.validate(['55'], 8)
  end

  def test_input_data_validation_validate_empty_input
    assert_raises(StandardError) do
      InputDataValidator.validate([], 8)
    end
  end

  def test_input_data_validation_validate_more_than_one_input
    assert_raises(StandardError) do
      InputDataValidator.validate(%w[55 55], 8)
    end
  end

  def test_input_data_validation_validate_not_integer_input
    assert_raises(StandardError) do
      InputDataValidator.validate(['4v4'], 8)
    end
  end

  def test_input_data_validation_validate_input_data_less_than_minimum
    assert_raises(StandardError) do
      InputDataValidator.validate(['6'], 8)
    end
  end

  def test_stamp_calculation_count_calculation_valid_input
    stamps = StampCalculation.new(5, 3)
    result = stamps.calculate_high_and_low(111)
    expected_result = { high_value_count: 21, low_value_count: 2 }

    assert_equal expected_result, result
  end

  def test_stamp_calculation_count_calculation_output_sum_as_low_as_possible
    stamps = StampCalculation.new(20, 6)
    result = stamps.calculate_high_and_low(21)
    expected_result = { high_value_count: 0, low_value_count: 4 }

    assert_equal expected_result, result
  end

  def test_sentence_forming_format_both_values_positive
    both_values = SentenceForming.new(1, 3, 'divdesmit', 'trīs')
    assert_equal '1 divdesmit centu marka, 3 trīs centu markas.', both_values.output_sentence
  end

  def test_sentence_forming_format_both_values_zero
    both_zero = SentenceForming.new(0, 0, 'desmit', 'piecu')
    assert_equal 'Marku nav.', both_zero.output_sentence
  end

  def test_sentence_forming_format_only_low_value
    only_low = SentenceForming.new(3, 0, 'desmit', 'piecu')
    assert_equal '3 desmit centu markas.', only_low.output_sentence
  end

  def test_sentence_forming_format_only_high_value
    only_high = SentenceForming.new(0, 6, 'desmit', 'piecu')
    assert_equal '6 piecu centu markas.', only_high.output_sentence
  end
end
