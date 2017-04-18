require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = self.first
    left = array[1..-1].select{|el| el < pivot}
    right = array[1..-1].select{|el| el > pivot}

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return array if array.length <= 1
    barrier = partition(array, start, length, &prc)
    # debugger
    sort2!(array, start,barrier - start, &prc )
    sort2!(array, barrier + 1, length - barrier - 1, &prc )
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    pivot = array[start]
    part = start

    (start + 1).upto(start + length - 1) do |tracked|
      if prc.call(array[tracked], pivot) == -1
        array[tracked], array[part + 1] =  array[part + 1], array[tracked]
        part += 1
      end
    end
    array[start], array[part] = array[part], array[start]
    part
  end
end
