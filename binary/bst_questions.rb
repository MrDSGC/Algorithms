# *NB*: what do you need to require here? This is a good chance to review a little Ruby require syntax.

require_relative 'binary_search_tree'

def kth_largest(bst, k)
  bst.in_order_traversal[k + 1]
end

def lowest_common_ancestor(node1, node2)

end

def post_order_traversal(bst)
  left = bst.root.l_child.in_order_traversal
  right = bst.root.r_child.in_order_traversal

end

def reconstruct(post_order, in_order)
end
