class MaxIntSet
  attr_accessor :store, :max

  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    if num > max || num < 0
      raise 'Out of bounds'
    elsif !@store.include?(num)
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end

end


class IntSet
  attr_accessor :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    store[num % num_buckets] << num 
    
  end

  def remove(num)
    store[num%num_buckets].delete_if {|n| n == num }
  end

  def include?(num)
    self[num].include?(num)
      
  end

  private

  def [](num)
    @store[num % num_buckets]  # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count 

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      @store[num % num_buckets] << num 
      @count += 1
    end
    if count > num_buckets
      resize!
    end
  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete_if {|n| n == num }
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
    
  end

  private

  def [](num)
   @store[num % num_buckets] # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
      old_nums = @store.dup.flatten
      old_nums.each do |num|
        remove(num)
      end

      new_num = num_buckets*2

      @store = Array.new(new_num) { Array.new }
      @store.inspect
      old_nums.each do |num|
        insert(num)
      end
  end
  
end
