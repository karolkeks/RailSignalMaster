enum Control
{
  JAZDA, STOJ, SS;
  
  String toString()
  {
    if(this == JAZDA) return "Jazda";
    if(this == STOJ) return "Stój";
    if(this == SS) return "Sygnal zastępczy";
    return "";
  }
};
