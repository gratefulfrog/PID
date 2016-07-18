class PID{
  // for display of parameter values
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
  
  // code from wikipedia
  float update(float mv, float dt){
    float error = sp - mv;
    integral += error*dt;
    float derivative = (error - previousError)/dt,
          output = Kp.get()*error + Ki.get()*integral + Kd.get()*derivative;
    previousError = error;
    return output;
  }
  
  // display of parameter values, not of the PID itself
  void display(){
    int x = 2,
        y = 60;
    textAlign(LEFT,TOP);
    fill(textColor);
    String sVec[] = {"Kp: " + nf(Kp.get(),1,4), "Ki: " + nf(Ki.get(),1,4),  "Kd: " + nf(Kd.get(),1,4)};
    for (int i=0;i<3;i++){
        text(sVec[i],x,y+i*60);
    }
  }
}