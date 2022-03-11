require 'test/unit'
require 'calculator.rb'

class CALCULATORTest < Test::Unit::TestCase
    def test_sum_two_positive_numbers
        result = CALCULATOR.compute '2 + 2'
        assert_equal 4, result
    end

    def test_times_two_positive_numbers
        result = CALCULATOR.compute '3 * 7'
        assert_equal 21, result
    end

    def test_number_plus_number_times_number
        result = CALCULATOR.compute '1 + 3 * 5'
        assert_equal 16, result
    end

    def test_one_operand
        result = CALCULATOR.compute '37'
        assert_equal 37, result
    end

    def test_multiple_operations
        result = CALCULATOR.compute '2 + 3 * 5 + 7 + 31 + 93*11'
        assert_equal 1078, result
    end

    def test_division_two_numbers
        result = CALCULATOR.compute '35 / 2'
        assert_equal 17.5, result
    end
    
    def test_chained_division
        result = CALCULATOR.compute '121 / 11/4'
        assert_equal 2.75, result
    end

    def test_mixed_operations
        result = CALCULATOR.compute '121/11/4*6+36-8/2'
        assert_equal 48.5, result
    end
end
