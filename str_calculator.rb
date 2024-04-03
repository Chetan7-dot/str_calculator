class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiters = [",", "\n"]
    custom_delimiter = numbers[2..numbers.index("\n") - 1] if numbers.start_with?("//")
    delimiters << custom_delimiter if custom_delimiter

    nums = numbers.split(Regexp.union(delimiters)).map(&:to_i)
    raise "negative numbers not allowed #{nums.select(&:negative?).join(',')}" if nums.any?(&:negative?)
    nums.sum
  end
end

require 'rspec/autorun'


RSpec.describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  describe "#add" do
    context "with an empty string" do
      it "returns 0" do
        expect(calculator.add("")).to eq(0)
      end
    end

    context "with a single number" do
      it "returns the number" do
        expect(calculator.add("1")).to eq(1)
      end
    end

    context "with two numbers" do
      it "returns the sum of the numbers" do
        expect(calculator.add("1,5,4,6")).to eq(16)
      end
    end

    context "with new line delimiter" do
      it "returns the sum of the numbers" do
        expect(calculator.add("1\n2,3")).to eq(6)
      end
    end

    context "with custom delimiter" do
      it "returns the sum of the numbers" do
        expect(calculator.add("//;\n1;2")).to eq(3)
      end
    end

    context "with negative numbers" do
      it "raises an exception" do
        expect { calculator.add("-1,2,-3") }.to raise_error(RuntimeError, "negative numbers not allowed -1,-3")
      end
    end
  end
end
