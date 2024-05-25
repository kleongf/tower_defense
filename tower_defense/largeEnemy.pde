// large enemy class: spawns two medium enemies on death
class LargeEnemy extends Enemy {
  ArrayList<Enemy> enemyList;
  LargeEnemy(ArrayList<Enemy> enemyList) {
    super(1000, 80, 2);
    this.enemyList = enemyList;
  }
  void onDeath() {
    println("large enemy died");
    enemyList.add(new MediumEnemy(enemyList, super.x, super.y));
    enemyList.add(new MediumEnemy(enemyList, super.x, super.y));
  }
}
