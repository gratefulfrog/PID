class PushButton{
  // in this version, onclick returns the button's id which was assigned at instanciation
  // the log button has more functionality than in the python version
    final int pbW = 50,
        pbH = 50,
        pbS = 10,
        debounceDelay = 200;
    final color pushedColor = #000000,
          releasedColor = #FFFFFF,
          overColor = #646464,
          textColor = #FF0000;
    float x,y,av;
    int id, lastClickTime;
    String displayText;
    color c;
    fIndirectable fi;
    
    PushButton(float xx, float yy, fIndirectable ffi, String label, float addVal){
        x = xx;
        y = yy;
        c = releasedColor;
        lastClickTime = millis();
        fi=ffi;
        av = addVal;
        displayText = new String(label + '\n' + nfp(av,0,0));
    }
        
    void display(){
      if (isOver()){
          // we are over
          if (mousePressed){
              c = pushedColor;
              onClick();
          }
          else{
              c = overColor;
          }
      }
      else{
          c = releasedColor;
      }
      pushMatrix();
      translate(x,y);
      rectMode(CENTER);
      fill(c);
      stroke(c);
      rect(0,0,pbW,pbH);
      textAlign(CENTER,CENTER);
      fill(textColor);
      text(displayText,0,0);
      popMatrix();
      }
    
    boolean isOver(){
        float xx = x-pbW/2.0,
              yy = y-pbH/2.0;
        return(mouseX >= xx &&  mouseX <= xx+pbW && mouseY >= yy && mouseY <= yy+pbH);
    }

    void onClick(){
        if (millis() > (debounceDelay + lastClickTime)){
          fi.addV(av);
          lastClickTime = millis();
        }
    }
}