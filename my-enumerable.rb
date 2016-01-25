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
end
