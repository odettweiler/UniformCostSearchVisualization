Graph graph;
ArrayList<Node> nl = new ArrayList<Node>();
PFont f;
boolean finished = false;
boolean running = false;

boolean connecting = false;
Node connectingFrom = null;

Node start;
Node goal;

int frameIntervalIdx = 4;
int[] frameIntervalOptions = {2, 4, 5, 10, 20, 30, 60};

Path currentPath;
Node current;
ArrayList<Path> fringe = new ArrayList<Path>();

void setup() {  
  // custom graph
  graph = new Graph(0);
  
  //println(graph.allLens());
  size(800, 800);
  frameRate(60);
  
  f = createFont("Arial",16,true);
}

void draw() {
  background(255);
  graph.drawSelf();
  
  drawCompletedText();
  
  ucs();
  
  drawConnecting();
}

void mousePressed() {
  if (!running) {
    if (mouseButton == LEFT) {
      if (!connecting) {
        Node n = new Node(new ArrayList<Connection>(), graph.getNextName(), new PVector(mouseX, mouseY));
        graph.addNode(n);
      }
    } else if (mouseButton == RIGHT) {
      if (connecting) {
        Node n = graph.getNodeAtCoords(mouseX, mouseY);
        if (n != null) {
          connectingFrom.addConnectionTo(n);
          connecting = false;
        } else {
          connectingFrom = null;
          connecting = false;
        }
      } else {
        Node n = graph.getNodeAtCoords(mouseX, mouseY);
        if (n != null) {
          connecting = true;
          connectingFrom = n;
        }
      }
    }
  }
}

void keyPressed() {
  if (key == 'r') {
    // reset ucs program
    resetUCS();
    running = false;
    finished = false;
  } else if (key == 'q') {
    // init with example graph
    running = false;
    finished = false;
    clearGraph();
    resetUCS();
    
    InitNodeList();
    graph = new Graph(nl);
  }else if (key == 's') {
    // set starting node
    Node n = graph.getNodeAtCoords(mouseX, mouseY);
    if (n != null) {
      start = n;
      println(start.name);
    }
  } else if (key == 'c') {
    // clear graph
    clearGraph();
    resetUCS();
    running = false;
    finished = false;
  } else if (key == 'e') {
    // set ending node
    Node n = graph.getNodeAtCoords(mouseX, mouseY);
    if (n != null) {
      goal = n;
      println(goal.name);
    }
  } else if (key == 't') {
    // start ucs program
    startUCS();
  } else if (key == 'p') {
    // stop ucs program
    running = false;
    finished = false;
  } else if (keyCode == UP) {
    // increase speed if possible
    if (frameIntervalIdx != 0) {
      frameIntervalIdx--;
    }
  } else if (keyCode == DOWN) {
    // decrease speed if possible
    if (frameIntervalIdx < frameIntervalOptions.length-1) {
      frameIntervalIdx++;
    }
  }
}

void drawConnecting() {
  if (connecting) {
    line(connectingFrom.pos.x, connectingFrom.pos.y, mouseX, mouseY);
  }
}

// uniform cost search
/* determine which path to take by
finding all possible next steps and
taking the one with the least cost */

void resetUCS() {
  fringe = new ArrayList<Path>();
  
  currentPath = null;
  current = null;
  
  start = null;
  goal = null;
}

void startUCS() {
  running = true;
  finished = false;
  
  if (start == null) start = graph.nodes.get(0);
  if (goal == null) goal = graph.nodes.get(graph.nodes.size()-1);
  
  current = start; // init current node
  
  ArrayList<Node> nList = new ArrayList<Node>();
  nList.add(start);
  currentPath = new Path(current, nList); // init path
  
  addNeighborPathsToFringe(fringe, current, currentPath);
}

void clearGraph() {
  graph = new Graph(0);
  running = false;
}

void ucs() {
  if (running) {
    currentPath.drawSelf();
    // draw here ^^
    
    if (!finished) {
      if(fringe.size() != 0) {
        if (frameCount % frameIntervalOptions[frameIntervalIdx] == 0) {
          // execute one step of this every second
          
          // advance through the fringe
          currentPath = getShortestPathIn(fringe);
          current = getShortestPathIn(fringe).to;
          fringe.remove(getShortestPathIn(fringe));
          
          // check if goal has been reached
          if (current == goal) {
            currentPath.drawSelf();
            println(currentPath.cost);
            finished = true;
            // yay!!
          }
          
          // add neighbors to fringe
          addNeighborPathsToFringe(fringe, current, currentPath);
        }
      }
    }
  }
}

Path getShortestPathIn(ArrayList<Path> fringe) {
  int minLen = Integer.MAX_VALUE;
  Path shortestPath = null;
  for (Path p : fringe) {
    if (p.cost < minLen) {
      minLen = p.cost;
      shortestPath = p;
    }
  }
  
  return shortestPath;
}

void addNeighborPathsToFringe(ArrayList<Path> fringe, Node current, Path path) {
  for (Node n : current.getNeighbors()) {
    ArrayList<Node> nl = (ArrayList<Node>) path.nodeList.clone();
    
    nl.add(n);
    Path p = new Path(n, nl);
    addToFringe(fringe, p);
  }
}

void addToFringe(ArrayList<Path> fringe, Path path) {
  if (!fringe.contains(path)) {
    fringe.add(path);
  }
}

void InitNodeList() {
  ArrayList<Connection> aConn = new ArrayList<Connection>();
  Node a = new Node(aConn, 'a', new PVector(400, 100));
  nl.add(a);
  
  ArrayList<Connection> bConn = new ArrayList<Connection>();
  Node b = new Node(bConn, 'b', new PVector(266, 400));
  nl.add(b);
  
  ArrayList<Connection> cConn = new ArrayList<Connection>();
  Node c = new Node(cConn, 'c', new PVector(666, 400));
  nl.add(c);
  
  ArrayList<Connection> dConn = new ArrayList<Connection>();
  Node d = new Node(dConn, 'd', new PVector(100, 700));
  nl.add(d);
  
  ArrayList<Connection> eConn = new ArrayList<Connection>();
  Node e = new Node(eConn, 'e', new PVector(400, 700));
  nl.add(e);
  
  ArrayList<Connection> fConn = new ArrayList<Connection>();
  Node f = new Node(fConn, 'f', new PVector(700, 700));
  nl.add(f);
  
  a.addConnectionTo(b);
  a.addConnectionTo(c);
  
  b.addConnectionTo(d);
  b.addConnectionTo(e);
  
  c.addConnectionTo(f);
  
  e.addConnectionTo(f);
}

void drawCompletedText() {
  if (finished) {
    textFont(f,32);
    stroke(0);
    fill(0);
    text("Finished!", 325, 25);
  }
}
