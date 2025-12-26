/**
 * The various data formats from Chapter 6.
 */

import 'package:complexity_perspective/circle.dart';
import 'package:complexity_perspective/vector.dart';
import 'dart:convert';

class ConvCircle extends Circle {

  ConvCircle({color: "", mass: 0.0, position: Vector.origin, velocity: Vector.origin})
      : super(color: color, mass: mass, position: position, velocity: velocity)
  {
  }

  final String sep = ";";

  String toCSV() => "$color$sep$mass$sep$position$sep$velocity";

  // Convert to Map
  Map toMap() => {"color": color, "mass": mass, "position": position.toString(), "velocity": velocity.toString() };

  String toJSON() => JSON.encode(toMap());

  String toXML() => """<circle>
  <color>$color</color>
  <mass>$mass</mass>
  <position>$position</position>
  <velocity>$velocity</velocity>
</circle>""";

}

// The objects
var u = new ConvCircle(color: "blau", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
var v = new ConvCircle(color: "grau", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
var w = new ConvCircle(color: "rot", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));

List<ConvCircle> ls = [u, v, w];

main(List<String> args) {
  print('--- CSV -----');
  ls.forEach( (var c) => print(c.toCSV()));

  print('--- JSON ----');
  ls.forEach( (var c) => print(c.toJSON()));

  print('--- XML  ----');
  ls.forEach( (var c) => print(c.toXML()));

  print('--- Ende ----');
}

