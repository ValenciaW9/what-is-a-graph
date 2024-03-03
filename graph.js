
class Graph {
  constructor() {
    this.graph = {};
  }

  addVertex(vertex) {
    if (!this.graph[vertex]) {
      this.graph[vertex] = [];
    }
  }

  addEdge(vertex1, vertex2) {
    if (this.graph[vertex1] && this.graph[vertex2]) {
      this.graph[vertex1].push(vertex2);
      this.graph[vertex2].push(vertex1);
    }
  }

  isAdjacent(vertex1, vertex2) {
    if (this.graph[vertex1] && this.graph[vertex2]) {
      return this.graph[vertex1].includes(vertex2);
    }
    return false;
  }

  getAdjacentVertices(vertex) {
    if (this.graph[vertex]) {
      return this.graph[vertex];
    }
    return [];
  }

  toString() {
    return JSON.stringify(this.graph);
  }
}