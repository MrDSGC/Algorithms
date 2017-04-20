require_relative 'graph'
require 'byebug'
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  output = []
  dup = vertices.dup
  until dup.empty?
    dup.each do |vert|
      if vert.in_edges.empty?
        output << vert
        until vert.out_edges.empty?
          vert.out_edges.each do |edge|
            edge.destroy!
          end
        end

        dup.delete(vert)
      end
    end
  end
  output
end
