import java.util.LinkedList;
import java.util.ListIterator;

int initialpopulation = 50;
//Rocket[] rockets = new Rocket[initialpopulation];
ArrayList<Rocket> rockets = new ArrayList<Rocket>();
 
Rocket bestRocket;
float bestScore = 0;
float avgScore = 0;
int generation = 0;
int maxPopulation = 100;
float mutationRate = 0.01;

Mars mars;
Earth earth;
final static int maxSpeed = 6; 

void setup() {  
  size(1200, 750);
  mars = new Mars();
  earth = new Earth();
  for (int i = 0; i < initialpopulation; i++) {
    PVector earthLocation = earth.getLocation();
    PVector rocketLocation = earthLocation.add(new PVector(random(-2,2),random(-2,2)));
    PVector initialThrust = new PVector(random(-1*maxSpeed,1*maxSpeed),random(-1*maxSpeed,1*maxSpeed));
    Rocket rocket = new Rocket(random(3, 6),rocketLocation, initialThrust);    
    rockets.add(rocket);
  }
}

void draw() {
  
  generation++;
  if(rockets.size()> maxPopulation) {
    massExtinction();
  }
          
  background(255);
  mars.display();
  earth.display();  
  
  ListIterator<Rocket> iter = rockets.listIterator();

  while (iter.hasNext()) {
      Rocket rocket = (Rocket)iter.next();  
      if(rocket.isAlive()) {
        PVector marsForce = mars.attract(rocket);
        PVector earthForce = earth.attract(rocket);
        PVector totalForce = marsForce.add(earthForce);
        rocket.applyForce(totalForce);
        rocket.update(); 
        rocket.display();
        if(mars.isCrashed(rocket)) {
          iter.remove(); //TODO: crashed rocket animation
          rocket.destroy();
        }        
        rocket.calculateFitness(mars);
        if(rocket.isFitToClone(avgScore) && rockets.size() < maxPopulation+50) {
          iter.add(new Rocket(rocket, mutationRate));
        }
    } else {
      iter.remove(); //TODO: lost rocket animation
      rocket.destroy();
    }    
  }
  avgScore = updateScore();
}


void massExtinction() {
  for(Rocket rocket : rockets) {
    if(rocket.lowFuel()) {
      //rocket.destroy();
    }
  }
}

float updateScore() {
  PFont f = createFont("Courier", 10, true);
  textFont(f);
  fill(0);
  float sum = 0;
 
  for(Rocket rocket : rockets) {
    if(rocket.fitness > bestScore) {
      bestScore = rocket.fitness;
      bestRocket = rocket;
    }
    sum += rocket.fitness;
  }
  avgScore = rockets.size() >0 ? sum/rockets.size() : 0;
  String noticeboard = "Best Score: " + bestScore;
  noticeboard += "\n Average Score : " + avgScore;
  noticeboard += "\n Generation: " + generation;
  noticeboard += "\n fuel left with best rocket : " + bestRocket.fuel;
  noticeboard += "\n Population : " + rockets.size();
  noticeboard += "\n debug noise : " + noise(random(10));
  text(noticeboard, width*2/3,height*5/6);
  PVector loc = bestRocket.getLocation();
  rect(loc.x, loc.y, 5, 5);
  return avgScore;
}