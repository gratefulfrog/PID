# pid_0
# implemtation od discrete pid algo as per 
# https://en.wikipedia.org/wiki/PID_controller#Pseudocode
# PID tuning as per Ziegler–Nichols method
# https://en.wikipedia.org/wiki/Ziegler%E2%80%93Nichols_method 


from animates import Animate, LongTail
from pid import PID
from buttons import PushButtonRow, LogButton
from speed import Velocity
from grid import HorizontalGrid


stop = False

target     = None  # instance of Animate that is the target
follower   = None  # instance of Animate that is following the target
controller = None  # instance of PID adjusting the follower's parameters to follow
vel        = None  # instance of Velocity class to manage the Vl & Va
grd        = None  # horizontal grid instance
lt         = None  # long tail
# for display of error values
#mx=None
#mn=None

pb = None  # PID parameter control button vector
lb = None  # Linear velocity control button
ab = None  # Angular velocity control button

# PID parameter values empirically determined by the Ziegler-Nichols method
# it is hard to do better!
defaultKp = 2.01*0.6
defaultKi = 1.1/2.0
defaultKd = 1.1/8.0

# default values for angular and linear velocities
turnFactor = 15  # number of degrees turned per step!
DistFactor = 600 # distance multiplier per step

def resetFactoryDefaults():
    global defaultKp
    global defaultKi
    global defaultKd
    global turnFactor
    global DistFactor
    defaultKp = 2.01*0.6
    defaultKi = 1.1/2.0
    defaultKd = 1.1/8.0
    DistFactor= 200
    turnFactor= 50
    
def setDefaults():
    global defaultKp
    global defaultKi
    global defaultKd
    global turnFactor
    global DistFactor
    defaultKp = controller.Kp
    defaultKi = controller.Ki
    defaultKd = controller.Kd
    turnFactor = vel.a
    DistFactor = vel.l
    
def reset():
    global target
    global follower
    global controller
    global grd
    global lt
    #global mx
    #global mn
    global pb
    global vel
    global lb
    global ab
    #targetA  = 1  # 1->2,2->4,3->6
    
    target   = Animate(vel=0,acc=0,isTarget=True)
    follower = Animate(vel=0)
    #mx=target.pos()-follower.pos()
    #mn=target.pos()-follower.pos()
    Ku = 2.01 # empirically determined following the Ziegler–Nichols method to find the value for oscillation
    Tu = 1.1 #1     # oscillation dt
    controller = PID(0,  # note the offset value of setpoint as a function of target acceleration
                     lambda : follower.pos()-target.pos(),
                     defaultKp, #Ku*0.6, #1.096, #Ku*0.6,
                     defaultKi, #Tu/2.0,
                     defaultKd) #Tu/8.0)
    grd = HorizontalGrid()
    lt = LongTail()
    pb =[]
    pb.append(PushButtonRow(100,60,controller,'Kp',[1,-1,0.1,-0.1,0.01,-0.01]))
    pb.append(PushButtonRow(100,120,controller,'Ki',[1,-1,0.1,-0.1,0.01,-0.01]))
    pb.append(PushButtonRow(100,180,controller,'Kd',[1,-1,0.1,-0.1,0.01,-0.01]))
    vel = Velocity(DistFactor,turnFactor)
    lb = LogButton(520,60,vel,'l','Linear Velocity')
    ab = LogButton(520,60+lb.pbH+lb.pbS,vel,'a', 'Angular Velocity')
    
def setup():
    size(1500,800)
    background(0)
    reset()

#def sr(n,d=2):
    """ helper function to format data for printing
    """
#    return str(round(n,d))

def deg2rad(deg):
    return deg*3.14159/180.0

# loop variables
count = 0  
pause = 100 # ms

def drawZ():
    lb.display()
    ab.display()
    
def drawIT():
    global last
    for p in pb:
        p.display()
    if last != target.v:
        print(target.v)
        last=target.v

def draw():
    """ update the target and follower,
    then compute the new follower velocticy as PID output
    and update the loop counter
    and loop.
    """
    global stop
    if stop:
        return
    global count
    #global mx
    #global mn
    background(0)
    #grd.display()
    controller.display()
    for p in pb:
        p.display()
    lb.display()
    ab.display()
    delta = target.pos()-follower.pos()
    #mx=max(mx,delta)
    #mn=min(mn,delta)
    
    """s = '%s:\tTarget: %s\tFollower: %s\tDelta: %s\tMax: %s\tMin: %s\tFollowerWidth: %s'%(str(count),sr(target.pos()),sr(follower.pos()),sr(delta),sr(mx),sr(mn),sr(follower.avWidth()))
    print(s)
    """
    #print ('%s:\tLinear V: %s\tAngular V: %s'%(str(count),str(vel.l),str(vel.a)))
    follower.display(height/2.0,delta)
    target.display(height/2.0)
    lt.display()
    target.update()
    follower.update()
    target.pos(vel.l*cos(deg2rad(count*vel.a)))
    follower.vel(controller.update())
    grd.update(vel.l*sin(deg2rad(count*vel.a)))
    lt.update(target.pos())
    displayLegend()
    count+=1
    delay(pause)
    #stop = True
    
def mouseClicked():
    global stop
    #stop = not stop

def keyPressed():
    global defaultKp
    global defaultKi
    global defaultKd
    if key == 'd' or key =='D':
        setDefaults()
    elif key == 'r' or key =='R':
        resetFactoryDefaults()
    elif key == 'q' or key == 'Q':
        exit()
    reset()
    delay(1000)
    
    
def displayLegend():
    d = 'D:\tSet current values as defaults and restart'
    r = 'R:\tfactory Reset all values and restart'
    q = 'Q:\tQuit'
    a = 'Any Other Key: Reset all values to current defautls and restart'
    line = d + '\n' + r  + '\n' + q + '\n' + a
    fill('#00FF00')
    textAlign(LEFT)
    #print(textWidth('s')*max(len(d),len(r),len(q),len(a))/2.0)
    text(line,width/2.0-3.5*max(len(d),len(r),len(q),len(a))/2.0,height-50)