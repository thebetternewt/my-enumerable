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
end
