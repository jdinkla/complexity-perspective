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

num softeningSquared = 0.0;
List<Kreis> kreise = [];

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

  dev_step() {
    Vector force = new Vector(0, 0);
    kreise.forEach( (Kreis k) {
      if (k != this) {
        force += bodyBodyInteraction(position, k.position, k.masse);
      }
    }
    );
    // force is the sum for all ks
    num invMass = 1.0 / masse;
    //num dt = 1.0;         // keep it simple, stupid
    //num damping = 1.0;    // keep it simple, stupid
    //var newVel = new Vector(force.x * invMass * dt, force.y * invMass * dt);
    var newVel = richtung + new Vector(force.x * invMass, force.y * invMass);
    // newVel *= damping
//    var newPos = position + newVel * dt;
    var newPos = position + newVel;
    position = newPos;
    richtung = newVel;
  }

  step() {
    Vector force = new Vector(0, 0);
    kreise.forEach( (Kreis k) {
      if (k != this) {
        force += bodyBodyInteraction(position, k.position, k.masse);
      }
    });
    // force ist die Summe der Kräfte, berechne neue Richtung und Position
    richtung = richtung + new Vector(force.x / masse, force.y / masse);
    position = position + richtung;
  }

  String toString() => "f: $farbe, m: $masse, pos: $position, richtung: $richtung";

}

// runs maxT time steps all the elements in ks
run(int maxT) {
  for (var t = 0; t < maxT; t++) {
    print("t=$t: $kreise");
    kreise.forEach((Kreis k) => k.step());
  }
}

runGravity() {
  var u = new Kreis(farbe: "blau", masse: 3, position: new Vector(2, 1), richtung: new Vector(0, 2));
  var v = new Kreis(farbe: "grau", masse: 4, position: new Vector(5, 3), richtung: new Vector(0, 0));
  var w = new Kreis(farbe: "rot", masse: 2, position: new Vector(9, 4), richtung: new Vector(-1, -1));

  kreise = [u, v, w];
  print("Kreise: $kreise");
  run(15);
}


main(List<String> args) {
  print('Beispiel mit Schwerkraft --------');
  runGravity();
  print('Ende       ----------------------');
}
