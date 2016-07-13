

class PID{
  final color textColor = #00FF00;
  
  float previousError = 0,
        integral = 0,
        sp = 0;
  fIndirectable Kp,
                Ki,
                Kd; 
  
  PID(float setPoint,float KP,float KI,float KD){
    sp = setPoint;
    Kp = new fIndirectable(KP);
    Ki = new fIndirectable(KI);
    Kd = new fIndirectable(KD);
  }
  
  float update(float mv, float dt){
    float error = sp - mv;
    integral += error*dt;
    float derivative = (error - previousError)/dt,
          output = Kp.get()*error + Ki.get()*integral + Kd.get()*derivative;
    previousError = error;
    return output;
  }
  
  void display(){
    int x = 2,
        y = 60;
    textAlign(LEFT,TOP);
    fill(textColor);
    String sVec[] = {"Kp: " + nf(Kp.get(),0,4), "Ki: " + nf(Ki.get(),0,4),  "Kd: " + nf(Kd.get(),0,4)};
    for (int i=0;i<3;i++){
        text(sVec[i],x,y+i*60);
    }
  }
}
        