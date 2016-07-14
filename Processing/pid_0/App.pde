class App {
  final float deltaT = 1.0;
  
  Animate target,
          follower;
  PID controller;
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
    controller.display();
    for(int i=0;i< pbRVec.length;i++){ 
      pbRVec[i].display();
    }
    lb.display();
    ab.display();
    
    // now display the animate objects
    float delta = target.pos()- follower.pos();
    follower.display(height*defaults.yFactor,delta);
    target.display(height*defaults.yFactor);
    lt.display();
    
    // now update the animate objects
    target.update(deltaT);
    follower.update(deltaT);
    target.pos(vel.l.get()*cos(deg2rad(count*vel.a.get())));
    // note that the delta needs to be recomputed before calling the PID!
    follower.vel(controller.update(follower.pos()-target.pos(),deltaT));
    lt.update(target.pos());
  }
  
  void reset(){
    target = new Animate(true);
    follower = new Animate(false);
    controller =  new PID(0,
                          defaults.defaultKp,  //Ku*0.6,
                          defaults.defaultKi,  //Tu/2.0,
                          defaults.defaultKd); //Tu/8.0)
    lt = new LongTail();

    pbRVec = new PushButtonAdderRow[3];
    float valVec[] = {1,-1,0.1,-0.1,0.01,-0.01};
    pbRVec[0] =  new PushButtonAdderRow(100,60,controller.Kp, "Kp",valVec);
    pbRVec[1] =  new PushButtonAdderRow(100,120,controller.Ki, "Ki",valVec);
    pbRVec[2] =  new PushButtonAdderRow(100,180,controller.Kd, "Kd",valVec);

    vel = new laVelocity(defaults.distFactor,defaults.turnFactor);
    lb = new PushButtonLogMultiplier(520.0,60.0,vel.l,"Linear Velocity",2.0);
    ab = new PushButtonLogMultiplier(520,60+lb.pbH+lb.pbS,vel.a, "Angular Velocity",2.0);
    
  }
  void setDefaults(){
        defaults.defaultKp = controller.Kp.get();
        defaults.defaultKi = controller.Ki.get();
        defaults.defaultKd = controller.Kd.get();
        defaults.turnFactor = vel.a.get();
        defaults.distFactor = vel.l.get();
  }
}