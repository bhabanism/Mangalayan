class Mars extends Planet {
  final static float mass = 230;    // Mass, tied to size
  
  Mars() {    
    super(mass, new PVector(width - width/5,height/2));
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