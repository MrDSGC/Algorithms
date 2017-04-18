require_relative "heap"
require 'byebug'
class Array

  def heap_sort!
    prc = Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end
    pointer = 0

    while pointer < self.length
      BinaryMinHeap.heapify_up(self, pointer,self.length, &prc)
      pointer += 1
    end

    pointer -= 1
    len = self.length

    while pointer >= 0
      self[0], self[pointer] = self[pointer], self[0]
      len -= 1
      pointer -= 1
      begin
        BinaryMinHeap.heapify_down(self, 0, len, &prc)
      rescue
        self
      end
    end
  end
end
