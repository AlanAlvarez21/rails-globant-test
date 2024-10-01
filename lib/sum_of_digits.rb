class SumOfDigits
    def self.sum(number)
      while number >= 10
        number = number.to_s.chars.map(&:to_i).sum
      end
      number
    end
end
  