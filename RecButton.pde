class RecButton {
  
  int _xpos;
  int _ypos;
  int _sz;
  public int cIncr;
  private int _counter;
  
  public RecButton(int x, int y, int size) {
    this._xpos = x;
    this._ypos = y;
    this._sz = size;
    this._counter = 0;
    this.cIncr = 1;
    //println("created");
  }
  
  public void showOnScreen(int bright, int alpa, boolean isRec) {
    fill(bright, alpa);
    rect(this._xpos, this._ypos, this._sz, this._sz, int(this._sz/10));
    fill(bright, alpa+20);
    noStroke();
    if(isRec){
      triangle(this._xpos+5, this._ypos+5, this._xpos+5+int(this._sz/2), this._ypos+5+int(this._sz/4), this._xpos+5, this._ypos+5+int(this._sz/2));
    } else {
      rect(this._xpos, this._ypos, int(this._sz/2), int(this._sz/2));
    }
  }
  
  public boolean mouseOverButton(int mx,int my) {
    int sizeX_start = this._xpos;
    int sizeX_end = this._xpos + this._sz;
    int sizeY_start = this._ypos; 
    int sizeY_end = this._ypos + this._sz;
    if (mx > sizeX_start && mx < sizeX_end) {
      if(my > sizeY_start && my < sizeY_end) {
        this._counter = min((this._counter+this.cIncr),255);
        return true;
      } else {
        this._counter = max((this._counter-this.cIncr),50);
        return false;
      }
    } else {
        this._counter = max((this._counter-1),50);
        return false;
      }
  }
  
  public int getCounter(){
    return this._counter;
  }
  
  
}
