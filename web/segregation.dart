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

class Statistics {

  int _t;
  Map<int, int> numMovesPerStep;
  Map<int, int> numRedMovesPerStep;
  Map<int, int> numBlueMovesPerStep;
  bool hasChanged;

  Statistics() {
    _t = 0;
    numMovesPerStep = {};
    numRedMovesPerStep = {};
    numBlueMovesPerStep = {};
  }


  void move(Agent a) {
    numMovesPerStep.putIfAbsent(_t, () => 0);
    numMovesPerStep[_t]++;
    if (a.color == Color.red) {
      numRedMovesPerStep.putIfAbsent(_t, () => 0);
      numRedMovesPerStep[_t]++;
    } else {
      numBlueMovesPerStep.putIfAbsent(_t, () => 0);
      numBlueMovesPerStep[_t]++;
    }
    hasChanged = true;
  }

  step() {
    _t++;
    hasChanged = false;
  }

  void report() {
    int numTimeSteps = _t;
    int numMoves = numMovesPerStep.values.fold(0, (a, b) => a+b);
    int numRedMoves = numRedMovesPerStep.values.fold(0, (a, b) => a+b);
    int numBlueMoves = numBlueMovesPerStep.values.fold(0, (a, b) => a+b);
    print("Stats : $numTimeSteps, $numMoves, $numRedMoves, $numBlueMoves");
    print("numMovesPerStep: ${numMovesPerStep}");
    print("numRedMovesPerStep: ${numRedMovesPerStep}");
    print("numBlueMovesPerStep: ${numBlueMovesPerStep}");
  }

  int get time => _t;

}


class Agent {

  final Color color;
  final int minimumSame;
  Cells<Agent> cells;
  Coordinate pos;
  final Statistics stats;

  Agent(this.color, this.cells, this.pos, this.minimumSame, this.stats) {
    assert(cells != null);
    assert(stats != null);
  }

  void step() {
    var ns = cells.neighbours(pos.x, pos.y);
    var others = ns.where( (Agent a) => a != null && a.color == this.color );
    var numSame = others.length;
    if (numSame < minimumSame) {
      Coordinate newPos = cells.getEmpty(pos);
      cells.set(newPos.x, newPos.y, this);
      cells.set(pos.x, pos.y, null);
      //print("Agent ${pos} moves from ${pos} to ${newPos}");
      stats.move(this);
      pos = newPos;
    }
  }

}

class Segregation {

  final int m;
  final int n;
  Coordinates coords;
  Cells<Agent> cells;
  Distribution<Color> _distrib;

  Statistics stats;

  double empty;                     // is changeable
  int numberOfSame;                 // is changeable

  Segregation(this.m, this.n) {
    cells = new Cells(m, n);
    coords = new Coordinates(m, n);
  }

  void setup() {
    stats = new Statistics();
    cells.clear();
    // Distribution
    double colored = (1.0 - empty) / 2;
    _distrib = new Distribution([Color.empty, Color.red, Color.blue], [empty, colored, colored]);
    // Fill cells
    for (var i = 0; i < m*n; i++) {
      var c = _distrib.next();
      if (c != Color.empty) {
        var p = coords.position(i);
        var a = new Agent(c, cells, p, numberOfSame, stats);
        cells.set1(i, a);
      }
    }
    cells.calcEmpty();
  }

  void step() {
    stats.step();
    cells.elements.forEach( (Agent a) {
      if (a != null) a.step();
    });
  }

  void finish() {
    stats.report();
  }

}
