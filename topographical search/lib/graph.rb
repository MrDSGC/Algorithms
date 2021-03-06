class Vertex
  attr_reader :value
  attr_accessor :in_edges, :out_edges
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost
  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = cost
    to_vertex.in_edges << self
    from_vertex.out_edges << self
  end

  def destroy!
    to_vertex.in_edges.delete(self)
    from_vertex.out_edges.delete(self)
    self.from_vertex = nil
    self.to_vertex = nil
    self
  end
end
