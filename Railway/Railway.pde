import java.util.*;
import java.util.Arrays;

final int SIZE = 20;
final int W = 1700, H = 900, UI_W = 200, UI_Element_H = 20;

ArrayList<Semafor> semafors;
UI ui = new UI();

Semafor curr = null;

void settings()
{
  size(W, H);
}

void setup()
{
  semafors = new ArrayList<>(Arrays.asList(new Semafor(100, H / 2), new Semafor(300, H / 2), new Semafor(700, H / 2)));
  semafors.get(0).next = semafors.get(1);
  semafors.get(1).next = semafors.get(2);
  
  for(Semafor s : semafors)
  {
    s.update();
  }
}

Signal optionToSignal(Control c, Semafor curr)
{
  if(c == Control.STOJ) return Signal.STOP;
  if(c == Control.SS) return Signal.SS;
  if(curr.next == null)
  {
    return Signal.VMAX;
  }
  else
  {
    if(curr.next.con == Control.STOJ) return Signal.VMAX_STOP;
    else return Signal.VMAX; 
  }
}

void mousePressed()
{
  if (ui.x != -1)
  {
    Control option = ui.getOption();
    if (option != null)
    {
      curr.con = option;
      curr = null;
      ui.x = -1;
      ui.y = -1;
    } else
    {
      curr = null;
      ui.x = -1;
      ui.y = -1;
      for (Semafor s : semafors)
      {
        if (s.mouseIn())
        {
          curr = s;
          ui.x = s.x;
          ui.y = s.y;
          break;
        }
      }
    }
  } else
  {
    for (Semafor s : semafors)
    {
      if (s.mouseIn())
      {
        curr = s;
        ui.x = s.x;
        ui.y = s.y;
        break;
      }
    }
  }
}

void keyPressed()
{
  if(keyCode == ENTER)
  {
    
  }
}

void draw()
{
  background(0);

  for (Semafor s : semafors)
  {
    s.updateSignal();
    s.drawLine();
  }

  for (Semafor s : semafors)
  {
    s.draw();
  }

  ui.draw();
}
