class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash

    output = []
    output << 0.hash if self.empty?
    self.each_with_index do |el, i|
      output << (el.hash / i.hash).hash
    end

    output.inject(:+)
  end
end

class String
  def hash
    output =[]
    self.each_char do |char|
      output << char.ord.hash / self.index(char).hash
    end
    output.inject(:+)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.hash
  end
end
