# frozen_string_literal: true

# Class for stamp calculation
class StampCalculation
  def initialize(high_value, low_value)
    @high = high_value
    @low = low_value
  end

  # Calculate the number of high-value and low-value stamps needed
  def calculate_high_and_low(input_value)
    stamp_count = count_and_leftover(input_value)

    while modulo(stamp_count[:left_over], @low) != 0
      if stamp_count[:count_high].positive?
        stamp_count = update_stamp_count(stamp_count)
      else
        input_value += 1
        stamp_count = count_and_leftover(input_value)
      end
    end

    { high_value_count: stamp_count[:count_high], low_value_count: stamp_count[:count_low] }
  end

  private

  def division(number, divider)
    number / divider
  end

  def modulo(number, divider)
    number % divider
  end

  def count_and_leftover(spending)
    h = division(spending, @high)
    left = modulo(spending, @high)
    l = division(left, @low)
    { count_high: h, count_low: l, left_over: left }
  end

  def update_stamp_count(stamp_count)
    stamp_count[:count_high] -= 1
    stamp_count[:left_over]  += @high
    stamp_count[:count_low] = division(stamp_count[:left_over], @low)
    stamp_count
  end
end
