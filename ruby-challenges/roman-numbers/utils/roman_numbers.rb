# frozen_string_literal: true

# This module stores a method that provides
# hash instance variables with arrays for all
# roman numerals
module RomanNumerals
  def num_hashes
    @roman_num_hash = {
      "0": %w[I II III IV V VI VII VIII IX],
      "1": %w[X XX XXX XL L LX LXX LXXX XC],
      "2": %w[C CC CCC CD D DC DCC DCCC CM],
      "3": %w[M MM MMM]
    }
  end
end
