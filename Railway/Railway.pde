import java.util.*;
import java.util.Arrays;

final int SIZE = 20;
final int W = 1700, H = 900, UI_W = 250, UI_Element_H = 20;

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

void mousePressed()
{
  if (ui.x != -1)
  {
    Signal option = ui.getOption();
    if (option != null)
    {
      curr.sig = option;
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
    for(Semafor s : semafors)
    {
      s.ok = true;
      if(s.next == null)
      {
        continue;
      }
      if(s.sig.index == 15) continue;
      if(s.sig.index == 1) continue;
      int speed = s.next.sig.curr;
      if(s.sig.next == speed || (s.sig.next == 60 && speed == 40) || (s.sig.index == 2 && speed != 0))
      {
        s.ok = true;
      }
      else
      {
        s.ok = false;
      }
    }
  }
}

void draw()
{
  background(0);

  for (Semafor s : semafors)
  {
    s.drawLine();
  }

  for (Semafor s : semafors)
  {
    s.draw();
  }

  ui.draw();
}
