class Rocket {

  PVector location;
  PVector velocity;
  PVector acceleration;  
  int fuel;  
  float scaleForFuel = 1.5;
  int r,g,b;
  float fitness = 0;
  
  //genes
  final PVector launchLocation;
  final PVector initialThurst;
  final float mass;
  

  Rocket(float mass, PVector launchLocation, PVector initialThurst) {
    this.mass = mass;
    this.initialThurst = new PVector(initialThurst.x, initialThurst.y);
    this.launchLocation = new PVector(launchLocation.x, launchLocation.y);
    
    this.location = new PVector(launchLocation.x, launchLocation.y);
    velocity = new PVector(0, 0);
    acceleration = initialThurst;
    fuel = getInitialFuel(); //fuel proportional to mass, twice the width to give enough time for rocket to revolve a few times
    this.setColor((int)random(255),(int)random(255),(int)random(255));
  }
  
  Rocket(Rocket rocket, float r) {
    //PVector location = new PVector(rocket.getInitialThurst().x * random(0.9,1.1), rocket.getInitialThurst().y * random(0.9,1.1));
    this(rocket.getMass() * random(0.9,1.1), 
      new PVector(rocket.getLaunchLocation().x * random(1-mutationRate,1+mutationRate), rocket.getLaunchLocation().y * random(1-mutationRate,1+mutationRate)), 
      new PVector(rocket.getInitialThurst().x * random(1-mutationRate,1+mutationRate), rocket.getInitialThurst().y * random(1-mutationRate,1+mutationRate)));    
  }  
  
  int getInitialFuel() {    
    return (int)(width*mass*scaleForFuel);
  }
  
  boolean lowFuel() {
     return 100 * fuel / getInitialFuel() < 30 ? true : false;  
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
    fuel--;
    //TODO add fuel penalty for take off delay
  }
  
  void spendFuelToTransmit() {
    fuel-=50;
  }
  
  void calculateFitness(Planet planet) {
    float d = planet.getLocation().dist(this.location);
    if(d < 20) {
      fitness = fitness * 0.01;
      return;
    }
    float ratio = width/d;
    fitness += map(ratio, 0, 150, 0, 10);
    //float inverseDistance = 1 / (planet.getLocation().dist(this.location) - 100) ;
    //fitness = map(inverseDistance, 0, 1, 0, 100);
  }
  
  boolean isFitToClone(float avgScore) {
    return fitness > avgScore && fuel%200 == 0 && noise(random(10)) < 0.5? true : false;
  }
  
  boolean isAlive() {
    return fuel > 0 ? true: false;
  }
  
  void destroy() {
    fitness = 0;
    fuel = 0;
  }
  
  PVector getLocation() {
    return new PVector(location.x, location.y);
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
    ellipse(location.x, location.y, mass*1, mass*1);
  }
}