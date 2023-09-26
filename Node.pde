class Node {
  ArrayList<Connection> connections = new ArrayList<Connection>();
  char name;
  PVector pos;
  
  public Node(ArrayList<Connection> conn, char n, PVector p) {
    this.connections = conn;
    this.name = n;
    this.pos = p;
  }
  
  public Node(char n, PVector p) {
    this.name = n;
    this.pos = p;
  }
  
  public ArrayList<Node> getNeighbors() {
    ArrayList<Node> nodes = new ArrayList<Node>();
    for (Connection c : connections) {
      nodes.add(c.to);
    }
    return nodes;
  }
  
  public ArrayList<Connection> getConnections() {
    return this.connections;
  }
  
  public void addConnectionTo(Node to) {
    this.connections.add(new Connection(this, to, floor(getDistTo(to.pos))));
  }
  
  public Connection getConnectionTo(Node to) {
    Connection conn = null;
    for (Connection c : connections) {
      if (c.to == to) conn = c;
    }
    return conn;
  }
  
  public float getDistTo(PVector otherPos) {
    return sqrt(pow(otherPos.x - this.pos.x, 2) + pow(otherPos.y - this.pos.y, 2)) / 100;
  }
  
  public void drawSelf() {
    stroke(0);
    strokeWeight(1);
    fill(255);
    ellipse(pos.x, pos.y, 50, 50);
    
    textFont(f,16);
    stroke(0);
    fill(0);
    text(this.name, pos.x, pos.y);
  }
  
  public void drawSelfSpecial() {
    stroke(73, 219, 255);
    strokeWeight(1);
    fill(73, 219, 255);
    ellipse(pos.x, pos.y, 50, 50);
    
    textFont(f,16);
    stroke(0);
    fill(0);
    text(this.name, pos.x, pos.y);
  }
  
  public void drawSelfSpecial2() {
    stroke(53, 255, 134);
    strokeWeight(1);
    fill(53, 255, 134);
    ellipse(pos.x, pos.y, 50, 50);
    
    textFont(f,16);
    stroke(0);
    fill(0);
    text(this.name, pos.x, pos.y);
  }
  
  @Override
  public String toString() {
    return Character.toString(this.name);
  }
}
