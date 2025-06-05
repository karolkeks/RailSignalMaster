class SerialConsole extends PApplet
{
  ControlP5 cp5;
  Serial s = null;
  String text = "";
  int index = -1;
  SerialConsole()
  {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  
  public void settings()
  {
    size(800, 500);
  }
  
  public void setup()
  {
    cp5 = new ControlP5(this);
                  
    cp5.addButton("polacz")
                  .setPosition(10, 40)
                  .setSize(100, 20)
                  ;
    cp5.addButton("rozlacz")
                  .setPosition(10, 70)
                  .setSize(100, 20)
                  ;
    cp5.addButton("przeladuj")
                  .setPosition(10, 100)
                  .setSize(100, 20)
                  ;
    cp5.addTextarea("history")
                  .setPosition(110, 10)
                  .setSize(width - 100 - 10, height - 20)
                  .setFont(createFont("arial", 16))
                  .setColor(color(255))
                  .setColorBackground(color(0))
                  .setColorForeground(color(255, 100))
                  ;
                  
    cp5.addScrollableList("porty")
                  .setPosition(10, 10)
                  .setSize(100, 50)
                  .setBarHeight(20)
                  .setItemHeight(20)
                  .addItems(Serial.list())
                  ;
  }
  
  public void draw()
  {
    background(0);
    if(s != null)
    {
      textSize(20);
      fill(255);
      noStroke();
      textAlign(LEFT, BOTTOM);
      text("Polączono", 10, height - 10);
    }
  }
  
  void przeladuj()
  {
    cp5.get(ScrollableList.class, "porty").setItems(Serial.list());
  }
  
  void rozlacz()
  {
    if(s == null) return;
    s.stop();
    s = null;
  }
  
  void polacz()
  {
    if(index == -1) return;
    try
    {
      s = new Serial(this, cp5.get(ScrollableList.class, "porty").getItem(index).get("name") + "", 9600);
    }
    catch (Exception e)
    {
      if(s != null) s.stop();
      s = null;
    }
  }
  
  void porty(int n)
  {
    index = n;
  }
  
  public void write(String ss)
  {
    text += ss + "\n";
    cp5.get(Textarea.class, "history").setText(text);
    if(s == null) return;
    try
    {
      s.write(ss + "\n");
    }
    catch (Exception e)
    {
      println(e);
      s.stop();
      s = null;
    }
  }
}
