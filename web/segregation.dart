/**
 *
 */

import 'cells.dart';
import 'distribution.dart';
import 'coordinates.dart';
import 'coordinate.dart';


enum Color {
  empty,
  red,
  blue
}

String printColor(Color c) {
  String result = "";
  switch (c) {
    case Color.empty:
      result = " ";
      break;
    case Color.red:
      result = "R";
      break;
    case Color.blue:
      result = "B";
      break;
  }
  return result;
}

class Agent {

  final Color color;
  final int minimumSame;
  Cells<Agent> cells;
  Coordinate pos;

  Agent(this.color, this.cells, this.pos, this.minimumSame) {
  }

  void step() {
    var ns = cells.neighbours(x, y);
    var others = ns.where( (Agent a) => a != null && a.color == this.color );
    var numSame = others.length;
    if (numSame < minimumSame) {
      Coordinate newPos = cells.getEmpty(pos);
      cells.set(newPos.x, newPos.y, this);
      pos = newPos;
    }
  }

}

class Segregation {

  final int m;
  final int n;
  Coordinates coords;

  Cells<Agent> _cells;
  Distribution<Color> _distrib;
  double empty;                     // is changeable
  int numberOfSame;                 // is changeable

  Segregation(this.m, this.n) {
    _cells = new Cells(m, n);
    empty = 0.2;
    coords = new Coordinates(m, n);
  }

  void setup() {
    _cells.clear();

    double colored = (1.0 - empty) / 2;
    _distrib = new Distribution([Color.empty, Color.red, Color.blue], [empty, colored, colored]);

    for (var i = 0; i < m*n; i++) {
      var c = _distrib.next();
      if (c != Color.empty) {
        var v = coords.position(i);
        var a = new Agent(c, _cells, v.x, v.y, numberOfSame);
        _cells.set1(i, a);
      }
    }
    _cells.calcEmpty();

  }

  void printCells() {
    for (var j = 0; j < n; j++) {
      var sb = new StringBuffer();
      sb.write(" ");
      for (var i = 0; i < m; i++) {
        Agent a = _cells.get(i, j);
        Color c = a == null ? Color.empty : a.color;
        sb.write("${printColor(c)} ");
      }
      print(sb.toString());
    }
  }
}

main() {

  print("Hi");

  final int size = 10;
  var s = new Segregation(size, size);
  s.setup();
  s.printCells();

}