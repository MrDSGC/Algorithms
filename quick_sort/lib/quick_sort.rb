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
    return array if length < 2
    prc ||= Proc.new { |x, y| x <=> y }
    barrier = QuickSort.partition(array, start, length, &prc)
    # debugger

    left_length = barrier - start
    right_length = length - (left_length + 1)

    QuickSort.sort2!(array, start, left_length, &prc )
    QuickSort.sort2!(array, barrier + 1, right_length, &prc )
    # QuickSort.sort2!(array[start...barrier], start, &prc )
    # QuickSort.sort2!(array[barrier + 1..length], barrier, &prc )
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    pivot = array[start]
    i = 1
    barrier_idx = start

    while i < length
      if prc.call(array[i+ start], pivot) < 0
        if start + i > barrier_idx
          array[start + i], array[barrier_idx + 1] = array[barrier_idx + 1], array[start + i]
          barrier_idx += 1
        else
          barrier_idx += 1
        end
      end
      i += 1
    end

    array[start], array[barrier_idx] = array[barrier_idx], array[start]
    barrier_idx
  end
end
