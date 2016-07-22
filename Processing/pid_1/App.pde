class App {
  final float deltaT = 1.0;
  
  Animate8 target;
  Animate  follower;
  PID controllerX, controllerY;
  LongTail lt;
  PushButtonAdderRow pbRVec[];
  laVelocity vel;
  PushButton lb,
             ab;
  
  App(){
    reset();
  }
  void display(long count){
    // first displlay the values and buttons
    
    controllerX.display();
    controllerY.display();
    for(int i=0;i< pbRVec.length;i++){ 
      pbRVec[i].display();
    }
    lb.display();
    ab.display();
    
    // now display the animate objects
    float deltaX = target.pos()[0]- follower.pos()[0],
          deltaY = target.pos()[1]- follower.pos()[1];
    follower.displayD(deltaX,deltaY);
    //followerX.display();
    target.display();
    lt.display();
    
    // now update the animate objects
 
    target.update(deltaT);
    follower.update(deltaT);
    float vX = controllerX.update(follower.pos()[0]-target.pos()[0],deltaT),
          vY = controllerY.update(follower.pos()[1]-target.pos()[1],deltaT);
    follower.vel(vX,vY);
    lt.update(target.pos()[0],target.pos()[1]);
  }
  
  void reset(){
    //target = new Animate(true);
    vel = new laVelocity(50,defaults.turnFactor);
    target = new Animate8(vel);
    follower = new Animate(false);
    controllerX =  new PID(0, 'X', 0,
                          defaults.defaultXKp,  //Ku*0.6,
                          defaults.defaultXKi,  //Tu/2.0,
                          defaults.defaultXKd); //Tu/8.0)
    controllerY =  new PID(1,'Y',0,
                          defaults.defaultYKp,  //Ku*0.6,
                          defaults.defaultYKi,  //Tu/2.0,
                          defaults.defaultYKd); //Tu/8.0)
    lt = new LongTail();

    pbRVec = new PushButtonAdderRow[6];
    float valVec[] = {1,-1,0.1,-0.1,0.01,-0.01};
    pbRVec[0] =  new PushButtonAdderRow(100,60,controllerX.Kp, "Kp",valVec);
    pbRVec[1] =  new PushButtonAdderRow(100,120,controllerX.Ki, "Ki",valVec);
    pbRVec[2] =  new PushButtonAdderRow(100,180,controllerX.Kd, "Kd",valVec);
    pbRVec[3] =  new PushButtonAdderRow(100,240,controllerY.Kp, "Kp",valVec);
    pbRVec[4] =  new PushButtonAdderRow(100,300,controllerY.Ki, "Ki",valVec);
    pbRVec[5] =  new PushButtonAdderRow(100,360,controllerY.Kd, "Kd",valVec);


    lb = new PushButtonLogMultiplier(520.0,60.0,vel.l,"Linear Velocity",2.0);
    ab = new PushButtonLogMultiplier(520,60+lb.pbH+lb.pbS,vel.a, "Angular Velocity",2.0);
    target.vel(20,20);
    //println(target.vel());
    
  }
  void setDefaults(){
        defaults.defaultXKp = controllerX.Kp.get();
        defaults.defaultXKi = controllerX.Ki.get();
        defaults.defaultXKd = controllerX.Kd.get();
        defaults.defaultYKp = controllerY.Kp.get();
        defaults.defaultYKi = controllerY.Ki.get();
        defaults.defaultYKd = controllerY.Kd.get();
        defaults.turnFactor = vel.a.get();
        defaults.distFactor = vel.l.get();
  }
}