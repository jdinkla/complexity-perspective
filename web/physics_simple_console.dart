/**
 *
 * Standalone version for the books "" and "".
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'dart:convert' show JSON;

const String sep=";";

/*
 * Two dimensional Vector
 */
class Vector {

  final num x, y;

  const Vector(this.x, this.y);

  Vector operator +(Vector v) => new Vector(x + v.x, y + v.y);

  static const origin = const Vector(0, 0);

  String toString() => "($x,$y)";

}

/*
 *
 */
class Circle {

  String color;
  num mass;
  Vector position;
  Vector velocity;

  Circle({color: "", mass: 0.0, position: Vector.origin, velocity: Vector.origin}) {
    this.color = color;
    this.mass = mass;
    this.position = position;
    this.velocity = velocity;
  }

  step() {
    position = position + velocity;
    print(toJSON());
  }

  String toString() => "color: $color, mass: $mass, position: $position, velocity: $velocity";

  String toCSV() => "$color$sep$mass$sep$position$sep$velocity";

  Map toMap() => {"color": color, "mass": mass, "position": position.toString(), "velocity": velocity.toString() };

  String toJSON() => JSON.encode(toMap());

  String toXML() => """<circle>
  <color>$color</color>
  <mass>$mass</mass>
  <position>$position</position>
  <velocity>$velocity</velocity>
</circle>""";


}

setup1() {
  var u, v, w;
  u = new Circle(color: "blau", mass: 3, position: new Vector(2, 1));
  v = new Circle(color: "grau", mass: 4, position: new Vector(5, 3));
  w = new Circle(color: "rot", mass: 2, position: new Vector(9, 4));

  print([u, v, w]);
}

setup2() {
  var u, v, w;
  u = new Circle(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  v = new Circle(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  w = new Circle(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

  print(u);
  u.step();
  print(u);
  u.step();
  print(u);
}

run5Steps() {
  var u = new Circle(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

  // run 5 steps for u,v and w
  for (var t = 0; t < 5; t++) {
    print("t=$t: $u, $v, $w");
    u.step(); v.step(); w.step();
  }
}

main(List<String> args) {
  print('Example 1 ----------------------');
  setup1();
  print('Example 2 ----------------------');
  setup2();
  print('Example 3 ----------------------');
  run5Steps();
  print('End       ----------------------');
}
