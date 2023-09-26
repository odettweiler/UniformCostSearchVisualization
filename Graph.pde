class Graph {
  char[] names = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
  int nameIndex = -1;
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  public Graph(int numNodes) {
    for (int i = 0; i < numNodes; i++) {
      //addRandomNode();
      nodes.add(new Node(getNextName(), new PVector(random(width), random(height))));
    }
    
    for (int i = 0; i < numNodes-1; i++) {
      connectToRandomNodes(nodes.get(i), numNodes);
      //nodes.get(i).addConnectionTo(nodes.get(i+1)); // change to connect more randomly
      //if (i == numNodes-2) {
      //  nodes.get(numNodes-1).addConnectionTo(nodes.get(0));
      //}
    }
  }
  
  public Graph(ArrayList<Node> nl) {
    nodes = nl;
  }
  
  public ArrayList<Connection> getAllConnections() {
    ArrayList<Connection> conn = new ArrayList<Connection>();
    for (Node n : this.nodes) {
      for (Connection c : n.getConnections()) {
        conn.add(c);
      }
    }
    
    return conn;
  }
  
  public int allLens() {
    int sum = 0;
    for (int i = 0; i < nodes.size(); i++) {
      Node n = nodes.get(i);
      for (Connection c : n.connections) {
        sum += c.len;
      }
    }
    return sum;
  }
  
  public char getNextName() {
    if (nameIndex >= 25) {
      nameIndex = 0;
    } else {
      nameIndex++;
    }
    
    return names[nameIndex];
  }
  
  public void drawSelf() {
    ArrayList<Connection> conn = getAllConnections();
    for (Connection c : conn) {
      c.drawSelf();
    }
    for (Node n : this.nodes) {
      n.drawSelf();
    }
  }
  
  public void addNode(Node n) {
    this.nodes.add(n);
  }
  
  public Node getNodeAtCoords(int x, int y) {
    for (int i = 0; i < nodes.size(); i++) {
      Node n = nodes.get(i);
      if (PVector.dist(n.pos, new PVector(x, y)) <= 50) {
        return n;
      }
    }
    
    return null;
  }
  
  private void connectToRandomNodes(Node n, int totalNodes) {
    int numConnections = (int) random(totalNodes/4, totalNodes/2);
    for (int i = 0; i < numConnections; i++) {
      int idx = (int) random(totalNodes);
      n.addConnectionTo(this.nodes.get(idx));
    }
  }
  
  private void addRandomNodes() {
    
    // add a random node if it's far enough away from other nodes
  }
}
