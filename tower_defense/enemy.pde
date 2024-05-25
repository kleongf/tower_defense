// enemy class
class Enemy {
  float x, y;
  int hp;
  float speed;
  float size;
  float dy, dx;
  float currentHp;
  
  // enemy constructor 1: used for the normal enemy
  Enemy(int hp, int size, float speed) {
     this.x = 0;
     this.y = 50;
     this.size = size;
     this.dx = speed;
     this.dy = 0;
     this.hp = hp;
     this.currentHp = hp;
     this.speed = speed;
  }
  // enemy constructor 2: used when a larger enemy creates another, since we want the x and y coordinate to be the same as the one that died
  Enemy(float x, float y, int hp, int size, float speed) {
     this.x = x;
     this.y = y;
     this.size = size;
     this.dx = speed;
     this.dy = 0;
     this.hp = hp;
     this.currentHp = hp;
     this.speed = speed;
  }
  // drawing the enemy
  void drawEnemy() {
    
    // creating an hp bar for the enemy
    float health = currentHp / hp;
    fill(255, 0, 0);
    stroke(255);
    rect(x-size/2, y-size/2-10, size*health, 10);
    fill(240, 20, 240);
    stroke(255);
    ellipse(x, y, size, size);
    
    // making the enemy follow the path
    if ((y >= 50 && y <= 60) && (x >= 500 && x <= 510)) {
      dy = speed;
      dx = 0;
    } else if ((y >= 200 && y <= 210) && (x >= 500 && x <= 510)) {
      dy = 0;
      dx = -speed;
    } else if ((y >= 200 && y <= 210) && (x >= 50 && x <= 60)) {
      dy = speed;
      dx = 0;
    } else if ((y >= 350 && y <= 360) && (x >= 50 && x <= 60)) {
      dy = 0;
      dx = speed;
    } else if ((y >= 350 && y <= 360) && (x >= 500 && x <= 510)) {
      dy = speed;
      dx = 0;
    } else if ((y >= 500 && y <= 510) && (x >= 500 && x <= 510)) {
      dy = 0;
      dx = -speed;
    }
    // adding the speed
    x += dx;
    y += dy;
  }
  void onDeath() {
    println("I died :(");
  }
}
