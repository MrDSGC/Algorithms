require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    resize! if @count > @store.length
    @store[(key.hash) % @store.length] << key
  end

  def include?(key)
    @store[(key.hash) % @store.length].include?(key)
  end

  def remove(key)
    @count -= 1
    @store[(key.hash) % @store.length].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 1
    temp_store.each do |el|
      el.each { |el_2| insert(el_2) }
    end
  end
end
