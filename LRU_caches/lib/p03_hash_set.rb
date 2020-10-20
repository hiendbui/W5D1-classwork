class HashSet
  attr_reader :count
  
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @store[key.hash % num_buckets] << key
    @count += 1
    if @count > num_buckets
      resize!
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      @store[key.hash % num_buckets].delete_if {|n| n == key }
      @count -= 1
    end

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
    
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
