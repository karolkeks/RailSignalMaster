abstract class Element
{
  Element next;
  int x, y;
  boolean confirmed = true;
  
  abstract void drawLine();
  abstract void draw();
  abstract boolean mouseIn();
  void update() {}
  void updateSignal() {}
};
