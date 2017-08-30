// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A class for a draggable attractive body in our world

class Planet {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector location;   // Location
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on

  Planet(float mass, PVector location) {
    this.location = location;
    this.mass = mass;
    G = 1;
    dragOffset = new PVector(0.0,0.0);
  }

  PVector attract(Rocket m) {
    PVector force = PVector.sub(location,m.location);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d,5.0,25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force.mult(strength);                                  // Get force vector --> magnitude * direction
    return force;
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    strokeWeight(4);
    stroke(0);
    /*if (dragging) fill (50);
    else if (rollover) fill(100);
    else fill(175,200);*/
    ellipse(location.x,location.y,mass*5,mass*5);
  }

  // The methods below are for mouse interaction
  /*void clicked(int mx, int my) {
    float d = dist(mx,my,location.x,location.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = location.x-mx;
      dragOffset.y = location.y-my;
    }
  }

  void hover(int mx, int my) {
    float d = dist(mx,my,location.x,location.y);
    if (d < mass) {
      rollover = true;
    } 
    else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }



  void drag() {
    if (dragging) {
      location.x = mouseX + dragOffset.x;
      location.y = mouseY + dragOffset.y;
    }
  }*/
  
  PVector getLocation() {
    return new PVector(location.x, location.y);
  }   
    

}