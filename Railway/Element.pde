abstract class Element
{
  Element next;
  int x, y;
  
  abstract void drawLine();
  abstract void draw();
  abstract boolean mouseIn();
  void update() {}
  void updateSignal() {}
};
