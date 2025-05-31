enum Signal
{
  //-1 max, -2 undefined.
  STOP(0, -2, 1), VMAX(-1, -1, 2), VMAX_STOP(-1, 0, 5),
  V60_VMAX(60, -1, 10), V60_V60(60, 60, 12), V60_STOP(60, 0, 13),
  SS(-2, -2, 15);
  int curr, next, index;
  
  Signal(int c, int n, int i)
  {
    curr = c;
    next = n;
    index = i;
  }
  
  String toString()
  {
    if(index == 15) return "Sygnal zastępczy";
    
    String cur = curr + "";
    if(curr == -1) cur = "maks";
    String nex = next + "";
    if(next == -1) nex = "maks";
    
    String res = "Teraz: " + cur;
    if(next != -2) res += ", Następna: " + nex;
    return res;
  }
}
