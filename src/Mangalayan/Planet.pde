class Planet {
  final float mass;    // Mass, tied to size
  final float G = 50;       // Gravitational Constant
  final PVector location;   // Location
  final float diameter;
  
  final int gravitationalSphere = 10; // 5 time the size of planet
  
  //boolean dragging = false; // Is the object being dragged?
  //boolean rollover = false; // Is the mouse over the ellipse?
  //PVector dragOffset;  // holds the offset for when object is clicked on
  float diameterScale = 0.1;
  int distanceScale = 25;

  Planet(float mass, PVector location) {
    this.location = location;
    this.mass = mass;
    this.diameter = mass*diameterScale;
  }

  PVector attract(Rocket m) {
    if(this.getLocation().dist(m.getLocation()) < gravitationalSphere * diameter /2) {
      PVector force = PVector.sub(location,m.location);   // Calculate direction of force
      float d = force.mag();                              // Distance between objects
      d = constrain(d,5.0,25.0)*distanceScale;                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
      force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
      float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
      force.mult(strength);                                  // Get force vector --> magnitude * direction
      return force;
    } else {
      return new PVector(0,0);
    }
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    strokeWeight(2);
    stroke(0);    
    ellipse(location.x, location.y, diameter, diameter);
    //ellipse(location.x, location.y, gravitationalSphere * diameter, gravitationalSphere * diameter);
  }
  
  PVector getLocation() {
    return new PVector(location.x, location.y);
  }   
    

}