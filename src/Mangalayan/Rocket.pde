// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Rocket {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;

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

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(0,100);
    ellipse(location.x, location.y, mass*5, mass*5);
  }
}