// making lists for projectiles, enemies and buildings
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<Building> buildings = new ArrayList<Building>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Building selectedBuilding;
int money = 600;

// creating colors red, yellow, and blue
color yellow = color(255, 255, 0);
color red = color(255, 0, 0);
color blue = color(0, 0, 255);

void setup() {
  size(800, 600);
}

// calling functions to start the level, draw the path, projectiles, enemies, and buildings
void draw() {
  background(0);
  fill(255, 255, 0);
  stroke(255);
  startLevel();
  drawPath();
  drawBuildings();
  fill(0, 0, 255);
  stroke(255);
  drawProjectiles();
  fill(255, 0, 0);
  stroke(255);
  drawEnemies();
  textSize(15);
  drawUpgrades();
  fill(255);
  textSize(30);
  text("Money: " + money, 610, 100, 200, 60); 
  gameOver();
  
}

// drawing projectiles
void drawProjectiles() {
  if (enemies.size() == 0) return;
  // determining the closest projectile to every building
  for (int i = 0; i < buildings.size(); i++) {
    int closestIdx = 0;
    float smallestDist = 1000;
    Building b = buildings.get(i);
    for (int j = 0; j < enemies.size(); j++) {
      float dist = dist(b.x, b.y, enemies.get(j).x, enemies.get(j).y);
      if (dist < smallestDist) {
        closestIdx = j;
        smallestDist = dist;
      }
    }
    // checking for range: if the range of the building is not large enough then it won't shoot
    if (smallestDist < b.range) { 
      float dx = ((enemies.get(closestIdx).x-b.x) + enemies.get(closestIdx).dx-enemies.get(closestIdx).size/2)/10; // determining x speed so that the projectile will hit the enemy
      float dy = ((enemies.get(closestIdx).y-b.y) + enemies.get(closestIdx).dy-enemies.get(closestIdx).size/2)/10; // determining y speed so that the projectile will hit the enemy
      // checking for fire rate: if the building has fired too recently then it won't shoot
      if (frameCount % buildings.get(i).fireRate == 0) {
        projectiles.add(new Projectile(buildings.get(i), dy, dx));
        enemies.get(closestIdx).currentHp -= buildings.get(i).damage;
      }
    }
  }
  
  // Actually drawing the projectiles
  for (int i = 0; i < projectiles.size(); i++) {
    Projectile p = projectiles.get(i);
    p.drawProjectile();
    // projectile is removed when it goes off the screen to avoid lag
    if ((p.x < 0 || p.x > 600) || (p.y < 0 || p.y > 600)) {
      projectiles.remove(p);
    }
  }
}

// drawing all of the buildings
void drawBuildings() {
  for (int i = 0; i < buildings.size(); i++) {
    buildings.get(i).drawBuilding();
  }
}

// drawing all of the enemies
void drawEnemies() {
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).drawEnemy();
    // checking if the enemy has no health left
    if (enemies.get(i).currentHp <= 0) {
      // Some enemies spawn more enemies on death, so onDeath is called
      enemies.get(i).onDeath();
      enemies.remove(i);
    }
  }
}

// creating buttons for upgrades
void drawUpgrades() {
  if (selectedBuilding == null) return;
  // all the upgrades are based on the selected building: buttons are green if the upgrade is allowed and red otherwise
  if (selectedBuilding.upgradedDamage) {
    fill(240, 20, 20);
    stroke(255);
    rect(600, 300, 120, 80);
  } else {
    fill(20, 240, 20);
    stroke(255);
    rect(600, 300, 120, 80);
  }
  if (selectedBuilding.upgradedRange) {
    fill(240, 20, 20);
    stroke(255);
    rect(600, 400, 120, 80);
  } else {
    fill(20, 240, 20);
    stroke(255);
    rect(600, 400, 120, 80);
  }
  if (selectedBuilding.upgradedFireRate) {
    fill(240, 20, 20);
    stroke(255);
    rect(600, 500, 120, 80);
  } else {
    fill(20, 240, 20);
    stroke(255);
    rect(600, 500, 120, 80);
  }
  // creating text for the buttons
  fill(0);
  text("Upgrade Damage: $100 (Press 1)", 610, 320, 100, 60); 
  text("Upgrade Range: $100 (Press 2)", 610, 420, 100, 60);
  text("Upgrade Fire Rate: $100 (Press 3)", 610, 520, 100, 60);
}

// drawing a yellow path that the enemies will take
void drawPath() {
  rect(0, 50, 500, 50);
  rect(500, 50, 50, 200);
  rect(0, 200, 500, 50);
  rect(0, 200, 50, 200);
  rect(0, 350, 500, 50);
  rect(500, 350, 50, 200);
  rect(0, 500, 500, 50);
}

// a helper function to check if the player has lost
boolean checkLoss() {
  // checking to see if an enemy has completed the path
  for (int i = 0; i < enemies.size(); i++) {
    if (enemies.get(i).x < 0) {
      println("YOU LOST");
      return true;
    }
  }
  println("still alive");
  return false;  
}

// checking if the mouse was pressed
void mousePressed() {
  PImage cannon = loadImage("Cannon.png");
  PImage xbow = loadImage("Xbow.png");
  PImage tesla = loadImage("Tesla.png");
  
  // if the mouse was on a building, we want to make it the selected building and show its range
  for (int i = 0; i < buildings.size(); i++) {
    Building c = buildings.get(i);
    if ((mouseX <= c.x + c.size) && (mouseY <= c.y + c.size)) {
      selectedBuilding = c;
      selectedBuilding.showingRange = true;
    } else {
      buildings.get(i).showingRange = false;
    }
  }
  // if the mouse was not on a building and a key was pressed, create a new building 
  if (keyPressed) {
    if (key == 'q') {
      if (money >= 100) { // checking to see if the used has money first
        Building b = new Building(mouseX, mouseY, 60, 30, 20, 200, 20, cannon, yellow); // cannon
        buildings.add(b);
        money -= 100; // take away their money mwahaha
      }
    } else if (key == 'w') {
      if (money >= 150) {
        Building b = new Building(mouseX, mouseY, 60, 30, 30, 300, 15, tesla, blue); //tesla
        buildings.add(b);
        money -= 100;
      } 
    } else if (key == 'e') {
      if (money >= 150) {
        Building b = new Building(mouseX, mouseY, 60, 10, 10, 600, 5, xbow, red); //xbow
        buildings.add(b);
        money -= 100;
      }
    }
  }
}
// if the mouse was released, make the building immovable
void mouseReleased() {
 if (buildings.size() == 0) return;
 buildings.get(buildings.size()-1).isDraggable = false;
}

void keyPressed() {
  if (key == '1') { // 1 is pressed: upgrade damage
    if (!(selectedBuilding.upgradedDamage)) {
      if (money >= 100) {
      // check if they have money 
        selectedBuilding.upgradeDamage();
        selectedBuilding.upgradedDamage = true;
        money -= 100;
      }
    }
  }
  if (key == '2') { // 2 is pressed: upgrade range
    if (!(selectedBuilding.upgradedRange)) {
      if (money >= 100) {
        selectedBuilding.upgradeRange();
        selectedBuilding.upgradedRange = true;
        money -= 100;
      }
    }
  }
  if (key == '3') { // 3 is pressed: upgrade fire rate
    if (!(selectedBuilding.upgradedFireRate)) {
      if (money >= 100) {
        selectedBuilding.upgradeFireRate();
        selectedBuilding.upgradedFireRate = true;
        money -= 100;
      }
    }
  }
}
    


void startLevel() {
  // creating enemy list for the first minute (3600 frames = 60 seconds)
  if (frameCount <= 3600) { 
    if (frameCount % 300 == 0) {
      enemies.add(new Enemy(200, 50, 2)); 
    }
    if (frameCount % 600 == 0) {
      enemies.add(new MediumEnemy(enemies, 0, 50));
    }
    if (frameCount % 1800 == 0) {
      money += 500;
    }
  // creating enemy list for minute 2
  } else if (frameCount <= 7200) {
    if (frameCount % 200 == 0) {
      enemies.add(new Enemy(200, 50, 2));
    }
    if (frameCount % 400 == 0) {
      enemies.add(new MediumEnemy(enemies, 0, 50));
    }
    if (frameCount % 800 == 0) {
      enemies.add(new LargeEnemy(enemies));
    }
    if (frameCount % 1800 == 0) {
      money += 600;
    }
  // creating enemy list for minute 3
  } else if (frameCount <= 10800) {
    if (frameCount % 100 == 0) {
      enemies.add(new Enemy(200, 50, 2));
    }
    if (frameCount % 200 == 0) {
      enemies.add(new MediumEnemy(enemies, 0, 50));
    }
    if (frameCount % 300 == 0) {
      enemies.add(new LargeEnemy(enemies));
    }
    if (frameCount % 1800 == 0) {
      money += 700;
    }
  }
}

// check if game is over and show a blank screen
void gameOver() {
  if (checkLoss()) {
    background(255);
    fill(0, 0, 0);
    textSize(100); 
    text("iltg", 300, 300, 200, 100);
    println("you lost haha");
  }
}
