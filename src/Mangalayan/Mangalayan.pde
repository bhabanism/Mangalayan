import java.util.LinkedList;
import java.util.ListIterator;

int initialpopulation = 25;
//Rocket[] rockets = new Rocket[initialpopulation];
ArrayList<Rocket> rockets = new ArrayList<Rocket>();

public static HashMap<String,Integer> stats = new HashMap<String,Integer>();
 
Rocket bestRocket;
float bestScore = 0;
float avgScore = 0;
int generation = 0;
int maxPopulation = 300;
float mutationRate = 0.1;
float survivalRate = 0.3;
int yug = 2000;

Mars mars;
Earth earth;
final static int maxSpeed = 5; 

void setup() {  
  stats.put("Born above avg : ", 0);
  stats.put("Born below avg : ", 0);
  stats.put("Died above avg : ", 0);
  stats.put("Died below avg : ", 0);
  
  size(1200, 750);
  mars = new Mars();
  earth = new Earth();
  for (int i = 0; i < initialpopulation; i++) {
    PVector earthLocation = earth.getLocation();
    PVector rocketLocation = earthLocation.add(new PVector(random(-2,2),random(-2,2)));
    PVector initialThrust = new PVector(random(-1*maxSpeed,1*maxSpeed),random(-1*maxSpeed,1*maxSpeed));
    Rocket rocket = new Rocket(random(3, 5),rocketLocation, initialThrust);    
    rockets.add(rocket);
  }
}

void draw() {
  
  generation++;
  if(rockets.size()>= maxPopulation*survivalRate && generation%yug == 0) {
  //if(rockets.size()>= maxPopulation) {
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
  ArrayList<Rocket> survivors = new ArrayList<Rocket>();
  survivors.add(bestRocket);
  for(Rocket rocket : rockets) {
    if((!rocket.lowFuel() || rocket.isScoreAboveAvg()) && survivors.size() < maxPopulation*survivalRate) {
      survivors.add(rocket);
    }
  }
  rockets.clear();
   for(Rocket rocket : survivors) {
      rockets.add(new Rocket(rocket, mutationRate));
      rockets.add(rocket);
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
  noticeboard += "\n Population : " + rockets.size();
  noticeboard += "\nBorn above avg : " + stats.get("Born above avg : ");
  noticeboard += "\nBorn below avg : " + stats.get("Born below avg : ");
  noticeboard += "\nDied above avg : " + stats.get("Died above avg : ");
  noticeboard += "\nDied below avg : " + stats.get("Died below avg : ");
  text(noticeboard, width*2/3,height*2/3);
  PVector loc = bestRocket.getLocation();
  rect(loc.x, loc.y, 5, 5);
  return avgScore;
}