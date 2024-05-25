// projectile class
class Projectile {
  float x, y;
  float size;
  float dy, dx;
  float damage;
  color c;
  
  // each projectile has a parent building that has its damage, starting x-coordinate, starting y-coordinate, color, and size
  // this constructor was used for testing
  Projectile(Building building) {
     this.x = building.x;
     this.y = building.y;
     this.size = building.projectileSize;
     this.dx = 5;
     this.dy = 0;
     this.c = building.c;
  }
  // this constructor is used when creating a new projectile
  Projectile(Building building, float dy, float dx) { 
     this.x = building.x+building.size/2;
     this.y = building.y+building.size/2;
     this.size = building.projectileSize;
     this.dx = dx;
     this.dy = dy;
     this.damage = building.damage;
     this.c = building.c;
  }
  // drawing the projectile
  void drawProjectile() {
    fill(c);
    ellipse(x, y, size, size);
    x += dx;
    y += dy;
  }
}
