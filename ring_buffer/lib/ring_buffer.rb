require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
    @capacity = 8
    @start_idx = 0
    @end_idx = 0
  end

  # O(1)
  def [](index)
    raise("index out of bounds") if index >= @length
    @store[(index + @start_idx) % @capacity]
  end

  # O(1)
  def []=(index, val)
    @store[(index + @start_idx) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    output = @store[@end_idx]
    @length -= 1
    @end_idx -= 1
    output
  end

  # O(1) ammortized
  def push(val)
    check_index(@length)
    if @length == 0
      @store[0] = val
    else
      @end_idx += 1
      @store[@end_idx]= val
    end
    @length += 1
    @store
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    output = @store[@start_idx]
    if @start_idx == @capacity - 1
      @start_idx = 0
    else
      @start_idx += 1
    end
    @length -= 1
    output
  end

  # O(1) ammortized
  def unshift(val)
    check_index(@length)
    if @start_idx == 0
      @start_idx = @capacity -1
    else
      @start_idx -= 1
    end
    @store[@start_idx] = val
    @length +=1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    resize! if index == capacity
  end

  def resize!
    temp_store = StaticArray.new(@length * 2)
    (0...@length).each do |i|
      temp_store[i] = @store[(@start_idx + i) % capacity]
    end
    @capacity *= 2
    @store = temp_store
    @start_idx = 0
    @end_idx = @length - 1
  end
end
