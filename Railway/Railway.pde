import java.util.*;
import java.util.Arrays;

final int SIZE = 20;
final int W = 1700, H = 900, UI_W = 200, UI_Element_H = 20;

ArrayList<Element> elements;
UI ui = null;

Element curr = null;

void settings()
{
  size(W, H);
}

void setup()
{
  elements = new ArrayList<>(Arrays.asList(new Semafor(100, H / 2), new Gate(300, H / 2, 400, 200), new Semafor(500, H / 2), new Semafor(500, 200)));
  elements.get(0).next = elements.get(1);
  ((Gate) elements.get(1)).next_forward = elements.get(2);
  ((Gate) elements.get(1)).next_side = elements.get(3);

  for (Element s : elements)
  {
    s.update();
  }
  
  surface.setIcon(loadImage("Logo.jpg"));
}

boolean speedLimit(Element curr)
{
  assert(curr instanceof Semafor);
  Semafor s = (Semafor) curr;
  if (s.next == null) return false;
  if (!(s.next instanceof Gate)) return false;
  Gate next = (Gate) s.next;
  if (next.sig == GateSignal.SIDE) return true;
  return false;
}

Signal optionToSignal(Control c, Element curr)
{
  assert(curr instanceof Semafor);
  if (c == Control.STOJ) return Signal.STOP;
  if (c == Control.SS) return Signal.SS;
  if (curr.next == null)
  {
    return Signal.VMAX;
  } else
  {
    Element next = curr.next;
    if (next instanceof Gate)
    {
      next.updateSignal();
      Gate g = (Gate)next;
      boolean speedLimit = g.sig == GateSignal.SIDE;
      next = g.next;
      assert(next instanceof Semafor);
      Semafor s = (Semafor) next;
      if (speedLimit)
      {
        if (s.con == Control.JAZDA)
        {
          if (speedLimit(s)) return Signal.V60_V60;
          return Signal.V60_VMAX;
        }
        if (s.con == Control.SS) return Signal.V60_STOP;
        return Signal.V60_STOP;
      } else
      {
        if (s.con == Control.JAZDA)
        {
          if(speedLimit(s)) return Signal.VMAX_STOP;
          return Signal.VMAX;
        }
        if (s.con == Control.SS) return Signal.VMAX;
        return Signal.VMAX_STOP;
      }
    } else
    {
      Semafor s = (Semafor) next;
      if (s.con == Control.JAZDA)
      {
        if(speedLimit(s)) return Signal.VMAX_STOP;
        return Signal.VMAX;
      }
      if (s.con == Control.SS) return Signal.VMAX;
      return Signal.VMAX_STOP;
    }
  }
}

void mousePressed()
{
  if (ui != null)
  {
    if (ui instanceof SemaforUI)
    {
      Semafor se = (Semafor) curr;
      SemaforUI seui = (SemaforUI) ui;
      Control option = seui.getOption();
      if (option != null)
      {
        se.con = option;
        curr = null;
        ui = null;
      } else
      {
        curr = null;
        ui = null;
        for (Element s : elements)
        {
          if (s.mouseIn())
          {
            curr = s;
            if (s instanceof Semafor)
            {
              ui = new SemaforUI(s.x, s.y);
            } else
            {
              ui = new GateUI(s.x, s.y);
            }
            break;
          }
        }
      }
    }
    else
    {
      Gate g = (Gate) curr;
      GateUI gui = (GateUI) ui;
      GateSignal option = gui.getOption();
      if (option != null)
      {
        g.sig = option;
        curr = null;
        ui = null;
      } else
      {
        curr = null;
        ui = null;
        for (Element s : elements)
        {
          if (s.mouseIn())
          {
            curr = s;
            if (s instanceof Semafor)
            {
              ui = new SemaforUI(s.x, s.y);
            } else
            {
              ui = new GateUI(s.x, s.y);
            }
            break;
          }
        }
      }
    }
  } else
  {
    for (Element s : elements)
    {
      if (s.mouseIn())
      {
        curr = s;
        if (s instanceof Semafor)
        {
          ui = new SemaforUI(s.x, s.y);
        } else
        {
          ui = new GateUI(s.x, s.y);
        }
        break;
      }
    }
  }
}

void keyPressed()
{
  if (keyCode == ENTER)
  {
  }
}

void draw()
{
  background(0);

  for (Element s : elements)
  {
    s.updateSignal();
    s.drawLine();
  }

  for (Element s : elements)
  {
    s.draw();
  }

  if (ui != null) ui.draw();
}
