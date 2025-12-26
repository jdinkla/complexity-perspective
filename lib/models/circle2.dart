/**
 * A circle or "planet" with gravity. See Section 2.3 in the book.
 */

import 'package:complexity_perspective/core/vector.dart';
import 'package:complexity_perspective/models/circle.dart';
import 'dart:math';

num softeningSquared = 0.0;

// Adapted from [Wil13, Listing 14.1]
// The variable names are taken from Wil13 as is.
// This code did not make it into the book because it could confuse many readers.
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

  // Contains the other planets
  List<Circle2>? objects;

  Circle2({String color = "", num mass = 0.0, Vector? position, Vector? velocity})
      : super(color: color, mass: mass, position: position ?? Vector.origin, velocity: velocity ?? Vector.origin)
  {
  }

  step() {
    if (objects == null) {
      throw Exception("Objects list is null");
    }
    Vector force = new Vector(0, 0);
    objects!
        .where( (Circle c) => c != this)
        .forEach( (Circle c) => force += bodyBodyInteraction(position, c.position, c.mass) );
    velocity = velocity + new Vector(force.x / mass, force.y / mass);
    position = position + velocity;
  }


}