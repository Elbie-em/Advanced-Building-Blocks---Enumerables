require_relative 'module_enumerable.rb'
include Enumerable

# TEST DATA STRUCTURES
a = { 'a' => 8, 'b' => 2, 'c' => 5 }
b = [1, 3, 5, 7]
ary = [1, 2, 4, 2]
animals = %w[(ant bear cat)])

# CASE 1: Testing of inject method
def multiply_els(my_array)
  my_array.my_inject { |result, value| result * value }
end

# CASE 1.a:Testing of multiply_els method
p 'RESULTS FROM TESTING MULTIPLY_ELS'
p multiply_els([2, 4, 5])

# CASE 2:Testing of my_each method
p 'RESULTS FROM TESTING MY_EACH'
a.my_each { |key, value| p "#{key}: #{value}" }
b.my_each { |value| p value }

# CASE 2:Testing of my_each_with_index method
p 'RESULTS FROM TESTING MY_EACH_WITH INDEX'
a.my_each_with_index { |key, index| p "#{key}: #{index}" }
b.my_each_with_index { |value, index| p "#{value}: #{index}" }

# CASE 3:Testing of my_select method
p 'RESULTS FROM TESTING MY_SELECT'
p [1, 2, 3, 4, 5].my_select(&:even?)
p %w[foo bar].my_select { |x| x == 'foo' }

# CASE 4:Testing of my_all method
p 'RESULTS FROM TESTING MY_ALL'
p animals.my_all? { |word| word.length >= 3 } #=> true
p animals.my_all? { |word| word.length >= 4 } #=> false
p animals.my_all?(/t/) #=> false
p [1, 2i, 3.14].my_all?(Numeric) #=> true
p [nil, true, 99].my_all? #=> false
p [].my_all? #=> true

# CASE 5:Testing of my_any method
p 'RESULTS FROM TESTING MY_ANY'
p animals.my_any? { |word| word.length >= 3 } #=> true
p animals.my_any? { |word| word.length >= 4 } #=> true
p animals.my_any?(/d/) #=> false
p [nil, true, 99].my_any?(Integer) #=> true
p [nil, true, 99].my_any? #=> true
p [].my_any? #=> false

# CASE 6:Testing of my_none method
p 'RESULTS FROM TESTING MY_NONE'
p animals.my_none? { |word| word.length == 5 } #=> true
p animals.my_none? { |word| word.length >= 4 } #=> false
p animals.my_none?(/d/) #=> true
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false

# CASE 7:Testing of my_count method
p 'RESULTS FROM TESTING MY_COUNT'
p ary.count #=> 4
p ary.count(2) #=> 2
p ary.count(&:even?) #=> 3

# CASE 8:Testing of my_map with proc and block method
p 'RESULTS FROM TESTING MY_MAP'
my_proc = proc { |i| i * 2 }
p (1..4).map { |i| i * i } #=> [1, 4, 9, 16]
p (1..4).map(&my_proc) #=> [2, 4, 6, 8]

# CASE 9:Testing of my_inject
p 'RESULTS FROM TESTING MY_INJECT'
p (5..10).my_inject { |sum, n| sum + n } #=> 45
p (5..10).my_inject(2) { |sum, n| sum * n } #=> 90
# find the longest word
longest = %w[cat sheep bear].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
p longest
# find the longest word and duplicate it
longest_mult = %w[cat sheep bear].my_inject(5) do |memo, word|
  memo.length > word.length ? memo : word
end
p longest_mult
