class PID{
  // for display of parameter values
  final color textColor = #00FF00;
  
  int id;
  char name;
  float previousError = 0,
        integral = 0,
        sp = 0;
  fIndirectable Kp,
                Ki,
                Kd; 
  
  PID(int idd,char axis,float setPoint,float KP,float KI,float KD){
    id = idd;
    name = axis;
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
        y = 60*(id*3+1);
    textAlign(LEFT,TOP);
    fill(textColor);
    String sVec[] = {name + "Kp: " + nf(Kp.get(),0,4), name + "Ki: " + nf(Ki.get(),0,4),  name + "Kd: " + nf(Kd.get(),0,4)};
    for (int i=0;i<3;i++){
        text(sVec[i],x,y+i*60);
    }
  }
}