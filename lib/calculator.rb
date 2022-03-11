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
        @log_enabled = false
        log input
    end

    def compute
        result = 0
        operand_string = ''
        operands = []
        operators = []
        loop do
            current_char = @operation_chars.peek
            if /\d/.match current_char or '.'.eql? current_char
                operand_string << current_char
            elsif /\S/.match(current_char)
                parse_operand(operand_string, operands, operators[-1])
                operand_string = ''
                if ['+', '-'].include? current_char and operands.size > 1
                    apply(operators, operands)
                end
                operators << current_char
            end
            @operation_chars.next
        end

        parse_operand(operand_string, operands, operators[-1])
        if operands.size > 1
            apply(operators, operands)
        end
        return operands[0]
    end

    def parse_operand(operand_string, operands, last_operator)
        if last_operator.eql? '/'
            operands << 1 / operand_string.to_f
        else
            operands << operand_string.to_f
        end
    end

    def apply(operators, operands)
        while operands.size > 1
            first_operand = operands.pop
            second_operand = operands.pop
            operator = operators.pop
            if ['*','/'].include? operator
                operands << second_operand * first_operand
            elsif operator.eql? '+'
                operands << second_operand + first_operand
            elsif operator.eql? '-'
                operands << second_operand - first_operand
            end
        end
    end

    def log(message)
        if @log_enabled
            puts message
        end
    end
end

