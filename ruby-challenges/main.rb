# frozen_string_literal: true

require('tty-box')

require_relative './cardinal-numbers/cardinal_converter'
require_relative './roman-numbers/roman_number_converter'
require_relative './rpn-evaluator/rpn_eval'

# rubocop:disable Metrics/MethodLength

# CLI app with all the three interview-challenges
class PlathanusChallenges
  def initialize
    @roman_converter = RomanNumberConverter.new
    @rpn_converter = RpnEval.new
    @number_to_words_converter = CardinalConverter.new
  end

  def main
    box = TTY::Box.frame('My solution to the provided challenges',
                         'Please select a option from the list',
                         padding: 3,
                         align: :center,
                         border: :thick,
                         title: { top_left: ' Ruby-Challenges ', bottom_right: ' <3 ' })
    print "\n#{box}\n"

    is_looping = true

    while is_looping == true
      menu
      user_input = gets.chomp.to_s
      is_looping = run_challenge_with_input(user_input)
    end
  end

  private

  def run_challenge_with_input(option)
    case option
    when '1'
      @roman_converter.main
      true
    when '2'
      @rpn_converter.main
      true
    when '3'
      @number_to_words_converter.main
      true
    when 'exit'
      false
    else
      puts "That's not a valid option!"
      true
    end
  end

  def menu
    puts "\nPlease enter a number [1-3] to select run the given app"
    puts "\t[1] - Integer to Roman Converter"
    puts "\t[2] - RPN expression calculator"
    puts "\t[3] - Integer to English Words COnverter"
    puts "If you want to exit this app type: 'exit' "
    print 'Please enter your option: '
  end
end

# rubocop:enable Metrics/MethodLength

PlathanusChallenges.new.main
