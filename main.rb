# frozen_string_literal: true

# rubocop:disable Style/MixinUsage

require_relative 'module_enumerable.rb'
include Enumerable

puts %w[ant bear cat].my_all? { |word| word.length >= 3 } 
puts %w[ant bear cat].my_all? { |word| word.length >= 4 }
puts %w[ant bear cat].my_all?(/t/)
puts [1, 2i, 3.14].my_all?(Numeric)
puts [nil, true, 99].my_all?
puts [].all?