module Enumerable
  def my_each
    if block_given?
      i = 0
      while i < self.size
        yield(self[i])
        i += 1
      end
    end
    self
  end

  def my_each_with_index
    if block_given?
      i = 0
      while i < self.size
        yield(self[i], i)
        i += 1
      end
    end
    self
  end

  def my_select
    arr = []
    if block_given?
      self.my_each { |item| yield(item) ? arr << item : nil}
      arr
    else
      self
    end
  end

  def my_all?
    if block_given?
      self.my_each { |item| yield(item) ? nil : (return false) }
      true
    else
      true
    end
  end

  def my_any?
    if block_given?
      self.my_each { |item| yield(item) ? (return true) : nil }
      false
    else
      true
    end
  end

  def my_none?
    if block_given?
      self.my_each { |item| yield(item) ? (return false) : nil }
      true
    else
      false
    end
  end

  def my_count(*match)
    match_count = 0
    if !match.empty?
      self.my_each { |item| item == match[0] ? match_count += 1 : nil }
      return match_count
    elsif block_given?
      self.my_each { |item| yield(item) ? match_count += 1: nil }
      return match_count
    else
      self.my_each { |item| match_count += 1 }
      match_count
    end
  end

  def my_map
    if block_given?
      arr = []
      self.my_each { |item| arr << yield(item) }
      return arr
    end
    self
  end

  def my_map!
    if block_given?
      self.my_each_with_index { |item, index| self[index] = yield(item) }
    end
    self
  end

  def my_map2(proc) #Must take a proc, can also accept a block.
    arr = []
    self.my_each { |item| arr << proc.call(item) }
    block_given? ? yield : nil;
    return arr
  end

  def my_inject(*input)
    self.class == Range ? (self_arr = Array (self)) : self_arr = self #Convert input to array.
    input.empty? ? final_value = self_arr[0] : (final_value = input[0])
    self_arr.my_each { |item| final_value = yield(final_value, item) }
    final_value
  end

end
