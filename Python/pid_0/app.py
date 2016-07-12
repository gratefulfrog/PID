from animates import Animate, LongTail
from pid import PID
from buttons import PushButtonRow, LogButton
from speed import Velocity
from grid import HorizontalGrid
from defaults import *

class App:
    
    def __init__(self):
        self.reset()
        
    def reset(self):
        self.target   = Animate(vel=0,acc=0,isTarget=True)
        self.follower = Animate(vel=0)
        self.controller = PID(0,  # note the offset value of setpoint as a function of target acceleration
                              lambda : self.follower.pos()-self.target.pos(),
                              Defaults.defaultKp, #Ku*0.6,
                              Defaults.defaultKi, #Tu/2.0,
                              Defaults.defaultKd) #Tu/8.0)
        #self.grd = HorizontalGrid()
        self.lt = LongTail()
        self.pb =[]
        self.pb.append(PushButtonRow(100,60,self.controller,'Kp',[1,-1,0.1,-0.1,0.01,-0.01]))
        self.pb.append(PushButtonRow(100,120,self.controller,'Ki',[1,-1,0.1,-0.1,0.01,-0.01]))
        self.pb.append(PushButtonRow(100,180,self.controller,'Kd',[1,-1,0.1,-0.1,0.01,-0.01]))
        self.vel = Velocity(Defaults.distFactor,Defaults.turnFactor)
        self.lb = LogButton(520,60,self.vel,'l','Linear Velocity')
        self.ab = LogButton(520,60+self.lb.pbH+self.lb.pbS,self.vel,'a', 'Angular Velocity')

    def display(self,count):
        """ update the target and follower,
        then compute the new follower velocticy as PID output
        and update the loop counter
        and loop.
        """
        #grd.display()
        self.controller.display()
        for p in self.pb:
            p.display()
        self.lb.display()
        self.ab.display()
        delta = self.target.pos()-self.follower.pos()
        
        #s = '%s:\tTarget: %s\tFollower: %s\tDelta: %s\\tFollowerWidth: %s'%(str(count),sr(target.pos()),sr(follower.pos()),sr(delta),sr(follower.avWidth()))
        #print(s)
        
        #print ('%s:\tLinear V: %s\tAngular V: %s'%(str(count),str(vel.l),str(vel.a)))
        self.follower.display(height*Defaults.yFactor,delta)
        self.target.display(height*Defaults.yFactor)
        self.lt.display()
        self.target.update()
        self.follower.update()
        self.target.pos(self.vel.l*cos(deg2rad(count*self.vel.a)))
        self.follower.vel(self.controller.update())
        #self.grd.update(vel.l*sin(deg2rad(count*vel.a)))
        self.lt.update(self.target.pos())

    def setDefaults(self):
        Defaults.defaultKp = self.controller.Kp
        Defaults.defaultKi = self.controller.Ki
        Defaults.defaultKd = self.controller.Kd
        Defaults.turnFactor = self.vel.a
        Defaults.distFactor = self.vel.l