/**
 * Code for the simple system in Section 2.3
 */

import 'package:complexity_perspective/vector.dart';
import 'package:complexity_perspective/circle.dart';

init() {
  var u, v, w;
  u = new Circle(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  v = new Circle(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  w = new Circle(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

  print(u);
  u.step();
  print(u);
  u.step();
  print(u);
}

simulation() {
  var u = new Circle(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

  num t = 0;
  while (t < 10) {
    print("t=$t: $u, $v, $w");    // outputs u, v and w
    u.step(); v.step(); w.step();
    t += 1;
  }
}

main(List<String> args) {
  print('--- Example from the book in Section 2.3 -----');
  init();
  print('--- Simulation from the book in Section 2.3 ---');
  simulation();
  print('--- Ende  --------------------------------------');
}
