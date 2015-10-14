/*
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * Code from the book
 *
 * "Titel"
 * "Title"
 *
 */

import 'dart:math';

/*
 * Two dimensional Vector
 */
class Vector {

  final num x, y;

  const Vector(this.x, this.y);

  Vector operator +(Vector v) => new Vector(x + v.x, y + v.y);

  static const origin = const Vector(0, 0);

  String toString() => "($x, $y)";

}

num distance(Vector a, Vector b) {
  var dx = a.x - b.x;
  var dy = a.y - b.y;
  return sqrt(dx * dx + dy * dy);
}

/*
 *
 */
class Kreis {

  String farbe;
  int masse;
  Vector position;
  Vector richtung;

  Kreis({farbe: "", masse: 0, position: Vector.origin, richtung: Vector.origin}) {
    this.farbe = farbe;
    this.masse = masse;
    this.position = position;
    this.richtung = richtung;
  }

  step() {
    position = position + richtung;
  }

  String toString() => "farbe: $farbe, masse: $masse, position: $position, richtung: $richtung";

}


setup1() {
  var u = new Kreis(farbe: "blau", masse: 3, position: new Vector(2, 1));
  var v = new Kreis(farbe: "grau", masse: 4, position: new Vector(5, 3));
  var w = new Kreis(farbe: "rot", masse: 2, position: new Vector(9, 4));

  print([u, v, w]);
}

setup2() {
  var u = new Kreis(farbe: "blau", masse: 3, position: new Vector(2, 1), richtung: new Vector(0, 2));
  var v = new Kreis(farbe: "grau", masse: 4, position: new Vector(5, 3), richtung: new Vector(0, 0));
  var w = new Kreis(farbe: "rot", masse: 2, position: new Vector(9, 4), richtung: new Vector(-1, -1));

  print(u);
  u.step();
  print(u);
  u.step();
  print(u);
}

// runs maxT time steps all the elements in ks
run(int maxT, List<Kreis> ks) {
  for (var t = 0; t < maxT; t++) {
    print("t=$t: $ks");
    ks.forEach((Kreis k) => k.step());
  }
}

run5Steps() {
  var u = new Kreis(farbe: "blau", masse: 3, position: new Vector(2, 1), richtung: new Vector(0, 2));
  var v = new Kreis(farbe: "grau", masse: 4, position: new Vector(5, 3), richtung: new Vector(0, 0));
  var w = new Kreis(farbe: "rot", masse: 2, position: new Vector(9, 4), richtung: new Vector(-1, -1));

  // run 5 steps for u,v and w
  for (var t = 0; t < 5; t++) {
    print("t=$t: $u, $v, $w");
    u.step(); v.step(); w.step();
  }
// simpler using run:  run(5, [u, v, w]);
}


main(List<String> args) {
  print('Beispiel 1 ----------------------');
  setup1();
  print('Beispiel 2 ----------------------');
  setup2();
  print('Beispiel 3 ----------------------');
  run5Steps();
  print('Ende       ----------------------');
}
