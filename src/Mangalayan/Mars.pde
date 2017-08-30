class Mars extends Planet {
  final static float mass = 6.5;    // Mass, tied to size
  
  Mars() {    
    super(mass, new PVector(width/2,height/4));
    G = 1;
    dragOffset = new PVector(0.0,0.0);
  }
  
    // Method to display
  void display() {
    fill (255,0,0); //red
    super.display();    
  }
}