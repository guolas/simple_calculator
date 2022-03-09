class CALCULATOR
    class << self
        def compute(input)
            Core.new(input).compute
        end
    end
end

class Core
    def initialize(input)
        @operation = input.each_char
        @operand = true
        @log_enabled = false
    end

    def compute
        result = 0
        operand_string = ''
        stack = []
        multiplication = false
        loop do
            log '--------'
            log @operation
            log('Current char ' + @operation.peek)
            log('Multiplication ' + multiplication.to_s)
            log('Stack before ' + stack.to_s)
            current_char = @operation.peek
            if /\d/.match(current_char)
                operand_string << current_char
            elsif /\S/.match(current_char)
                stack << operand_string.to_i
                operand_string = ''
                if multiplication
                    multiply stack
                end
                multiplication = current_char.eql? '*'
                if not multiplication and stack.size > 1
                    log 'Addition, with an operand before'
                    sum stack
                end
            end
            log 'Multiplication after ' + multiplication.to_s
            log 'Stack after ' + stack.to_s
            @operation.next
        end

        log('Stack before ' + stack.to_s)
        stack << operand_string.to_i
        log('Stack after ' + stack.to_s)
        if stack.size > 1
            if multiplication
                multiply stack
            else
                sum stack
            end
        end
        log('Result ' + stack[0].to_s)
        return stack[0]
    end

    def multiply(stack)
        log 'Multiplication'
        first_operand = stack.pop
        second_operand = stack.pop
        stack << first_operand * second_operand
        if stack.size > 1
            log 'Additional operand... sum'
            first_operand = stack.pop
            second_operand = stack.pop
            stack << first_operand + second_operand
        end
    end

    def sum(stack)
        first_operand = stack.pop
        second_operand = stack.pop
        stack << first_operand + second_operand
    end

    def log(message)
        if @log_enabled
            puts message
        end
    end
end

