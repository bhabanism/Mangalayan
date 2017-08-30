class Rocket {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  int r,g,b;

  Rocket(float m, PVector location, PVector initialThurst) {
    mass = m;
    this.location = location;
    velocity = new PVector(0, 0);
    acceleration = initialThurst;
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
  }
}