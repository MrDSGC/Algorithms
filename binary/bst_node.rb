class BSTNode

  attr_accessor :value, :l_child, :r_child, :parent

  def initialize(value, parent = nil)
    @value = value
    @l_child = nil
    @r_child = nil
    @parent = parent
  end
end
