/**
 * A circle or "planet". See Section 2.3 in the book.
 */

import 'package:complexity_perspective/vector.dart';

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