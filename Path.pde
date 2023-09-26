class Path {
  Node to;
  ArrayList<Node> nodeList = new ArrayList<Node>();
  int cost;
  
  public Path(Node t, ArrayList<Node> nl) {
    this.to = t;
    this.nodeList = nl;
    
    this.cost = 0;
    for (int i = 0; i < this.nodeList.size()-1; i++) {
      Node n = this.nodeList.get(i);
      Connection c = n.getConnectionTo(this.nodeList.get(i+1));
      if (c != null) {
        this.cost += c.len;
      }
    }
  }
  
  public ArrayList<Connection> getAllConnections() {
    ArrayList<Connection> conn = new ArrayList<Connection>();
    for (int i = 0; i < nodeList.size()-1; i++) {
      conn.add(nodeList.get(i).getConnectionTo(nodeList.get(i+1)));
      if (i == nodeList.size()-2) {
        conn.add(nodeList.get(nodeList.size()-1).getConnectionTo(nodeList.get(0)));
      }
    }
    if (conn.isEmpty()) {
      return null;
    } else {
      return conn;
    }
  }
  
  public void drawSelf() {
    int co = 0;
    for (int i = 0; i < nodeList.size(); i++) {
      if (i < nodeList.size()-1) {
        Connection c = nodeList.get(i).getConnectionTo(nodeList.get(i+1));
        co += c.len;
        c.drawSelfSpecial();
      }
      nodeList.get(i).drawSelfSpecial2();
    }
    to.drawSelfSpecial();
  }
}
