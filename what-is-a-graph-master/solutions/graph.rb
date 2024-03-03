rrequire 'set'

class Graph
  attr_reader :graph

  def initialize(paths)
    @graph = paths.reduce({}) { |graph, path| self.class.populate(graph, path) }
  end

  def is_adjacent(vertex_a, vertex_b)
    @graph[vertex_a].include?(vertex_b)
  end

  def add_vertex(vertex, array)
    @graph[vertex] = Set.new(array)

    array.each do |adjacency|
      @graph[adjacency] = Set.new if @graph[adjacency].nil?
      @graph[adjacency].add(vertex)
    end
  end

  def self.populate(graph, path)
    path.each_with_index.reduce(graph) do |graph, (vertex, idx)|
      graph[vertex] = Set.new if graph[vertex].nil?
      next_vertex = path[idx + 1]

      return graph if next_vertex.nil?

      graph[vertex].add(next_vertex)
      graph[next_vertex] = Set.new if graph[next_vertex].nil?
      graph[next_vertex].add(vertex)
      graph
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  graph = Graph.new([])

  puts "Expecting: {}"
  puts graph.graph

  puts

  graph = Graph.new([["a", "b", "c"], ["b", "d"]])

  puts 'Expecting: { "a"=>#<Set: {"b"}>, "b"=>#<Set: {"a", "c", "d"}>, "c"=>#<Set: {"b"}>, "d"=>#<Set: {"b"}> }'
  puts graph.graph

  puts

  # Don't forget to add your own!

  puts "Expecting: true"
  puts graph.is_adjacent("a", "b")

  puts

  puts "Expecting: false"
  puts graph.is_adjacent("a", "c")

  puts

  graph.add_vertex("e", ["a", "d"])
  puts 'Expecting: {"a"=>#<Set: {"b", "e"}>, "b"=>#<Set: {"a", "c", "d"}>, "c"=>#<Set: {"b"}>, "d"=>#<Set: {"b", "e"}>, "e"=>#<Set: {"a", "d"}> }'
  puts graph.graph

  puts

  graph = Graph.new([["a"]])

  puts 'Expecting: { "a"=>#<Set: {}> }'
  puts graph.graph

  puts

  puts ""

  graph.add_vertex("d", ["a", "b", "c"])
  puts 'Expecting: {"a"=>#<Set: {"d"}>, "b"=>#<Set: {"d"}>, "c"=>#<Set: {"d"}>, "d"=>#<Set: {"a", "b", "c"}> }'
  puts graph.graph
end
# Please add your pseudocode to this file
###########################################################################################################
 # # this method converts a single path into a graph
 # function populate(graph, path):
 #  iterate over the path with its index and element included:
 #    if element is not a key in graph:
 #      add element as key and initialize value to empty set
 #
 #    if next element exists:
 #      add the next element to the element's set
 #
 #      if next element isn't a key in graph:
 #        add next element as key in graph and initialize value to empty set
 #
 #      add element to next element's set
 #
 #  return graph
 #
 #
 # function isAdjacent(vertex_a, vertex_b):
 #  get set from graph associated with key vertex_a
 #  return true if vertex_b is in set, else false
 #
 # function add_vertex(vertex, array):
 #  add vertex as key in graph with value initialized to a set made from array
 #
 #  iterate over each element in array:
 #    if element is not in graph:
 #      add element as key with value initialized to an empty set
 #    add vertex to each element's set in graph
###########################################################################################################

 # And a written explanation of your solution
###########################################################################################################
 # I can create the graph from an array of paths by creating a key in the graph object for every
 # element in a path. If the element, or vertex, is not in the graph, I initialize it to an empty
 # set. Since the next vertex in the path is adjacent to the current vertex, I can have them both
 # point to each other, or rather put each vertex in the other's adjacency list.
 #
 # To check if two vertices are adjacent, I just need to grab one of their sets (values in the graph),
 # and check if the other vertex is in its adjacency list. If it is return true, otherwise false.
 #
 # To add a vertex, I add it as a key to the graph and set its value to a new set made from the array
 # (adjacency list) that's passed into the method. Next, I iterate over the array to ensure each vertex
 # is added to the graph as a key if it's not already in there. I also need to ensure that each vertex
 # in the adjacency list points back to the added vertex.
 #In the initialize method, you take an array of paths and convert it into a graph representation. The reduce method is used to iterate over each path and call the populate method to update the graph with each path. The populate method takes in the current state of the graph and the path, and adds the vertices and their adjacencies to the graph.
#The is_adjacent method takes in two vertices and checks if the second vertex is in the adjacency list of the first vertex. It returns true if it is, and false otherwise.
#The add_vertex method takes in a new vertex and an array of vertices that it is adjacent to. It adds the new vertex to the graph with an empty adjacency list. Then, it iterates over the array and adds each vertex to the adjacency list of the new vertex, as well as adds the new vertex to the adjacency list of each existing vertex.
#To better understand the code, let's walk through the first example in the script.
#graph = Graph.new([])
#puts "Expecting: {}"
#puts graph.graph
#Here, you create a new graph with an empty paths array. The graph is initialized as an empty hash. The output should be an empty hash {}.
#graph = Graph.new([["a", "b", "c"], ["b", "d"]])
#puts 'Expecting: { a: { "b" }, b: { "a", "c", "d" }, c: { "b" }, d: { "b" }}'
#puts graph.graph
#In this example, you create a new graph with two paths: ["a", "b", "c"] and ["b", "d"]. The resulting graph should have the vertices a, b, c, and d with their respective adjacency lists. The output should be { a: { "b" }, b: { "a", "c", "d" }, c: { "b" }, d: { "b" }}.
###########################################################################################################

 # Time complexity for:
 # creating a new graph: O(n) since we must iterate over the entire paths array
 # checking if adjacent: O(1) accessing an element in a set is constant time as is accessing a key in a hash
 # adding a vertex: O(n) since we must iterate over the entire adjacency list
