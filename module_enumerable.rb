# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength

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

  def my_all?(param = nil)
    obj = self
    result = false
    if block_given? && param.nil?
      obj.my_each do |value|
        return false if yield(value) != true
      end
    elsif param.is_a? Class
      obj.my_each do |value|
        result = if value.is_a? param
                   true
                 else
                   false
                 end
      end
    elsif param.is_a? Regexp
      obj.my_each do |value|
        result = if value =~ param
                   true
                 else
                   false
                 end
      end
    elsif obj.empty? && param.nil?
      result = true
    else
      obj.my_each do |value|
        result = if value.nil? || value != true
                   false
                 else
                   true
                 end
      end
    end
    result
  end

  def my_any?(param = nil)
    obj = self
    result = false
    if block_given? && param.nil?
      obj.my_each do |value|
        return true if yield(value)
      end
    elsif param.is_a? Class
      obj.my_each do |value|
        result = true if value.is_a? param
      end
    elsif param.is_a? Regexp
      obj.my_each do |value|
        result = true if value =~ param
      end
    elsif obj.empty? && param.nil?
      result = false
    else
      obj.my_each do |value|
        result = true if value.nil? || !value
      end
    end
    result
  end

  def my_none?(param = nil)
    obj = self
    result = true
    if block_given? && param.nil?
      obj.my_each do |value|
        result = false if yield(value)
      end
    elsif param.is_a? Class
      obj.my_each do |value|
        result = false if value.is_a? param
      end
    elsif param.is_a? Regexp
      obj.my_each do |value|
        result = false if value =~ param
      end
    elsif obj.empty? && param.nil?
      result = true
    else
      obj.my_each do |value|
        result = if value.nil? || !value
                   true
                 else
                   false
                 end
      end
    end
    result
  end

  def my_count(param = nil)
    obj = self
    itr = 0
    if block_given? && param.nil?
      obj.my_each do |value|
        itr += 1 if yield(value)
      end
    end
    if param.is_a? Integer or param.is_a? Float or param.is_a? String
      obj.my_each do |value|
        itr += 1 if value == param
      end
    end
    if param.is_a? Regexp
      obj.my_each do |value|
        itr += 1 if value == param
      end
    end
    itr = obj.length if !block_given? && param.nil?
    itr
  end

  def my_map
    return to_enum :my_map unless block_given?
    obj = self
    obj = obj.to_a
    my_array = []
    obj.my_each do |value|
      my_array.push(yield(value))
    end
    my_array
  end

  def my_inject(param = nil)
    obj = self
    obj = obj.to_a
    itr = 0
    result = obj[itr]
    if block_given?
      loop do
        result = yield(result, obj[itr + 1])
        itr += 1
        break if itr == obj.length - 1
      end
    end
    if !param.nil?
      result = result * param
    end
    result
  end

end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength:
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
