module Calculator
    def Calculator.log_enabled
        return false
    end

    def Calculator.parse(input)
        parsed_input = []
        operation_chars = input.each_char
        operand_string = ''
        loop do
            current_char = operation_chars.peek
            if /\d/.match current_char or '.'.eql? current_char
                operand_string << current_char
            elsif /\S/.match(current_char)
                if ['+','-','*','/'].include? current_char
                    parsed_input << operand_string.to_f
                    parsed_input << current_char
                    operand_string = ''
                else
                    log 'Unexpected character in input'
                end
            end
            operation_chars.next
        end
        parsed_input << operand_string.to_f
        return parsed_input
    end

    def Calculator.calculate(input)
        log input.to_s
        elements = input.each
        operands = []
        operators = []
        loop do
            element = elements.peek
            if ['+', '-'].include? element
                compute(operands, operators)
                operators << element
            elsif ['*', '/'].include? element
                operators << element
            else
                if operators.size > 0 and '/'.eql? operators[-1]
                    element = 1 / element.to_f
                end
                operands << element
            end
            elements.next
        end
        compute(operands, operators)
        return operands[0]
    end
   
    def Calculator.compute(operands, operators)
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

    def Calculator.log(message)
        if log_enabled
            puts message
        end
    end
end

