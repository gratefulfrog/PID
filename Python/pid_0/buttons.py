class PushButton ():
    pbW = 50
    pbH = 50
    pbS = 10
    pushedColor = 0
    releasedColor = '#FFFFFF'
    overColor = '#646464'
    textColor = '#FF0000'
    debounceDelay = 200

    def __init__(self, x, y, targ,field,val):
        self.x = x
        self.y = y
        self.c = PushButton.releasedColor
        self.lastClickTime = millis()
        self.val = val
        self.targ=targ
        self.field=field
        
    def display(self):
        if type(self.val) == str:  #it's a logButton
            sText = self.val + '\n' + str(round(eval('self.targ' + '.' + self.field),2))
        else:
            s = '+' if self.val>0 else ''
            sText = self.field +'\n'+ s + str(self.val)
        if self.isOver():
            # we are over
            if type(self.val) == str:  #it's a logButton
                sText = self.val + '\n' + str(round(eval('self.targ' + '.' + self.field)*self.getFactor(mouseX),2))
                #print(sText)
                #print (eval('self.targ' + '.' + self.field)*self.getFactor(mouseX))
            if mousePressed:
                self.c = PushButton.pushedColor
                self.onClick()
            else:
                self.c = PushButton.overColor
        else:
            self.c = PushButton.releasedColor
        pushMatrix()
        translate(self.x,self.y)
        rectMode(CENTER)
        fill(self.c)
        stroke(self.c)
        rect(0,0,self.pbW,self.pbH)
        textAlign(CENTER,CENTER)
        fill(PushButton.textColor)
        text(sText,0,0)
        popMatrix()
    
    def isOver(self):
        xx = self.x-self.pbW/2.0
        yy = self.y-self.pbH/2.0
        return(mouseX > xx and  mouseX < xx+self.pbW and mouseY > yy and mouseY < yy+self.pbH)

    def onClick(self):
        if millis() > PushButton.debounceDelay + self.lastClickTime:
            #print('pb id:\t' + hex(self.id))
            s ='self.targ' +'.' + self.field + ' += self.val'
            print(s)
            exec(s)
            print(eval('self.targ' +'.' + self.field))
            self.lastClickTime = millis()


class PushButtonRow:
    def __init__(self,x,y,targ,field,valLis):
        self.pbVec = []
        for i in range(len(valLis)):
            self.pbVec.append(PushButton(x+(PushButton.pbW+PushButton.pbS)*i,
                                         y,
                                         targ,
                                         field,
                                         valLis[i]))
    
    def display(self):
        for pb in self.pbVec:
            pb.display()
            

def mapVal (val,inRange,outRange):
    return ((val-inRange[0])*(outRange[1]-outRange[0])/(inRange[1]-inRange[0])) + outRange[0]

class LogButton(PushButton):
    pbW = 150
    pbH = 50
    
    def __init__(self,x,y,target,field,name):
       PushButton.__init__(self,x,y,target,field,name)
    
    def getFactor(self,clickX):
        offset= clickX - (self.x- self.pbW/2.0)
        #print(clickX,self.x)
        logRangeVec = ((0,self.pbW/2.0),
                       (self.pbW/2.0,self.pbW))
        factorRangeVec = ((0.1,1),
                          (1,10))
                           
        for i in range(len(logRangeVec)):
            if offset <= logRangeVec[i][1]:
                return mapVal(offset,logRangeVec[i],factorRangeVec[i])
            
    def onClick(self):
        if millis() > PushButton.debounceDelay + self.lastClickTime:
            s ='self.targ' +  ' *=' + str(self.getFactor(mouseX))
            #print(s)
            s ='self.targ' +'.' + self.field + ' *=' + str(self.getFactor(mouseX))
            #print(s)
            exec(s)
            #print(eval('self.targ' +'.' + self.field))
            self.lastClickTime = millis()

        
        