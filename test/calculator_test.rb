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
end