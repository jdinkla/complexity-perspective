/**
 * (c) 2016 Jörn Dinkla, www.dinkla.com
 * See the file LICENSE in the ROOT directory.
 *
 * Code für die Physik-Modelle in Abschnitt 2.3
 */

import 'dart:html';
import 'vector.dart';
import 'circle.dart';
import 'dart:math' as math;

typedef List<Circle> mkModel();

final num xRange = 11;
final num yRange = 7;
final num offset = 50;

class Physics {

  CanvasElement canvas;
  int width;
  int height;
  ParamElement _pe;
  var ctx;

  int time;
  List<Circle> objects;
  mkModel genModel;

  Physics(this.canvas, mkModel genModel) {
    final Rectangle rect = canvas.parent.client;
    width = rect.width;
    height = rect.height;
    canvas.width = width;
    canvas.height = height;
    this.genModel = genModel;

    var doc = window.document;
    _pe = doc.querySelector('#stepCounter');
    ctx = canvas.context2D;

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
    final num x = coords.x;
    final num y = coords.y;
    final num scaleX = (width - 3 * offset) / xRange;
    final num scaleY = (height - 3 * offset) / yRange;
    final num px = offset + x * scaleX;
    final num py = height - offset - y * scaleY;
    return new Vector(px, py);
  }

  void line(var ctx, Vector u, Vector v) {
    Vector v1 = translate(u);
    Vector v2 = translate(v);
    ctx.moveTo(v1.x, v1.y);
    ctx.lineTo(v2.x, v2.y);
  }

  void draw([_]) {
    _pe.text = "Step ${time}";
    ctx.clearRect(0, 0, width, height);

    // Die Achsen
    ctx.lineWidth = 1;
    ctx.strokeStyle = "black";
    ctx.beginPath();
    // x-Achse
    line(ctx, Vector.origin, new Vector(xRange - 1, 0));
    for (int i = 1; i < xRange-1; i++) {
      line(ctx, new Vector(i, -0.1), new Vector(i, 0.1));
    }
    // y-Achse
    line(ctx, Vector.origin, new Vector(0, yRange - 1));
    for (int i = 1; i < yRange-1; i++) {
      line(ctx, new Vector(-0.1, i), new Vector(0.1, i));
    }
    ctx.closePath();
    ctx.stroke();
    // Die Planeten
    objects.forEach( (Circle c) {
      Vector p = translate(c.position);
      ctx.beginPath();
      ctx.fillStyle = c.color;
      ctx.strokeStyle = c.color;
      ctx.lineWidth = 0;
      ctx.arc(p.x, p.y, c.mass * 10, 0, 2*math.PI);
      ctx.fill();
      ctx.stroke();
    });
  }

}
