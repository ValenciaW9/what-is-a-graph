const Graph = require('./graph');

describe('Graph', () => {
  let graph;

  beforeEach(() => {
    graph = new Graph();
  });

  it('should add vertices to the graph', () => {
    graph.addVertex('A');
    graph.addVertex('B');
    graph.addVertex('C');

    expect(graph.toString()).toEqual('{"A":[],"B":[],"C":[]}');
  });

  it('should add edges between vertices', () => {
    graph.addVertex('A');
    graph.addVertex('B');
    graph.addVertex('C');

    graph.addEdge('A', 'B');
    graph.addEdge('B', 'C');

    expect(graph.toString()).toEqual('{"A":["B"],"B":["A","C"],"C":["B"]}');
  });

  it('should check adjacency between vertices', () => {
    graph.addVertex('A');
    graph.addVertex('B');
    graph.addVertex('C');

    graph.addEdge('A', 'B');
    graph.addEdge('B', 'C');

    expect(graph.isAdjacent('A', 'B')).toBe(true);
    expect(graph.isAdjacent('A', 'C')).toBe(false);
  });

  it('should get adjacent vertices', () => {
    graph.addVertex('A');
    graph.addVertex('B');
    graph.addVertex('C');

    graph.addEdge('A', 'B');
    graph.addEdge('B', 'C');

    const adjacentVertices = graph.getAdjacentVertices('B');

    expect(adjacentVertices).toEqual(['A', 'C']);
  });
});