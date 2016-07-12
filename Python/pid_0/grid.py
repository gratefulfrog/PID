class HorizontalGrid():
    vSpace = 20
    col = '#B4B4B4'
    def __init__(self,startY=0):
        self.y = startY
    
    def display(self):
        y=self.y
        stroke(self.col)
        while y<=height:
            line(0,y,width,y)
            y+= self.vSpace

    def update(self,startY):
        self.y=startY % self.vSpace