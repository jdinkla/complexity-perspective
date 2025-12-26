/**
 * Code für das einfache Modell in Abschnitt 2.3.
 */

import 'dart:html';
import 'package:complexity_perspective/core/vector.dart';
import 'package:complexity_perspective/models/circle.dart';
import 'package:complexity_perspective/models/physics.dart';

List<Circle> getModel() {
  var u = new Circle(color: "#1E2D5B", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle(color: "#7F7F7F", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle(color: "#AF0A14", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));
  return [u, v, w];
}

main(List<String> args) {

  CanvasElement? canvasElement = querySelector("#area") as CanvasElement?;
  if (canvasElement == null) {
    throw Exception("Canvas element #area not found");
  }
  var p = new Physics(canvasElement, () => getModel());
  p.setup();
  p.requestRedraw();

}
