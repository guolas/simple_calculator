require 'test/unit'
require 'calculator.rb'

class CalculatorTest < Test::Unit::TestCase
    def test_parse_simple_input
        result = Calculator.parse '2 + 2'
        assert_equal [2, '+', 2], result
    end

    def test_parse_longer_input
        result = Calculator.parse '121/11/4*6+36-8/2'
        assert_equal [121, '/', 11.0, '/', 4, '*', 6, '+', 36, '-', 8, '/', 2.0], result
    end

    def test_sum_two_positive_numbers
        result = Calculator.calculate [2, '+', 2]
        assert_equal 4, result
    end

    def test_times_two_positive_numbers
        result = Calculator.calculate [3, '*', 7]
        assert_equal 21, result
    end

    def test_number_plus_number_times_number
        result = Calculator.calculate [1, '+', 3, '*', 5]
        assert_equal 16, result
    end

    def test_one_operand
        result = Calculator.calculate [37]
        assert_equal 37, result
    end

    def test_multiple_operations
        result = Calculator.calculate [2, '+', 3, '*', 5, '+', 7, '+', 31, '+', 93, '*', 11]
        assert_equal 1078, result
    end

    def test_division_two_numbers
        result = Calculator.calculate [35, '/', 2.0]
        assert_equal 17.5, result
    end
    
    def test_chained_division
        result = Calculator.calculate [121, '/', 11.0, '/', 4.0]
        assert_equal 2.75, result
    end

    def test_mixed_operations
        result = Calculator.calculate [121, '/', 11.0, '/', 4.0, '*', 6, '+', 36, '-', 8, '/', 2.0]
        assert_equal 48.5, result
    end

    def test_sum_decimal_numbers
        result = Calculator.calculate [2.5, '+', 3.75]
        assert_equal 6.25, result
    end

    def test_multiplication_decimal_numbers
        result = Calculator.calculate [2.5, '*', 3.75]
        assert_equal 9.375, result
    end

    def test_division_decimal_numbers
        result = Calculator.calculate [6, '/', 0.75]
        assert_equal 8, result
    end

    def test_parse_and_calculate
        result = Calculator.calculate(Calculator.parse('121/11/4 * 6 +36-8/2'))
        assert_equal 48.5, result
    end
end
