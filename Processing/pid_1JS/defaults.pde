class Defaults{
  // main windows defaults:
  final int windowWidth  = 1500,
            windowHeight = 800;
  
  // for the long tail:
  final int tailLength = 20;
  
  // PID parameter values empirically determined by the Ziegler-Nichols method
  // it is hard to do better!
  final float _Ku = 2.01, // empirically determined following the Ziegler-Nichols method to find the value for oscillation
              _Tu = 1.1,  // oscillation dt
               
              defaultKpFactory = _Ku*0.6,
              defaultKiFactory = _Tu/2.0,
              defaultKdFactory = _Tu/8.0,
              
              turnFactorFactory = 20,  
              distFactorFactory = 50; 
                        
 float defaultXKp = defaultKpFactory,
       defaultXKi = defaultKiFactory,
       defaultXKd = defaultKdFactory,
       defaultYKp = defaultKpFactory,
       defaultYKi = defaultKiFactory,
       defaultYKd = defaultKdFactory,
       // default values for angular and linear velocities
       turnFactor = turnFactorFactory,  // number of degrees turned per step!
       distFactor = distFactorFactory; // distance multiplier per step;
            
  Defaults(){};
  
  void  resetFactoryDefaults(){
    defaultXKp = defaultKpFactory;
    defaultXKi = defaultKiFactory;
    defaultXKd = defaultKdFactory;
    defaultYKp = defaultKpFactory;
    defaultYKi = defaultKiFactory;
    defaultYKd = defaultKdFactory;
    distFactor= distFactorFactory;
    turnFactor= turnFactorFactory;
  }
}