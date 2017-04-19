require_relative 'lost_node.rb'

class BinarySearchTree
  attr_accessor :root

  def initialize(val)
    @root = BSTNode.new(val)
  end

  def find(el)
    if @root.value == el
      return true
    elsif el < @root.value
      @root.l_child.find(el)
    else
      @root.r_child.find(el)
    end

    return false

  end

  def insert(current_node = @root, el)
    if el < current_node.value
      if current_node.l_child
        current_node.l_child.insert( BSTNode.new(el, current_node) )
      else
        current_node.l_child = el
        el.parent = current_node
      end
    else
      if current_node.r_child
        current_node.r_child.insert(el)
      else
        current_node.r_child = el
        el.parent = current_node
      end
    end
  end

  def delete(el)
    if @root.value == el
      if @root.l_child == nil && @root.r_child == nil
        @root.parent = nil
      elsif @root.l_child && @root.r_child
        replacement = maximum(@root.l_child)
        replacement.parent = @root.parent
        replacement.l_child = @root.l_child
        replacement.r_child = @root.r_child
        @root.r_child.parent = replacement
        @root.l_child.parent = replacement
        @root.parent = nil
      else
        @root.l_child.parent = @root.parent || @root.r_child.parent = @root.parent = nil
      end
      @root.l_child = nil
      @root.r_child = nil
    elsif el < @root.value
      @root.l_child.delete(el)
    else
      @root.r_child.delete(el)
    end
  end

  def is_balanced?
    if depth(@root.l_child) == depth(@root.r_child)
      return true
    elsif depth(@root.l_child) + 1 == depth(@root.r_child)
      return true
    elsif depth(@root.r_child) + 1 == depth(@root.l_child)
      return true
    elsif depth(@root.r_child) - 1 == depth(@root.l_child)
      return true
    end
    false
  end

  def in_order_traversal(node = @root)
    order = []
    return node.value if node.l_child == nil node.r_child == nil
    order << in_order_traversal(node.l_child) unless node.l_child == nil
    order << in_order_traversal(node.r_child) unless node.r_child == nil

    order
  end

  def maximum(node)
    return node if node.r_child = nil
    maximum(node.r_child)
  end

  def depth(node)
    depth = 0
    return 1 if node.r_child == nil && node.l_child == nil
    if depth(node.r_child) > depth(node.l_child)
      larger = node.r_child
    else
      larger = node.l_child
    end

    depth + depth(larger)
  end
end
