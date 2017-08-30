class Earth extends Planet {
  final static float mass = 5.9;    // Mass, tied to size
  
  Earth() {
    super(mass, new PVector(width/2,height - height/4));
  }
  
    // Method to display
  void display() {
    fill (0,120,255); //blue
    super.display();
  } 
  
}