class Connection
{
  PVector a, b, c;
  
  Connection(PVector _a, PVector _b)
  {
    a = _a.copy();
    b = _b.copy();
    c = _a.add(_b).div(2).copy();
  }
  
  Connection(PVector _a, PVector _b, PVector _c)
  {
    a = _a.copy();
    b = _b.copy();
    c = _c.copy();
  }
  
  void draw()
  {
    line(a.x, a.y, c.x, c.y);
    line(b.x, b.y, c.x, c.y);
  }
};
