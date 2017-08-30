class Mars extends Planet {
  final static float mass = 6.5;    // Mass, tied to size
  
  Mars() {    
    super(mass, new PVector(width/2,height/4));
  }
  
    // Method to display
  void display() {
    fill (255,0,0); //red
    super.display();    
  }
  
  boolean isCrashed(Rocket rocket) {
     return this.getLocation().dist(rocket.getLocation()) < this.diameter/2 ? true: false;
  }
}