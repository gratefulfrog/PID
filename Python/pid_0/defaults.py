# PID parameter values empirically determined by the Ziegler-Nichols method
# it is hard to do better!
_Ku = 2.01 # empirically determined following the Ziegler-Nichols method to find the value for oscillation
_Tu = 1.1  # oscillation dt
class Defaults():
    defaultKp = _Ku*0.6
    defaultKi = _Tu/2.0
    defaultKd = _Tu/8.0
    
    defaultKpFactory = _Ku*0.6
    defaultKiFactory = _Tu/2.0
    defaultKdFactory = _Tu/8.0
    
    # default values for angular and linear velocities
    turnFactor = 15  # number of degrees turned per step!
    distFactor = 600 # distance multiplier per step
    
    turnFactorFactory = 15  
    distFactorFactory = 600 
    
    windowWidth  = 1500
    windowHeight = 800
    
    # y factor is multiplied by height to determine vertical position of target
    yFactor = 0.75
    
    # for the long tail
    tailLength = 50
    tailStepHeight = windowHeight*yFactor/tailLength
    
def resetFactoryDefaults():
    Defaults.defaultKp = Defaults.defaultKpFactory
    Defaults.defaultKi = Defaults.defaultKiFactory
    Defaults.defaultKd = Defaults.defaultKdFactory
    Defaults.distFactor= Defaults.distFactorFactory
    Defaults.turnFactor= Defaults.turnFactorFactory

#def sr(n,d=2):
    """ helper function to format data for printing
    """
#    return str(round(n,d))

def deg2rad(deg):
    return deg*3.14159/180.0
