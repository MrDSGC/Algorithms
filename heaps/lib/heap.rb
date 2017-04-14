
class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
    @store.count - 1
  end

  def extract
    @store[0], @store[count] = @store[count], @store[0]
    output = @store.pop
    BinaryMinHeap.heapify_down(@store, @store[0])
    output
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @store.length - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [parent_index * 2 + 1, parent_index * 2 + 2].select { |i| i < len }
  end

  def self.parent_index(child_index)
    raise("root has no parent") if child_index == 0
    (child_index - 1) / 2
  end


  def self.heapify_down(array, parent_idx, len = array.length, &prc )
    prc ||= Proc.new { |x, y| x <=> y }
    i = 0

    while i <= BinaryMinHeap.parent_index(len-1)
      small_child_idx =
        BinaryMinHeap.child_indices(len, i).min_by {
          |i| array[i]
        }

      if prc.call(array[small_child_idx], array[i]) < 0
        array[i], array[small_child_idx] =
        array[small_child_idx], array[i]
        i = small_child_idx
      else
        break
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc )
    prc ||= Proc.new { |x, y| x <=> y }

    while child_idx > 0
      current = array[child_idx]
      parent = array[BinaryMinHeap.parent_index(child_idx)]
      if prc.call(current, parent) < 0
        array[child_idx], array[BinaryMinHeap.parent_index(child_idx)] =
          array[BinaryMinHeap.parent_index(child_idx)], array[child_idx]
        child_idx = BinaryMinHeap.parent_index(child_idx)
      else
        break
      end
    end
    array
  end
end
