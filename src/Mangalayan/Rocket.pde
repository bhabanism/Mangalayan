class Rocket {

  PVector location;
  PVector velocity;
  PVector acceleration;  
  int fuel;  
  float scaleForFuel = 2;
  int r,g,b;
  
  //genes
  final PVector launchLocation;
  final PVector initialThurst;
  final float mass;
  

  Rocket(float mass, PVector launchLocation, PVector initialThurst) {
    this.mass = mass;
    this.initialThurst = new PVector(initialThurst.x, initialThurst.y);
    this.launchLocation = new PVector(launchLocation.x, launchLocation.y);
    
    this.location = launchLocation;
    velocity = new PVector(0, 0);
    acceleration = initialThurst;
    fuel = (int)(height*mass*scaleForFuel); //fuel proportional to mass, twice the height to give enough time for rocket to revolve a few times
    this.setColor((int)random(255),(int)random(255),(int)random(255));
  }
  
  Rocket(Rocket rocket) {
    this(rocket.getMass(), rocket.getLaunchLocation(), rocket.getInitialThurst());    
  }
  
  float getMass() {
    return this.mass;
  }
  
  PVector getLaunchLocation() {
    return this.launchLocation;
  }
  
  PVector getInitialThurst() {
    return this.initialThurst;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  boolean isAlive() {
    return fuel > 0 ? true: false;
  }
  
  void setColor(int r,int g,int b) {
    this.r = r;
    this.g = g;
    this.b = b;    
  }

  void display() {
    stroke(0);
    strokeWeight(0);
    fill(r,g,b);
    ellipse(location.x, location.y, mass*5, mass*5);
    fuel--;
  }
}