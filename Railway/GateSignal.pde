enum GateSignal
{
  STRAIGHT(1), SIDE(2);
  
  int index;
  
  GateSignal(int i)
  {
    index = i;
  }
  
  String toString()
  {
    if(this == STRAIGHT) return "Prosto";
    else return "Na bok";
  }
};
