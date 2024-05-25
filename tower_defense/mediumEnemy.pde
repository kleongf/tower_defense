// large enemy class: spawns two normal enemies on death
class MediumEnemy extends Enemy {
  ArrayList<Enemy> enemyList;
  float x, y;
  MediumEnemy(ArrayList<Enemy> enemyList, float x, float y) {
    super(x, y, 500, 80, 1.5);
    this.enemyList = enemyList;
  }
  void onDeath() {
    println("medium enemy died");
    enemyList.add(new Enemy(super.x, super.y, 200, 50, 2));
    enemyList.add(new Enemy(super.x, super.y, 200, 50, 2));
  }
}
