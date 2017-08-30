class Earth extends Planet {
  final static float mass = 150;    // Mass, tied to size
  
  Earth() {
    super(mass, new PVector(width/6,height/2));
  }
  
    // Method to display
  void display() {
    fill (0,120,255); //blue
    super.display();
  } 
  
}