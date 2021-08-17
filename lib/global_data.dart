import 'dart:math';

class GlobalData {
  int fairyLocation = 1;
  int fairyPower = 51;
  List<int> enemyPower = List<int>.filled(3, 0);

  GlobalData();

  void resetFairy() {
    this.fairyLocation = 1;
    this.fairyPower = 51;
  }

  void setEnemyPower() {
    var rand = Random();
    
    // fairyPower桁数
    final int digits = fairyPower.toString().length;

    // まずは小さい方を生成
    if (digits <= 2) {
      enemyPower[0] = rand.nextInt(fairyPower - 1) + 1;
    } else {
      enemyPower[0] =
          rand.nextInt(fairyPower - pow(10, digits - 2) as int) + pow(10, digits - 2) as int;
    }

    // 次に大きい方を生成
    enemyPower[1] =
        rand.nextInt(pow(10, digits + 1) - fairyPower - 1 as int) + fairyPower + 1;
    enemyPower[2] =
        rand.nextInt(pow(10, digits + 1) - fairyPower - 1 as int) + fairyPower + 1;

    // シャッフル
    enemyPower.shuffle();
  }
}
