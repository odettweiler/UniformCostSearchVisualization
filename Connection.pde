class Connection {
  Node from;
  Node to;
  int len;
  
  public Connection(Node f, Node t, int l) {
    this.from = f;
    this.to = t;
    this.len = l;
  }
  
  public void drawSelf() {
    stroke(0);
    fill(0);
    strokeWeight(1);
    line(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
    PVector midpoint = new PVector((from.pos.x+to.pos.x)/2, (from.pos.y+to.pos.y)/2);
    // text
    textFont(f,16);
    stroke(0);
    fill(0);
    text(this.len, midpoint.x, midpoint.y-40);
  }
  
  public void drawSelfSpecial() {
    stroke(73, 219, 255);
    fill(0);
    strokeWeight(4);
    line(from.pos.x, from.pos.y, to.pos.x, to.pos.y);
    PVector midpoint = new PVector((from.pos.x+to.pos.x)/2, (from.pos.y+to.pos.y)/2);
    // label length near midpoint
  }
}
