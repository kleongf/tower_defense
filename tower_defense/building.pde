// building class
class Building {
  float x, y;
  float fireRate;
  float size;
  float projectileSize; 
  float range; 
  boolean isDraggable = true;
  float damage;
  boolean upgradedDamage = false;
  boolean upgradedRange = false;
  boolean upgradedFireRate = false;
  boolean showingRange = false;
  PImage img;
  color c;
 
  // constructor
  Building(int x, int y, float size, float fireRate, float projectileSize, float range, float damage, PImage img, color c) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.fireRate = fireRate; 
    this.projectileSize = projectileSize; 
    this.range = range; 
    this.damage = damage; 
    this.img = img;
    this.c = c;
  }
  // draws the building (which is an image)
  void drawBuilding() {
    image(img, x, y, size, size);
    // if it should show the range, draw a circle indicating the range
    if (showingRange) {
      fill(128,128,128,63);
      ellipse(x+size/2, y+size/2, range, range);
    }
  }
  // upgrades
  void upgradeDamage() {
    this.damage *= 2;
  }
  void upgradeRange() {
    this.range *= 2;
  }
  // dividing the fire rate actually makes it faster
  void upgradeFireRate() {
    this.fireRate /= 2;
  }
}
