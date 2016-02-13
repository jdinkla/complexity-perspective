/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Ein Kreis bzw. ein "Planet" mit Schwerkraft. Siehe Abschnitt 2.3 im Buch.
 */

import 'vector.dart';
import 'circle.dart';
import 'dart:math';

num softeningSquared = 0.0;

// Adapted from [Wil13, Listing 14.1]
// Die Variablennamen sind so aus Wil13 übernommen.
// Der Code hat es nicht in das Buch geschafft, weil er viele Leser verwirren könnte.
Vector bodyBodyInteraction(Vector v, Vector w, num mass1) {
  num dx = w.x - v.x;
  num dy = w.y - v.y;
  num distSqr = dx * dx + dy * dy + softeningSquared;
  num invDist = 1.0 / sqrt(distSqr);
  num invDistCube = invDist * invDist * invDist;
  num s = mass1 * invDistCube;
  return new Vector(dx * s, dy * s);
}

class Circle2 extends Circle {

  // Enthält die anderen Planeten
  List<Circle2> objects = null;

  Circle2({color: "", mass: 0.0, position: Vector.origin, velocity: Vector.origin})
      : super(color: color, mass: mass, position: position, velocity: velocity)
  {
  }

  step() {
    assert(objects != null);
    Vector force = new Vector(0, 0);
    objects
        .where( (Circle c) => c != this)
        .forEach( (Circle c) => force += bodyBodyInteraction(position, c.position, c.mass) );
    velocity = velocity + new Vector(force.x / mass, force.y / mass);
    position = position + velocity;
  }


}