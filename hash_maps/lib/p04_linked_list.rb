class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
  end
end

class LinkedList
  include Enumerable

  
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    self.each { | single_link, index | return single_link if i == index }
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each { |single_link| return single_link.val if single_link.key == key }
  end

  def include?(key)
    self.each do |single_link|
      return true if single_link.key == key
    end
    false
  end

  def append(key, val)
   new_link = Link.new(key, val)
    @tail.prev.next = new_link
    new_link.prev = @tail.prev
    new_link.next = @tail
    @tail.prev = new_link
  end

  def update(key, val)
    self.each do |single_link|
      if single_link.key == key
        single_link.val = val
        return single_link;
      end
    end
  end

  def remove(key)
    self.each do |single_link|
      if single_link.key == key
        single_link.remove
        return single_link.val
      end
    end
  end

  def each
    current_link = @head.next
    index = 0
    until current_link == @tail
      yield current_link, index
      index += 1
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
