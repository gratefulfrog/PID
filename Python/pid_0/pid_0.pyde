# pid_0
# implemtation od discrete pid algo as per 
# https://en.wikipedia.org/wiki/PID_controller#Pseudocode
# PID tuning as per Ziegler–Nichols method
# https://en.wikipedia.org/wiki/Ziegler%E2%80%93Nichols_method 


from defaults import *
from app import App

# global variable to contain the App instance
app = None

def settings():
    size(Defaults.windowWidth,Defaults.windowHeight)

def setup():
    global app
    background(0)
    app = App()

# loop variables
count = 0  
pause = 100 # ms

def draw():
    global app
    global count
    background(0)
    app.display(count)
    displayLegend()
    count+=1
    delay(pause)
            
def keyPressed():
    global app
    if key == 'd' or key =='D':
        app.setDefaults()
    elif key == 'r' or key =='R':
        resetFactoryDefaults()
    elif key == 'q' or key == 'Q':
        exit()
    app.reset()
    delay(1000)
    
    
def displayLegend():
    d = 'D:\tSet current values as defaults and restart'
    r = 'R:\tfactory Reset all values and restart'
    q = 'Q:\tQuit'
    a = 'Any Other Key: Reset all values to current defautls and restart'
    line = d + '\n' + r  + '\n' + q + '\n' + a
    fill('#00FF00')
    textAlign(LEFT)
    text(line,width/2.0-3.5*max(len(d),len(r),len(q),len(a))/2.0,height-50)