# frozen_string_literal: true

require('tty-box')
require_relative './utils/cardinals'

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize

#  CLI tool that reads user input and converts#{' '}
#  an integer into english words
class CardinalConverter
  include Cardinals

  def initialize
    num_hashes
  end

  def main
    box = TTY::Box.frame('Convert your numbers into',
                         'American english words',
                         padding: 3,
                         align: :center,
                         border: :thick,
                         title: { top_left: ' Numbers-to-Words ', bottom_right: ' <3 ' })
    print "\n#{box}\n"

    loop do
      break if user_input == 'exit'
    end
  end

  private

  def format_result(result_str:)
    up_to_decillion_values = @up_to_decillion.values
    word_numbers = result_str.split(' ')

    result = ''

    word_numbers.each do |word|
      result += "#{word} "
      result += "\n" if up_to_decillion_values.include?(word)
    end

    result
  end

  def convert_dozens_to_words(num:)
    if @up_to_99[num.to_s.to_sym]
      (@up_to_99[num.to_s.to_sym]).to_s
    else
      dozens = (num / 10) * 10
      unit = num % 10
      "#{@up_to_99[dozens.to_s.to_sym]}-#{@up_to_99[unit.to_s.to_sym]}"
    end
  end

  def convert_hundreds_to_words(num:)
    hundreds = (num / 100).round
    remainder = num % 100

    result = "#{convert_dozens_to_words(num: hundreds)} #{@up_to_decillion['100'.to_sym]}"
    result += " #{convert_dozens_to_words(num: remainder)}" if remainder != 0
    result
  end

  def convert_to_words(num:)
    curr_num = num
    result = ''

    while curr_num.positive?
      place = 1000
      if curr_num > 1000
        # get the hundreds convert them
        place *= 1000 while place * 1000 <= curr_num
        place_number = curr_num / place

        result += if place_number < 100
                    "#{convert_dozens_to_words(num: place_number)} #{@up_to_decillion[place.to_s.to_sym]} "
                  else
                    "#{convert_hundreds_to_words(num: place_number)} #{@up_to_decillion[place.to_s.to_sym]} "
                  end

        curr_num = curr_num % place
      elsif curr_num > 100
        result += convert_hundreds_to_words(num: curr_num).to_s
        curr_num = 0
      else
        result += convert_dozens_to_words(num: curr_num).to_s
        curr_num = 0
      end
    end

    print "\n#{TTY::Box.success("Your number: #{num} in words is:
    \n#{format_result(result_str: result)}",
                         title: { top_left: 'Result' })}\n"
  end

  def user_input
    print 'Enter the integer your want to convert (You can use underscores to separate digit groups): '
    number = gets.chomp.to_s
    begin
      number_to_int = Integer(number)
      convert_to_words(num: number_to_int)
      'exit'
    rescue StandardError => e
      error_message = "#{e.to_s.capitalize}\n\nPlease provid a valid Integer!"
      error_box = TTY::Box.error(error_message)
      print "\n#{error_box}\n"
      'continue'
    end
  end
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
