class Semafor extends Element
{
  Signal sig = Signal.STOP;
  Control con = Control.STOJ;
  Connection c = null;

  int point_x = -1, point_y = -1;

  Semafor(int _x, int _y)
  {
    x = _x;
    y = _y;
  }

  Semafor(int _x, int _y, int p_x, int p_y)
  {
    x = _x;
    y = _y;
    point_x = p_x;
    point_y = p_y;
  }

  void update()
  {
    if (next == null) return;

    if (point_x == -1) c = new Connection(new PVector(x, y), new PVector(next.x, next.y));
    else c = new Connection(new PVector(x, y), new PVector(next.x, next.y), new PVector(point_x, point_y));
  }

  void updateSignal()
  {
    sig = optionToSignal(con, this);
  }

  void drawLine()
  {
    stroke(255);
    if (sig.curr > 0 || sig.curr == -1) stroke(0, 255, 0);
    if (sig.index == 15) stroke(255, 0, 0);
    strokeWeight(2);
    if (next != null) c.draw();
  }

  void draw()
  {
    PVector left = new PVector(0, SIZE).rotate(TWO_PI / 3.);
    fill(255);
    noStroke();
    triangle(x, y - SIZE, left.x + x, y - left.y, x - left.x, y - left.y);

    textSize(20);
    fill(0);
    noStroke();
    textAlign(CENTER, CENTER);
    text(sig.index + "", x, y);
  }

  boolean mouseIn()
  {
    PVector left = new PVector(0, SIZE).rotate(TWO_PI / 3.);
    if (mouseX <= x - left.x && mouseX >= x + left.x && mouseY >= y - SIZE && mouseY <= y - left.y) return true;
    return false;
  }
}
