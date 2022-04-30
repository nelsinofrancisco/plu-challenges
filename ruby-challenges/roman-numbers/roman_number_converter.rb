# frozen_string_literal: true

require('tty-box')
require_relative './utils/roman_numbers'

# rubocop:disable Metrics/MethodLength

#  CLI tool that reads user input and converts#{' '}
#  an integer into Roman numerals
class RomanNumberConverter
  include RomanNumerals

  def initialize
    num_hashes
  end

  def main
    box = TTY::Box.frame('Convert your numbers into',
                         'Roman Numerals',
                         padding: 3,
                         align: :center,
                         border: :thick,
                         title: { top_left: ' Roman-Numeral-Converter ', bottom_right: ' <3 ' })
    print "\n#{box}\n"

    loop do
      break if user_input == 'exit'
    end
  end

  private

  def number_is_valid(num)
    valid = 'valid'
    valid = "We don't zero the concept of 0,\nin Roman Numerals" if num.zero?
    valid = "The provided number: #{num}\nis out of range. Max range: 3999" if num > 3999
    valid = "We don't have the concept of negative numbers\nin Roman Numerals" if num.negative?

    return if valid == 'valid'

    error_box = TTY::Box.error(valid)
    print "\n#{error_box}\n"
    'invalid'
  end

  def parse_int(num)
    Integer(num)
  end

  def parse_base(num)
    Integer(Math.log(num, 10))
  end

  def match_num_to_roman(num, base)
    sym_base = base.to_s.to_sym
    roman_numeral_index = (num / (10**base)) - 1

    @roman_num_hash[sym_base][roman_numeral_index]
  end

  def print_success_box(num, result)
    box = TTY::Box.success("Your number: #{num} in words is:\n#{result}",
                           title: { top_left: 'Result' })
    print "\n#{box}\n"
  end

  def convert_number(num:)
    int_num = nil
    begin
      int_num = parse_int(num)
    rescue StandardError => e
      error_message = "#{e.to_s.capitalize}\n\nPlease provid a valid Integer!"
      error_box = TTY::Box.error(error_message)
      print "\n#{error_box}\n"
      return 'continue'
    end
    return 'continue' if number_is_valid(int_num) == 'invalid'

    final_num = ''
    base = parse_base(int_num)

    while base >= 0
      final_num += match_num_to_roman(int_num, base)
      int_num = int_num % (10**base)
      base -= 1
    end

    print_success_box(num, final_num)

    'exit'
  end

  def user_input
    print "Enter the integer your want to convert to Roman numeral
            \n(between 1 - 3999 range): "
    number = gets.chomp.to_s

    convert_number(num: number)
  end
end

# rubocop:enable Metrics/MethodLength
