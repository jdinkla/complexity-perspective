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
    print(numMovesPerStep);
    int numTimeSteps = _t;
    int numMoves = numMovesPerStep.values.fold(0, (a, b) => a+b);
    int numRedMoves = numRedMovesPerStep.values.fold(0, (a, b) => a+b);
    int numBlueMoves = numBlueMovesPerStep.values.fold(0, (a, b) => a+b);
    print("Stats : $numTimeSteps, $numMoves, $numRedMoves, $numBlueMoves");
  }

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
      print("Agent ${pos} moves from ${pos} to ${newPos}");
      stats.move(this);
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

  Statistics stats;

  double empty;                     // is changeable
  int numberOfSame;                 // is changeable

  Segregation(this.m, this.n, this.empty, this.numberOfSame) {
    _cells = new Cells(m, n);
    coords = new Coordinates(m, n);
  }

  void setup() {
    stats = new Statistics();

    _cells.clear();

    double colored = (1.0 - empty) / 2;
    _distrib = new Distribution([Color.empty, Color.red, Color.blue], [empty, colored, colored]);

    for (var i = 0; i < m*n; i++) {
      var c = _distrib.next();
      if (c != Color.empty) {
        var p = coords.position(i);
        var a = new Agent(c, _cells, p, numberOfSame, stats);
        _cells.set1(i, a);
      }
    }
    _cells.calcEmpty();

  }

  void step() {
    stats.step();
    _cells.elements.forEach( (Agent a) {
      if (a != null) a.step();
    });
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

  void finish() {
    stats.report();
  }

  void runConsole(int numSteps) {
    setup();
    print("Initial setup");
    printCells();
    for (int t = 0; t < numSteps; t++ ) {
      print("Step ${t+1}");
      step();
      printCells();
      if (!stats.hasChanged) {
        print("Aborting, because no change");
        break;
      }
    }
    finish();
  }

}

main() {

  final int maxT = 10;
  final int size = 100;
  final double empty = 0.1;
  final int numberOfSame = 4;
  var s = new Segregation(size, size, empty, numberOfSame);
  s.runConsole(maxT);

}