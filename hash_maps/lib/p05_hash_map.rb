require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def set(key, val)
    resize! if @count > @store.length

    if include?(key)
      @store[key.hash % @store.length].update(key, val)
    else
      @store[key.hash % @store.length].append(key, val)
      @count += 1
    end

  end

  def get(key)
    @store[key.hash % @store.length].get(key)
  end

  def delete(key)
    removal = @store[key.hash % @store.length].remove(key)
    @count -= 1
  end

  def each
    @store.each do |linked_list|
      linked_list.each do |single_link|
        yield [single_link.key, single_link.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    temp_store.each do |linked_list|
      linked_list.each { |single_link| set(single_link.key, single_link.val) }
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
