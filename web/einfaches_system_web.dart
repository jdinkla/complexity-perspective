/**
 * (c) 2016 Jörn Dinkla, www.dinkla.com
 * See the file LICENSE in the ROOT directory.
 *
 * Code für das einfache Modell in Abschnitt 2.3.
 */

import 'vector.dart';
import 'dart:html';
import 'circle.dart';
import 'physics.dart';

List<Circle> getModel() {
  var u = new Circle(color: "#1E2D5B", mass: 3, position: new Vector(2, 1), velocity: new Vector(2, 0));
  var v = new Circle(color: "#7F7F7F", mass: 4, position: new Vector(5, 3), velocity: new Vector(0, 0));
  var w = new Circle(color: "#AF0A14", mass: 2, position: new Vector(9, 4), velocity: new Vector(-1, -1));
  return [u, v, w];
}

main(List<String> args) {

  CanvasElement canvas = querySelector("#area");
  var p = new Physics(canvas, () => getModel());
  p.setup();
  p.requestRedraw();

}
