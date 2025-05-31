enum Signal
{
  //-1 max, -2 undefined.
  STOP(0, -2, 1), VMAX(-1, -2, 2), V100(100, -2, 3), V60(60, -2, 4), VMAX_STOP(-1, 0, 5), 
  V100_VMAX(100, -1, 6), V100_V100(100, 100, 7), V100_V60(100, 60, 8), V100_STOP(100, 0, 9),
  V60_VMAX(60, -1, 10), V60_V100(60, 100, 11), V60_V60(60, 60, 12), V60_STOP(60, 0, 13),
  V40_VMAX(40, -1, 14), V40_V100(40, 100, 15), V40_V60(40, 60, 16), V40_STOP(40, 0, 17),
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
