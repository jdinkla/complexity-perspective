/**
 * Code for the complex system with gravity in Section 2.3
 */

import 'package:complexity_perspective/core/vector.dart';
import 'package:complexity_perspective/models/circle2.dart';

simulation() {
  var u = new Circle2(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle2(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle2(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

  // Set all planets
  u.objects = v.objects = w.objects = [u, v, w];

  // Simulation
  num t = 0;
  while (t < 10) {
    print("t=$t: $u, $v, $w");    // outputs u, v and w
    u.step(); v.step(); w.step();
    t += 1;
  }
}

main(List<String> args) {
  print('--- Simulation from the book in Section 2.3 ---');
  simulation();
  print('--- Ende  --------------------------------------');
}
