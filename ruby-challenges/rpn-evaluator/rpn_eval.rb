# frozen_string_literal: true

require('tty-box')

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize

#  CLI tool that reads user input and evaluate#{' '}
#  a reverse polish notation expression, giving#{' '}
#  the value of the expression back to the user#{' '}
#  in the command line.
class RpnEval
  attr_reader :rpn_expression

  def initialize
    @rpn_expression = ''
    @rpn_array = []
    @rpn_stack = []
    @operators_hash = {
      "+": ->(num1, num2) { return num1 + num2 },
      "-": ->(num1, num2) { return num1 - num2 },
      "*": ->(num1, num2) { return num1 * num2 },
      "/": ->(num1, num2) { return num1 / num2 },
      "%": ->(num1, num2) { return num1 % num2 },
      "^": ->(num1, num2) { return num1**num2 }
    }
  end

  def main
    box = TTY::Box.frame('Welcome to Reverse Polish Notation',
                         'CLI tool evaluator',
                         padding: 3,
                         align: :center,
                         border: :thick,
                         title: { top_left: ' RPN EVALUATOR ', bottom_right: ' <3 ' })
    print "\n#{box}\n"
    loop do
      expression = if @rpn_expression.empty?
                     "''"
                   else
                     @rpn_expression
                   end

      puts "Current Expression: #{expression}"
      if @rpn_expression.split(' ').length < 2
        print 'Please enter a valid number: '
      else
        print 'Please enter a valid number or a operand: '
      end

      break if user_input == 'exit'
    end
  end

  private

  def evaluate_expression
    @rpn_expression += '= '
    @rpn_array.push('=')
    right = @rpn_array.length - 1
    left = 0
    result = nil

    while left < right
      curr_exp_value = @rpn_array[left]

      if curr_exp_value.instance_of?(String)
        result = 'error'
        break if left < 2

        number2 = @rpn_stack.pop
        number1 = @rpn_stack.pop

        result = @operators_hash[curr_exp_value.to_sym].call(number1, number2)

        @rpn_stack.push(result)
      else
        @rpn_stack.push(curr_exp_value)
      end
      left += 1
    end

    if @rpn_stack.length > 1 || result == 'error'
      error_message = 'We could not fully evaluate the expression.'
      error_message += "\nPlease verify if you are performing operations between every group
                        of numbers in the RPN expression."
      print TTY::Box.error(error_message, title: { top_left: 'Evaluation error!' })
      @rpn_expression = ''
      @rpn_stack = []
      @rpn_array = []
    else
      expression = @rpn_expression.to_s
      @rpn_expression = ''
      result = format('%.3f', @rpn_stack.pop.round(3))
      @rpn_stack = []
      @rpn_array = []
      print TTY::Box.success("The expression #{expression}
                              \nwas successfully evaluated, the result is: #{result}",
                             title: { top_left: 'Result' })
    end
    'exit'
  end

  def add_operator(operator:)
    @rpn_expression += "#{operator} "
    @rpn_array.push(operator)
    'continue'
  end

  def add_operand(operand:)
    operand_to_float = Float(operand)
    @rpn_expression += "#{operand} "
    @rpn_array.push(operand_to_float)
    'continue'
  end

  def user_input
    user_input = gets.chomp.to_s

    if /=/.match(user_input) && user_input.length == 1
      evaluate_expression
    elsif %r{[-+*/%^]}.match(user_input) && user_input.length == 1
      add_operator(operator: user_input)
    else
      begin
        add_operand(operand: user_input)
      rescue StandardError => e
        error_message = "#{e.to_s.capitalize}\n\nPlease provid a valid number!"
        error_box = TTY::Box.error(error_message)
        print "\n#{error_box}\n"
        'continue'
      end
    end
  end
end

# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
