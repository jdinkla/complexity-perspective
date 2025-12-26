/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Ein Kreis bzw. ein "Planet". Siehe Abschnitt 2.3 im Buch.
 */

import 'package:complexity_perspective/core/vector.dart';

class Circle {

  String color;
  num mass;
  Vector position;
  Vector velocity;

  Circle({this.color = "", this.mass = 0.0, this.position = Vector.origin, this.velocity = Vector.origin});

  step() {
    position = position + velocity;
  }

  String toString() => "color: $color, mass: $mass, position: $position, velocity: $velocity";

}