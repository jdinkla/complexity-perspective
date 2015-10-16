/**
 *
 * Standalone version for the books "" and "".
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'vector.dart';
import 'dart:html';
import 'dart:math' as math;

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
  }

  String toString() => "color: $color, mass: $mass, position: $position, velocity: $velocity";

}

typedef List<Circle> mkModel();

class Physics {

  CanvasElement canvas;
  int width;
  int height;
  ParamElement pe;
  var doc;

  int time;
  List<Circle> objects;
  mkModel genModel;

  num xRange = 11;
  num yRange = 7;
  num offset = 50;

  Physics(this.canvas, mkModel genModel) {
    Rectangle rect = canvas.parent.client;
    width = rect.width;
    height = rect.height;
    canvas.width = width;
    canvas.height = height;
    this.genModel = genModel;

    doc = window.document;
    pe = doc.querySelector('#stepCounter');

    doc.querySelector("#step").onClick.listen((_) {
      step();
      requestRedraw();
    });
    doc.querySelector("#setup").onClick.listen((_) {
      setup();
      requestRedraw();
    });
  }

  void setup() {
    time = 0;
    objects = genModel();
  }

  void step() {
    time++;
    objects.forEach( (Circle c) => c.step());
  }

  void requestRedraw() {
    window.requestAnimationFrame(draw);
  }

  Vector translate(Vector coords) {
    num x = coords.x;
    num y = coords.y;
    num scaleX = (width - 3 * offset) / xRange;
    num scaleY = (height - 3 * offset) / yRange;
    num px = offset + x * scaleX;
    num py = height - offset - y * scaleY;
    return new Vector(px, py);
  }

  void line(var ctx, Vector u, Vector v) {
    Vector v1 = translate(u);
    Vector v2 = translate(v);
    ctx.moveTo(v1.x, v1.y);
    ctx.lineTo(v2.x, v2.y);
    ctx.stroke();
  }

  void draw([_]) {
    pe.text = "Step ${time}";
    var ctx = canvas.context2D;
    ctx.clearRect(0, 0, width, height);

    // x axis
    ctx.lineWidth = 1;
    ctx.strokeStyle = "black";

    line(ctx, Vector.origin, new Vector(xRange - 1, 0));
    for (int i = 1; i < xRange-1; i++) {
      line(ctx, new Vector(i, -0.1), new Vector(i, 0.1));
    }
    // y axis
    line(ctx, Vector.origin, new Vector(0, yRange - 1));
    for (int i = 1; i < yRange-1; i++) {
      line(ctx, new Vector(-0.1, i), new Vector(0.1, i));
    }

    // circles
    objects.forEach( (Circle c) {
      Vector p = translate(c.position);
      ctx.beginPath();
      ctx.lineWidth = 0;
      ctx.strokeStyle = c.color;
      ctx.fillStyle = c.color;
      ctx.arc(p.x, p.y, c.mass * 10, 0, 2*math.PI);
      ctx.fill();
      ctx.stroke();
    });

  }

}

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
