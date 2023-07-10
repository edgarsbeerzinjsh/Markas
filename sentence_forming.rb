# frozen_string_literal: true

# Class to build and output a sentence based on given counts and words.
class SentenceForming
  def initialize(high_count, low_count, high_word, low_word)
    @high_count = high_count
    @low_count = low_count
    @high_word = high_word
    @low_word = low_word
  end

  def output_sentence
    sentence = []

    @high_count != 0 && sentence.push(form_sentence_part(@high_count, @high_word))
    @low_count != 0 && sentence.push(form_sentence_part(@low_count, @low_word))

    sentence.empty? ? 'Marku nav.' : "#{sentence.join(', ')}."
  end

  private
  def form_sentence_part(count, word)
    "#{count} #{word} centu marka#{plural_check(count)}"
  end

  def plural_check(count)
    count % 10 == 1 && count % 100 != 11 ? '' : 's'
  end
end
