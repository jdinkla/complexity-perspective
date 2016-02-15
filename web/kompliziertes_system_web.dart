/**
 * (c) 2016 Jörn Dinkla, www.dinkla.com
 * See the file LICENSE in the ROOT directory.
 *
 * Code für das komplizierte Modell in Abschnitt 2.3.
 */

import 'dart:html';
import 'vector.dart';
import 'circle2.dart';
import 'physics.dart';

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
