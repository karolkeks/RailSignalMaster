class Connection
{
  PVector a, b, c, d;
  
  Connection(PVector _a, PVector _b)
  {
    a = _a.copy();
    b = _b.copy();
    c = _b.copy();
    d = _b.copy();
  }
  
  Connection(PVector _a, PVector _b, PVector _c)
  {
    a = _a.copy();
    b = _b.copy();
    c = _c.copy();
    d = _b.copy();
  }
  
  Connection(PVector _a, PVector _b, PVector _c, PVector _d)
  {
    a = _a.copy();
    b = _b.copy();
    c = _c.copy();
    d = _d.copy();
  }
  
  void draw(boolean semafor)
  {
    if(semafor)
    {
      line(a.x, a.y, c.x, c.y);
      line(c.x, c.y, d.x, d.y);
      line(d.x, d.y, b.x, b.y);
    }
    else
    {
      push();
      stroke(255, OPACITY);
      line(a.x, a.y, c.x, c.y);
      line(c.x, c.y, d.x, d.y);
      line(d.x, d.y, b.x, b.y);
      pop();
      PVector v = PVector.sub(c, a);
      v.limit(LEN);
      v.add(a);
      line(a.x, a.y, v.x, v.y);
    }
  }
};
