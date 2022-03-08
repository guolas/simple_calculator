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
            puts '--------'
            puts @operation
            puts 'Current char ' + operation_enum.peek
            puts 'Multiplication ' + multiplication.to_s
            puts 'Stack before ' + stack.to_s
            current_char = operation_enum.peek
            if /\d/.match(current_char)
                operand_string << current_char
            elsif /\S/.match(current_char)
                stack << operand_string.to_i
                operand_string = ''
                if multiplication
                    puts 'Multiplication'
                    first_operand = stack.pop
                    second_operand = stack.pop
                    stack << first_operand * second_operand
                    if stack.size > 1
                        puts 'Additional operand... sum'
                        first_operand = stack.pop
                        second_operand = stack.pop
                        stack << first_operand + second_operand
                    end
                end
                multiplication = current_char.eql? '*'
                if multiplication
                    puts 'Multiplication after ' + multiplication.to_s
                    puts 'Stack after ' + stack.to_s
                    operation_enum.next
                    next
                elsif stack.size > 1
                    puts 'Addition, with an operand before'
                    first_operand = stack.pop
                    second_operand = stack.pop
                    stack << first_operand + second_operand
                end
            end
            puts 'Multiplication after ' + multiplication.to_s
            puts 'Stack after ' + stack.to_s
            operation_enum.next
        end

        puts 'Stack before ' + stack.to_s
        stack << operand_string.to_i
        puts 'Stack after ' + stack.to_s
        if stack.size > 1
            first_operand = stack.pop
            second_operand = stack.pop
            if multiplication
                stack << first_operand * second_operand
                if stack.size > 1
                    puts 'Additional operand... sum'
                    first_operand = stack.pop
                    second_operand = stack.pop
                    stack << first_operand + second_operand
                end
            else
                stack << first_operand + second_operand
            end
        end
        puts 'Result ' + stack[0].to_s
        return stack[0]
    end
end