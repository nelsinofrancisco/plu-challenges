# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Naming/VariableNumber

# This module stores a method that provides
# hash instance variables with number keys that matches
# a corresponding word in English.
module Cardinals
  def card_hashes
    @up_to_99 = {
      "0": 'zero',
      "1": 'one',
      "2": 'two',
      "3": 'three',
      "4": 'four',
      "5": 'five',
      "6": 'six',
      "7": 'seven',
      "8": 'eight',
      "9": 'nine',
      "10": 'ten',
      "11": 'eleven',
      "12": 'twelve',
      "13": 'thirteen',
      "14": 'fourteen',
      "15": 'fifteen',
      "16": 'sixteen',
      "17": 'seventeen',
      "18": 'eighteen',
      "19": 'nineteen',
      "20": 'twenty',
      "30": 'thirty',
      "40": 'forty',
      "50": 'fifty',
      "60": 'sixty',
      "70": 'seventy',
      "80": 'eighty',
      "90": 'ninety'
    }

    @up_to_decillion = {
      "100": 'hundred',
      "1000": 'thousand',
      "1000000": 'million',
      "1000000000": 'billion',
      "1000000000000": 'trillion',
      "1000000000000000": 'quadrillion',
      "1000000000000000000": 'quintillion',
      "1000000000000000000000": 'sextillion',
      "1000000000000000000000000": 'septillion',
      "1000000000000000000000000000": 'octillion',
      "1000000000000000000000000000000": 'nonillion',
      "1000000000000000000000000000000000": 'decillion'
    }
  end
end

# rubocop:enable Metrics/MethodLength, Naming/VariableNumber
