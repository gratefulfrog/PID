/* pid_0 processing version
 * pid_0
 * implemtation od discrete pid algo as per 
 * https://en.wikipedia.org/wiki/PID_controller#Pseudocode
 * PID tuning as per Ziegler–Nichols method
 * https://en.wikipedia.org/wiki/Ziegler%E2%80%93Nichols_method 
 */

App app;

final Defaults defaults =  new Defaults();

void settings() {
   size(defaults.windowWidth,defaults.windowHeight);
}

void setup(){
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
  delay(pause);
}

void keyPressed(){
  switch(key){
    case 'd':
    case 'D':
      println('D');
      app.setDefaults();
      break;
    case 'r':
    case 'R':
      println('R');
      defaults.resetFactoryDefaults();
      break;
    case 'q':
    case 'Q':
      exit();
      break;
  }
  app.reset();
  delay(1000);
}
void displayLegend(){
  final String d = "D:\tSet current values as defaults and restart",
               r = "R:\tfactory Reset all values and restart",
               q = "Q:\tQuit",
               a = "Any Other Key: Reset all values to current defautls and restart",
               line = d + "\n" + r + "\n" + q + "\n" + a; 

  fill(#00FF00);
  textAlign(LEFT);
  text(line,width/2.0-3.5*(max(max(d.length(),r.length(),q.length()),a.length()))/2.0,height-50);
}

void resetFactoryDefaults(){
    defaults.defaultKp = defaults.defaultKpFactory;
    defaults.defaultKi = defaults.defaultKiFactory;
    defaults.defaultKd = defaults.defaultKdFactory;
    defaults.distFactor= defaults.distFactorFactory;
    defaults.turnFactor= defaults.turnFactorFactory;
}

float deg2rad(float deg){
    return deg*3.14159/180.0;
}