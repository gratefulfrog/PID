final color red   = #FF0000,
            green = #00FF00,
            blue  = #0000FF,
            targetColor = red,
            followerColor = green;

final float targetWidth = 50.0,
            followerWidth = 50.0;
        
class Animate{
  /* Instances move according to the laws of kinematics, 
    * discretely changing state as per:
    * first calculate new position based on current velocity and accelarations
    * then compute new velocity
    */
    
    float p = 0,
          v = 0,
          a = 0,
          widthVec[] = new float[10];
          
    int wi = 0;
    
    color col = targetColor;
        
    Animate(boolean isTarget){
      if (isTarget){
        for (int i=0;i<10;i++){
          widthVec[i] = targetWidth;
        }
      }
      else{
        col = followerColor;
        for (int i=0;i<10;i++){
          widthVec[i] = followerWidth;
        }
      }
    }
    
    void display(float y){
      //text("display",p,100);
      pushMatrix();
      translate(width/2.0+p,y);
      fill(col);
      stroke(col);
      ellipseMode(CENTER);
      ellipse(0,0,maxWidth(),maxWidth());
      wi = (wi +1)%10;
      popMatrix();
    }
    void display(float y, float delta){
      widthVec[wi] = 2*(abs(delta)+targetWidth/2.0);
      display(y);
      textAlign(CENTER);
      text("Follower Width: " + str(round(maxWidth())),230,20);
    }
    
    float maxWidth(){
      float res = 0;
      for (int i=0;i<10;i++){
        res = max(res,widthVec[i]);
      }
      return res;
    }
    
    void update(float dt){
     p += 0.5*a*dt*dt + v*dt;
     v += a*dt;
    }
    float pos(){ return p;}
    float vel(){ return v;}
    float acc(){ return a;}

    float pos(float nw){ return p=nw;}
    float vel(float nw){ return v=nw;}
    float acc(float nw){ return a=nw;}
}

class LongTail{
  float coords[] =  new float[defaults.tailLength];
  int nbCoords = 0;
  
  LongTail(){}
  
  void update(float xVal){
    for (int i=defaults.tailLength-1;i>0;i--){
      coords[i]=coords[i-1];
    }
    coords[0]=xVal;
    nbCoords=min(defaults.tailLength,++nbCoords);
  }
  void display (){
    pushMatrix();
    translate(width/2.0,height*defaults.yFactor);
    fill(targetColor);
    stroke(targetColor);
    ellipseMode(CENTER);
    for (int i=1;i<nbCoords;i++){
      ellipse(coords[i],-defaults.tailStepHeight*i,targetWidth/(0.9*(i+1)),targetWidth/(0.9*(i+1)));
    }
    popMatrix();
  }
}
     