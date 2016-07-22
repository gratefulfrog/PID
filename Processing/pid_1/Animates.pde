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
    
    float p[] = {0,0},
          v[] = {0,0},
          a[] = {0,0},
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

    void display(){
      pushMatrix();
      translate(p[0],p[1]);
      fill(col);
      stroke(col);
      ellipseMode(CENTER);
      ellipse(0,0,maxWidth(),maxWidth());
      wi = (wi +1)%10;
      popMatrix();
    }

  void displayD(float deltaX, float deltaY){
    widthVec[wi] = 2*(sqrt(deltaX*deltaX+deltaY*deltaY)+targetWidth/2.0);
    display();
    textAlign(CENTER);
    text("Follower Width: " + str(round(maxWidth())),230,20);
    }

    void display(float y){
      pushMatrix();
      translate(p[0],y);
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
      for (int i=0;i<2;i++){
       p[i] += 0.5*a[i]*dt*dt + v[i]*dt;
       v[i] += a[i]*dt;
      }
    }
    float[] pos(){ return p;}
    float[] vel(){ return v;}
    float[] acc(){ return a;}

    float[] pos(float nw0, float nw1){ 
      p[0] = nw0;
      p[1] = nw1;
    return p;
  }
    float[] vel(float nw0, float nw1){ 
      v[0] = nw0;
      v[1] = nw1;
    return v;
  }
    float[] acc(float nw0, float nw1){ 
      a[0] = nw0;
      a[1] = nw1;
    return a;
  }
}

class Animate8 extends Animate{
  float currentHeading = 0;
  laVelocity laV;
  int vDir = 1;
  long count = 1;
  
  Animate8(laVelocity fi){
    super(true);
    laV = fi;
    //degsPerStep = speed;
    p[0] = width/2.0;
    p[1] = 100;
  }
  void update(float dt){
    for (int i=0;i<2;i++){
       p[i] += 0.5*a[i]*dt*dt + v[i]*dt;
       v[i] += a[i]*dt;
      }
    currentHeading += deg2rad(laV.a.get()*dt);
    v[0] = laV.l.get()*cos(currentHeading);
    if (currentHeading > count*2*3.14159){
      count+=1;
      vDir = -vDir;
    }
    v[1] = laV.l.get()*vDir*abs(sin(currentHeading));
  }
}

class LongTail{
  float coords[][] =  new float[defaults.tailLength][2];
  int nbCoords = 0;
  
  LongTail(){}
  
  void update(float xVal, float yVal){
    for (int i=defaults.tailLength-1;i>0;i--){
      coords[i][0]=coords[i-1][0];
      coords[i][1]=coords[i-1][1];
    }
    coords[0][0]=xVal;
    coords[0][1]=yVal;
    nbCoords=min(defaults.tailLength,++nbCoords);
  }
  void display (){
    fill(targetColor);
    stroke(targetColor);
    ellipseMode(CENTER);
    for (int i=1;i<nbCoords;i++){
      ellipse(coords[i][0],coords[i][1],targetWidth/(0.9*(i+1)),targetWidth/(0.9*(i+1)));
    }
    //println(nbCoords);
  }

  
  /*
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
  */
}
     