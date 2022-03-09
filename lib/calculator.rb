class CALCULATOR
    class << self
        def compute(input)
            Core.new(input).compute
        end
    end
end

class Core
    def initialize(input)
        @operation_chars = input.each_char
        @operand = true
        @log_enabled = true
        log input
    end

    def compute
        result = 0
        operand_string = ''
        operands = []
        operators = []
        loop do
            current_char = @operation_chars.peek
            if /\d/.match(current_char)
                operand_string << current_char
            elsif /\S/.match(current_char)
                operands << operand_string.to_i
                operand_string = ''
                if current_char.eql? '+' and operands.size > 1
                    apply(operators, operands)
                end
                operators << current_char
            end
            @operation_chars.next
        end

        operands << operand_string.to_i
        if operands.size > 1
            apply(operators, operands)
        end
        return operands[0]
    end

    def apply(operators, operands)
        while operands.size > 1
            first_operand = operands.pop
            second_operand = operands.pop
            operator = operators.pop
            if operator.eql? '*'
                operands << first_operand * second_operand
            elsif operator.eql? '+'
                operands << first_operand + second_operand
            end
        end
    end

    def log(message)
        if @log_enabled
            puts message
        end
    end
end

