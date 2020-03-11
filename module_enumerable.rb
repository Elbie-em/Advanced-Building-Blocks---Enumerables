# frozen_string_literal: true

# THIS MODULE CONSISTS OF REPLICATED ENUMERABLE METHODS IN RUBY
module Enumerable
  def my_each
    return to_enum :add unless block_given?

    obj = self
    itr = 0
    loop do
      case obj
      when Array
        yield(obj[itr])
        itr += 1
        break if itr == obj.length
      when Hash
        yield(obj.keys[itr], obj[obj.keys[itr]])
        itr += 1
        break if itr == obj.size
      else
        obj
      end
    end
    obj
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    obj = self
    itr = 0
    loop do
      case obj
      when Array
        yield(obj[itr], itr)
        itr += 1
        break if itr == obj.length
      when Hash
        yield(obj.keys[itr], itr)
        itr += 1
        break if itr == obj.size
      else
        return obj
      end
    end
    obj
  end

  def my_select
    return to_enum :my_select unless block_given?

    obj = self
    arr_obj = []
    hash_obj = {}
    case obj
    when Array
      obj.my_each do |value|
        arr_obj.push(value) if yield(value) == true
      end
    when Hash
      obj.my_each do |key, value|
        hash_obj.store(key, value) if yield(key, value) == true
      end
    else
      obj
    end
    if obj.is_a? Array
      arr_obj
    else
      hash_obj
    end
  end
end