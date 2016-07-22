/* pid_1 processing JS version
 * pid_1
 * implemtation od discrete pid algo as per 
 * https://en.wikipedia.org/wiki/PID_controller#Pseudocode
 * PID tuning as per Ziegler–Nichols method
 * https://en.wikipedia.org/wiki/Ziegler%E2%80%93Nichols_method 
 */

App app;

final Defaults defaults =  new Defaults();

/*
void settings() {
   size(defaults.windowWidth,defaults.windowHeight);
}
*/
void setup(){
  size(1500,800);
  frameRate(15);  // nb steps per second
  background(0);
  app = new App();
  }

//  loop variables
long count = 0;
final int pause = 100; // delay for loop in ms

void draw(){
  background(0);
  app.display(count++);
  displayLegend();
  //delay(pause);
}

void keyPressed(){
  switch(key){
    case 'd':
    case 'D':
      app.setDefaults();
      break;
    case 'r':
    case 'R':
      defaults.resetFactoryDefaults();
      break;
    case 'q':
    case 'Q':
      exit();
      break;
  }
  app.reset();
  delay(pause*2);
}
void displayLegend(){
  final String d = "D:\tSet current values as defaults and restart",
               r = "R:\tfactory Reset all values and restart",
               q = "Q:\tQuit",
               a = "Any Other Key: Reset all values to current defautls and restart",
               v = "Clicking the Velocity buttons changes the value according to where clicked",
               line = d + "\n" + r + "\n" + q + "\n" + a  + "\n" + v; 

  fill(#00FF00);
  textAlign(LEFT);
  text(line,width/2.0-3.5*(max(max(d.length(),r.length(),q.length()),a.length()))/2.0,height-60);
}

void resetFactoryDefaults(){
    defaults.defaultXKp = defaults.defaultKpFactory;
    defaults.defaultXKi = defaults.defaultKiFactory;
    defaults.defaultXKd = defaults.defaultKdFactory;
    defaults.defaultYKp = defaults.defaultKpFactory;
    defaults.defaultYKi = defaults.defaultKiFactory;
    defaults.defaultYKd = defaults.defaultKdFactory;
    defaults.distFactor= defaults.distFactorFactory;
    defaults.turnFactor= defaults.turnFactorFactory;
}

float deg2rad(float deg){
    return deg*3.14159/180.0;
}