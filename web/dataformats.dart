/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Die verschiedenen Datenformate aus Kapitel 6.
 */

import 'circle.dart';
import 'vector.dart';
import 'dart:convert';

class ConvCircle extends Circle {

  ConvCircle({color: "", mass: 0.0, position: Vector.origin, velocity: Vector.origin})
      : super(color: color, mass: mass, position: position, velocity: velocity)
  {
  }

  final String sep = ";";

  String toCSV() => "$color$sep$mass$sep$position$sep$velocity";

  // Konvertiere zu Map
  Map toMap() => {"color": color, "mass": mass, "position": position.toString(), "velocity": velocity.toString() };

  String toJSON() => JSON.encode(toMap());

  String toXML() => """<circle>
  <color>$color</color>
  <mass>$mass</mass>
  <position>$position</position>
  <velocity>$velocity</velocity>
</circle>""";

}

// Die Objekte
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

