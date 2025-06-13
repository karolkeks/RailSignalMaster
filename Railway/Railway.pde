import controlP5.*;
import processing.serial.*;
import java.util.*;
import java.util.Arrays;

final int SIZE = 20;
final int W = 1700, H = 900, UI_W = 200, UI_Element_H = 20, OPACITY = 100;

Element[] elements;
UI ui = null;

Element curr = null;
SerialConsole sc;

void settings()
{
  size(W, H);
}

PFont font;
void setup()
{
  elements = new Element[]{new Semafor(100, H / 2, 'A'), new Gate(300, H / 2, 400, 200, 1), new Semafor(1000, H / 2, 'E'), new Semafor(1000, 200, 1200, 200, 1300, H / 2, 'D'), new Semafor(10000, H / 2, '1'),
                          new Semafor(1500, H / 2, 'F'), new Gate(1300, H / 2, 1200, 200, 2), new Semafor(600, H / 2, 'B'), new Semafor(600, 200, 400, 200, 300, H / 2, 'C'), new Semafor(-10000, H / 2, '1')};
  elements[0].next = elements[1];
  ((Gate) elements[1]).next_forward = elements[2];
  ((Gate) elements[1]).next_side = elements[3];
  elements[2].next = elements[4];
  elements[3].next = elements[4];
  ((Semafor) elements[2]).limit = true;
  ((Semafor) elements[3]).limit = true;
  elements[5].next = elements[6];
  ((Gate) elements[6]).next_forward = elements[7];
  ((Gate) elements[6]).next_side = elements[8];
  elements[7].next = elements[9];
  elements[8].next = elements[9];
  ((Semafor) elements[7]).limit = true;
  ((Semafor) elements[8]).limit = true;

  for (Element s : elements)
  {
    s.update();
    if(s instanceof Semafor && ((Semafor) s).ch == '1')
    {
      ((Semafor) s).con = Control.JAZDA;
      s.confirmed = true;
    }
  }
  
  surface.setIcon(loadImage("Logo.jpg"));
  font = createFont("PressStart2P-Regular.ttf", 20);
  sc = new SerialConsole();
  surface.setResizable(true);
}

boolean speedLimit(Element curr)
{
  assert(curr instanceof Semafor);
  Semafor s = (Semafor) curr;
  if(s.limit) return true;
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
      boolean speedLimit = g.sig == GateSignal.SIDE || ((Semafor) curr).limit;
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
      boolean speedLimit = ((Semafor) curr).limit;
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
        se.confirmed = false;
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
        g.confirmed = false;
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
    for(Element e : elements)
    {
      e.confirmed = true;
    }
    
    for(Element e : elements)
    {
      if(e instanceof Semafor && ((Semafor) e).ch == '1') continue;
      sc.write(e.toString());
    }
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
  
  fill(255);
  noStroke();
  push();
  textFont(font);
  textAlign(LEFT, TOP);
  text("Rail Signal Manager V1.0", 10, 10);
  pop();
}
