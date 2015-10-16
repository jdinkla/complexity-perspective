/**
 *
 * Standalone version for the books "" and "".
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'physics_simple_web.dart' show Circle, Physics;
import 'dart:html';
import 'vector.dart';
import 'dart:math' show sqrt;

const num softeningSquared = 0.0;

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
class Circle2 extends Circle {

  List<Circle> objects;

  Circle2({color: "", mass: 0, position: Vector.origin, velocity: Vector.origin}) : super(color: color, mass: mass, position: position, velocity: velocity);

  @override
  step() {
    Vector force = new Vector(0, 0);
    objects
    .where( (Circle c) => c != this)
    .forEach( (Circle c) => force += bodyBodyInteraction(position, c.position, c.mass) );
    velocity = velocity + new Vector(force.x / mass, force.y / mass);
    position = position + velocity;
  }

}

List<Circle2> getModel2() {
  var u = new Circle2(color: "#1E2D5B", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle2(color: "#7F7F7F", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle2(color: "#AF0A14", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));
  var ls = [u, v, w];
  ls.forEach((Circle2 c) => c.objects = ls);
  return ls;
}

main(List<String> args) {
  CanvasElement canvas = querySelector("#area");
  var p = new Physics(canvas, () => getModel2());
  p.setup();
  p.requestRedraw();
}
