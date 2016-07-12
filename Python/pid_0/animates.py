from defaults import Defaults

class Animate ():
    """ Instances move according to the laws of kinematics, 
    discretely changing state as per:
    * first calculate new position based on current velocity and accelarations
    * then compute new velocity
    """
    red   = '#FF0000'
    green = '#00FF00'
    blue  = '#0000FF'
    targetColor = red
    followerColor = green
    targetWidth = 50
    followerWidth = 50
    
    def __init__(self,pos=0,vel=0,acc=0,isTarget=False):
        self.p = pos
        self.v = vel
        self.a = acc
        self.wi = 0
        self.width = [Animate.targetWidth for x in range(10)]
        self.color = Animate.targetColor
        if  isTarget:
            self.display = self.displayTarget 
        else:
            self.display =  self.displayFollower
            self.width = [Animate.followerWidth for x in range(10)]
            self.color = Animate.followerColor
            
    def displayTarget(self,y):
        pushMatrix()
        translate(width/2.0+self.p,y)
        fill(self.color)
        stroke(self.color)
        ellipseMode(CENTER)
        ellipse(0,0,self.avWidth(),self.avWidth())
        self.wi = (self.wi + 1)%10
        popMatrix()
    
    def displayFollower(self,y,delta):
        #self.width = 2*max(self.width/2.0,abs(delta)+Animate.targetWidth/2.0)
        self.width[self.wi] = 2*(abs(delta)+Animate.targetWidth/2.0)
        self.displayTarget(y)
        textAlign(CENTER)
        text('Follower Width: ' + str(round(self.avWidth(),2)),230,20)
        
    def avWidth(self):
        s=0
        for v in self.width:
            s=max(s,v)
        return s
    
    def update(self,dt=1):
        """ calculate new values after elapsed time dt
        """
        self.p +=  0.5*self.a*dt*dt + self.v*dt
        self.v += self.a*dt

    def pos(self,new=None):
        """ if arg is None, return position,
        otherwise set position to arg value and return new position
        """
        if new != None:
            self.p = new
        return self.p
    def vel(self,new=None):
        """ if arg is None, return velocity,
        otherwise set velocity to arg value and return new velocity
        """
        if new != None:
            self.v = new
        return self.v
    def acc(self,new=None):
        """ if arg is None, return acceleration,
        otherwise set acceleration to arg value and return new acceleration
        """
        if new != None:
            self.a = new
        return self.a
    
class LongTail():
  
    def __init__(self):
        self.coords = []
        
    def update(self,xVal):
        self.coords = [xVal,] +self.coords
        
        if len(self.coords)> Defaults.tailLength:
            self.coords =  self.coords[0:Defaults.tailLength]
        #print(self.coords)
        
    def display (self):
        pushMatrix()
        translate(width/2.0,height*Defaults.yFactor)
        fill(Animate.targetColor)
        stroke(Animate.targetColor)
        ellipseMode(CENTER)
        i=1
        for x in self.coords[1:]:
            ellipse(x,-Defaults.tailStepHeight*i,Animate.targetWidth/(0.9*(i+1)),Animate.targetWidth/(0.9*(i+1)))
            i+=1
        popMatrix()