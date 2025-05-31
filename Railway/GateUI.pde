class GateUI extends UI
{
  int x = -1, y = -1;
  
  GateSignal[] controls = GateSignal.values();
  
  GateUI(int _x, int _y)
  {
    x = _x;
    y = _y;
  }
  
  void draw()
  {
    if(x == -1) return;
    
    textSize(20);
    fill(255);
    noStroke();
    textAlign(CENTER, CENTER);
    
    for(int i = 0; i < controls.length; i++)
    {
      fill(0);
      if(mouseX >= x && mouseY >= y + UI_Element_H * i && mouseX <= x + UI_W && mouseY <= y + UI_Element_H * (i + 1)) fill(100);
      stroke(255);
      rect(x, y + UI_Element_H * i, UI_W, UI_Element_H);
      
      fill(255);
      noStroke();
      
      text(controls[i] + "", x + UI_W / 2, y + UI_Element_H * i + UI_Element_H / 2);
    }
  }
  
  GateSignal getOption()
  {
    for(int i = 0; i < controls.length; i++)
    {
      if(mouseX >= x && mouseY >= y + UI_Element_H * i && mouseX <= x + UI_W && mouseY <= y + UI_Element_H * (i + 1)) return controls[i];
    }
    
    return null;
  }
}
