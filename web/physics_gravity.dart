/**
 *
 * Standalone version for the books "" and "".
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'dart:math';

num softeningSquared = 0.0;
List<Circle> objects = [];

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

// Adapted from [Wil13, Listing 14.1]
// Die Variablennamen sind so aus Wil13 übernommen.
Vector bodyBodyInteraction(Vector v, Vector w, num mass1) {
  num dx = w.x - v.x;
  num dy = w.y - v.y;
  num distSqr = dx * dx + dy * dy + softeningSquared;
  num invDist = 1.0 / sqrt(distSqr);
  num invDistCube = invDist * invDist * invDist;
  num s = mass1 * invDistCube;
  return new Vector(dx * s, dy * s);
}

/*
 *
 */
class Circle {

  String color;
  num mass;
  Vector position;
  Vector velocity;

  Circle({farbe: "", masse: 0, position: Vector.origin, richtung: Vector.origin}) {
    this.color = farbe;
    this.mass = masse;
    this.position = position;
    this.velocity = richtung;
  }

  dev_step() {
    Vector force = new Vector(0, 0);
    objects
    .where( (Circle c) => c != this)
    .forEach( (Circle c) => force += bodyBodyInteraction(position, c.position, c.mass) );

    // force is the sum for all ks
    num invMass = 1.0 / mass;
    //num dt = 1.0;         // keep it simple, stupid
    //num damping = 1.0;    // keep it simple, stupid
    //var newVel = new Vector(force.x * invMass * dt, force.y * invMass * dt);
    var newVel = velocity + new Vector(force.x * invMass, force.y * invMass);
    // newVel *= damping
//    var newPos = position + newVel * dt;
    var newPos = position + newVel;
    position = newPos;
    velocity = newVel;
  }

  step() {
    Vector force = new Vector(0, 0);
    objects
    .where( (Circle c) => c != this)
    .forEach( (Circle c) => force += bodyBodyInteraction(position, c.position, c.mass) );
    velocity = velocity + new Vector(force.x / mass, force.y / mass);
    position = position + velocity;
  }

  String toString() => "f: $color, m: $mass, pos: $position, richtung: $velocity";

}

// runs maxT time steps all the elements in ks
run(int maxT) {
  for (var t = 0; t < maxT; t++) {
    print("t=$t: $objects");
    objects.forEach((Circle k) => k.step());
  }
}

runGravity() {
  var u = new Circle(farbe: "blau", masse: 3, position: new Vector(2, 1), richtung: new Vector(2, 0));
  var v = new Circle(farbe: "grau", masse: 4, position: new Vector(5, 3), richtung: new Vector(0, 0));
  var w = new Circle(farbe: "rot", masse: 2, position: new Vector(9, 4), richtung: new Vector(-1, -1));

  objects = [u, v, w];
  print("Kreise: $objects");
  run(15);
}


main(List<String> args) {
  print('Beispiel mit Schwerkraft --------');
  runGravity();
  print('Ende       ----------------------');
}
