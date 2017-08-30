import java.util.ArrayList;

int initialpopulation = 150;
//Rocket[] rockets = new Rocket[initialpopulation];
ArrayList<Rocket> rockets = new ArrayList<Rocket>();

Mars mars;
Earth earth;
final static int maxSpeed = 5; 

void setup() {  
  size(800, 750);
  mars = new Mars();
  earth = new Earth();
  for (int i = 0; i < initialpopulation; i++) {
    PVector earthLocation = earth.getLocation();
    PVector rocketLocation = earthLocation.add(new PVector(random(-2,2),random(-2,2)));
    PVector initialThrust = new PVector(random(-1*maxSpeed,1*maxSpeed),random(-1*maxSpeed,1*maxSpeed));
    Rocket rocket = new Rocket(random(0.1, 1),rocketLocation, initialThrust);
    rocket.setColor((int)random(255),(int)random(255),(int)random(255));
    rockets.add(rocket);
  }
}

void draw() {
  background(255);
  mars.display();
  earth.display();  
  for(Rocket rocket : rockets) {
    if(rocket.isAlive()) {
      PVector marsForce = mars.attract(rocket);
      PVector earthForce = earth.attract(rocket);
      PVector totalForce = marsForce.add(earthForce);
      rocket.applyForce(totalForce);
      rocket.update();    
      rocket.display();   
    }
  }
}

Rocket createRocket() {
  PVector earthLocation = earth.getLocation();
  PVector rocketLocation = earthLocation.add(new PVector(random(-2,2),random(-2,2)));
  PVector initialThrust = new PVector(random(-1*maxSpeed,1*maxSpeed),random(-1*maxSpeed,1*maxSpeed));
  Rocket rocket = new Rocket(random(0.1, 1),rocketLocation, initialThrust);
  rocket.setColor((int)random(255),(int)random(255),(int)random(255));
  return rocket;
}