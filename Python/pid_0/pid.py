class PID():
    textColor = '#00FF00'
    
    def __init__(self,setPoint, MVFunc, KP,KI,KD):
        """ args are all what they seem to be, except MVFunc which is a function
        that when called with no arguments, will return the process's Measured Value
        """
        self.previousError = 0
        self.integral = 0
        self.sp = setPoint
        self.mvf = MVFunc
        self.Kp = KP
        self.Ki = KI
        self.Kd = KD 
    
    def update(self,dt=1):
        error = self.sp - self.mvf()
        self.integral += error*dt
        derivative = (error - self.previousError)/dt
        output = self.Kp*error + self.Ki*self.integral + self.Kd*derivative
        self.previousError = error
        return output
    
    def display(self):
        x = 2
        y = 60
        textAlign(LEFT,TOP)
        fill(PID.textColor)
        sVec= ['Kp: ' + str(self.Kp), 'Ki: ' + str(self.Ki),  'Kd: '+str(self.Kd)]
        for i in range(len(sVec)):
            text(sVec[i],x,y+i*60)
        