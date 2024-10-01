require 'spec_helper'
require_relative '../lib/sum_of_digits'

RSpec.describe SumOfDigits do
    describe '.sum' do
      it 'calculates the sum of digits and returns 7 for input 16' do
        expect(SumOfDigits.sum(16)).to eq(7)
      end

      it 'calculates the sum of digits and returns 6 for input 942' do
        expect(SumOfDigits.sum(942)).to eq(6)
      end

      it 'calculates the sum of digits and returns 9 for input 9999999999' do
        expect(SumOfDigits.sum(9999999999)).to eq(9)
      end

      it 'calculates the sum of digits and returns 1 for input 10' do
        expect(SumOfDigits.sum(10)).to eq(1)
      end

      it 'calculates the sum of digits and returns 9 for input 81' do
        expect(SumOfDigits.sum(81)).to eq(9)
      end

      it 'calculates the sum of digits and returns 0 for input 0' do
        expect(SumOfDigits.sum(0)).to eq(0)
      end

      it 'calculates the sum of digits and returns 9 for input 9' do
        expect(SumOfDigits.sum(9)).to eq(9)
      end

      it 'calculates the sum of digits and returns 9 for input 18' do
        expect(SumOfDigits.sum(18)).to eq(9)
      end

      it 'calculates the sum of digits and returns 2 for input 11' do
        expect(SumOfDigits.sum(11)).to eq(2)
      end
    end
end
