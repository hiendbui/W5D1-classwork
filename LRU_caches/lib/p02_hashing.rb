class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    new_arr = self.dup.map(&:object_id)
    new_arr.join.to_i
  end
end

class String
  def hash
    alpha = ("a".."z").to_a
    new_arr = self.dup.split("").map {|ele| alpha.index(ele)}
    new_arr.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    alpha = ("a".."z").to_a
    new_arr = self.dup.to_a.sort.map do |sub_arr| 
      [alpha.index(sub_arr[0].to_s), type_check(sub_arr[1])]
    end
    new_arr.join.to_i
  end

  def type_check(ele)
    alpha = ("a".."z").to_a
    if ele.is_a?(Integer)
      return ele.object_id
    else
      alpha.index(ele)
    end
  end
end
