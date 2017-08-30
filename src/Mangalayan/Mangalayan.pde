int initialpopulation = 150;
Rocket[] rockets = new Rocket[initialpopulation];

Mars mars;
Earth earth;
final static int maxSpeed = 5; 

void setup() {  
  size(800, 750);
  mars = new Mars();
  earth = new Earth();
  for (int i = 0; i < rockets.length; i++) {
    PVector earthLocation = earth.getLocation();
    PVector rocketLocation = earthLocation.add(new PVector(random(-2,2),random(-2,2)));
    PVector initialThrust = new PVector(random(-1*maxSpeed,1*maxSpeed),random(-1*maxSpeed,1*maxSpeed));
    rockets[i] = new Rocket(random(0.1, 1),rocketLocation, initialThrust);
    rockets[i].setColor((int)random(255),(int)random(255),(int)random(255));
  }
}

void draw() {
  background(255);

  mars.display();
  earth.display();

  for (int i = 0; i < rockets.length; i++) {
    PVector marsForce = mars.attract(rockets[i]);
    PVector earthForce = earth.attract(rockets[i]);
    PVector totalForce = marsForce.add(earthForce);
    rockets[i].applyForce(totalForce);

    rockets[i].update();    
    rockets[i].display();
  }
}