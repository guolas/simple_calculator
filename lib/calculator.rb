class CALCULATOR
    class << self
        def compute(input)
            Core.new(input).compute
        end
    end
end

class Core
    def initialize(input)
        @operation = input
        @operand = true
        @operator = false
    end

    def compute()
        operation_enum = @operation.each_char
        result = 0
        operand_string = ''
        stack = []
        multiplication = false
        loop do
            current_char = operation_enum.peek
            if /\d/.match(current_char)
                operand_string << current_char
            elsif /\S/.match(current_char)
                if stack.size > 0
                    first_operand = stack.pop
                    second_operand = operand_string.to_i
                    if multiplication
                        stack << first_operand * second_operand
                    else
                        stack << first_operand + second_operand
                    end
                else
                    stack << operand_string.to_i
                end
                operand_string = ''
                multiplication = current_char.eql? '*'
            end
            puts '--------'
            puts @operation
            puts 'Current char ' + operation_enum.peek
            puts stack
            operation_enum.next
        end

        if stack.size > 0
            first_operand = stack.pop
            second_operand = operand_string.to_i
            if multiplication
                stack << first_operand * second_operand
            else
                stack << first_operand + second_operand
            end
        end
        puts 'Result ' + stack[0].to_s
        return stack[0]
    end
end