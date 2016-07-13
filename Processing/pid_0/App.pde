class App {
  final float deltaT = 1;
  
  Animate target,
          follower;
  PID controller;
  LongTail lt;
  PushButton pb;
  /*PushButtonRow pb[3];
  */
  laVelocity vel;
  /*LogButton lb,
            ab;
  */
  
  App(){
    reset();
  }
  void display(long count){
    pb.display();
    controller.display();
    /*    for p in self.pb:
            p.display()
        self.lb.display()
        self.ab.display()
    */
    float delta = target.pos()- follower.pos();
    
    follower.display(height*defaults.yFactor,delta);
    target.display(height*defaults.yFactor);
    //lt.display()
    target.update(deltaT);
    follower.update(deltaT);
    //target.pos(vel.l*cos(deg2rad(count*vel.a)));
    follower.vel(controller.update(delta,deltaT));
    /*grd.update(vel.l*sin(deg2rad(count*vel.a)));*/
    //lt.update(target.pos());
  }
  void reset(){
    target = new Animate(true);
    follower = new Animate(false);
    controller =  new PID(0,
                          defaults.defaultKp,  //Ku*0.6,
                          defaults.defaultKi,  //Tu/2.0,
                          defaults.defaultKd); //Tu/8.0)
    pb = new PushButton(500,100,controller.Ki,"Ki",0.01);
    /*grd = HorizontalGrid(); */
    lt = new LongTail();
    /*pb =[];
    pb.append(PushButtonRow(100,60,self.controller,'Kp',[1,-1,0.1,-0.1,0.01,-0.01]))
    pb.append(PushButtonRow(100,120,self.controller,'Ki',[1,-1,0.1,-0.1,0.01,-0.01]))
    pb.append(PushButtonRow(100,180,self.controller,'Kd',[1,-1,0.1,-0.1,0.01,-0.01]))
    */
    vel = new laVelocity(defaults.distFactor,defaults.turnFactor);
    /*lb = LogButton(520,60,vel,'l',"Linear Velocity");
    ab = LogButton(520,60+lb.pbH+lb.pbS,vel,'a', "Angular Velocity");
    */
  }
  void setDefaults(){
        defaults.defaultKp = controller.Kp.get();
        defaults.defaultKi = controller.Ki.get();
        defaults.defaultKd = controller.Kd.get();
        defaults.turnFactor = vel.a.get();
        defaults.distFactor = vel.l.get();
  }
}