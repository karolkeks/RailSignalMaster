class Gate extends Element
{
  int point_x, point_y;
  Connection c;
  GateSignal sig = GateSignal.STRAIGHT;
  Element next_forward = null;
  Element next_side = null;
  int num;
  
  Gate(int _x, int _y, int p_x, int p_y, int _num)
  {
    x = _x;
    y = _y;
    point_x = p_x;
    point_y = p_y;
    num = _num;
    confirmed = false;
  }

  void update()
  {
    if (point_x == -1) c = new Connection(new PVector(x, y), new PVector(next_side.x, next_side.y));
    else c = new Connection(new PVector(x, y), new PVector(next_side.x, next_side.y), new PVector(point_x, point_y));
  }
  
  void updateSignal()
  {
    next = (sig == GateSignal.STRAIGHT)? next_forward : next_side;
  }
  
  void draw()
  {
    noStroke();
    fill(255);
    ellipse(x, y, SIZE, SIZE);

    textSize(20);
    fill(0);
    noStroke();
    textAlign(CENTER, CENTER);
    text(num + "", x, y);
  }
  
  void drawLine()
  {
    stroke(255, OPACITY);
    strokeWeight(2);
    if (next == null) return;
    
    if(sig == GateSignal.STRAIGHT)
    {
      if(confirmed) stroke(0, 255, 0);
      else stroke(255, 255, 0);
    }
    PVector v = PVector.sub(new PVector(next_forward.x, next_forward.y), new PVector(x, y));
    v.limit(LEN);
    v.add(new PVector(x, y));
    push();
    stroke(255, OPACITY);
    line(x, y, next_forward.x, next_forward.y);
    pop();
    line(x, y, v.x, v.y);
    if(confirmed) stroke(0, 255, 0);
    else stroke(255, 255, 0);
    if(sig == GateSignal.STRAIGHT) stroke(255, OPACITY);
    c.draw(false);
  }
  
  boolean mouseIn()
  {
    return dist(x, y, mouseX, mouseY) <= SIZE;
  }
  
  String toString()
  {
    return "rozjazd " + num + " " + (sig == GateSignal.STRAIGHT? "przod" : "na bok");
  }
}
