/**
 * Code für das komplizierte System mit Schwerkraft in Abschnitt 2.3
 */

import 'package:complexity_perspective/vector.dart';
import 'package:complexity_perspective/circle2.dart';

simulation() {
  var u = new Circle2(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle2(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle2(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

  // Setze alle Planeten
  u.objects = v.objects = w.objects = [u, v, w];

  // Simulation
  num t = 0;
  while (t < 10) {
    print("t=$t: $u, $v, $w");    // gibt u, v und w aus
    u.step(); v.step(); w.step();
    t += 1;
  }
}

main(List<String> args) {
  print('--- Simulation aus dem Buch in Abschnitt 2.3 ---');
  simulation();
  print('--- Ende  --------------------------------------');
}
