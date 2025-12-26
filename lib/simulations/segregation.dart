/**
 * (c) 2016 Jörn Dinkla, www.dinkla.com
 * See the file LICENSE in the ROOT directory.
 *
 * Code für das Schelling-Modell in Abschnitt 2.3
 */

import 'package:complexity_perspective/core/cells.dart';
import 'package:complexity_perspective/core/Distribution.dart';
import 'package:complexity_perspective/core/coordinates.dart';
import 'package:complexity_perspective/core/coordinate.dart';

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

  int _t = 0;
  Map<int, int> numMovesPerStep = {};
  Map<int, int> numRedMovesPerStep = {};
  Map<int, int> numBlueMovesPerStep = {};
  bool hasChanged = false;

  Statistics();

  void move(Agent a) {
    numMovesPerStep.putIfAbsent(_t, () => 0);
    numMovesPerStep[_t] = (numMovesPerStep[_t] ?? 0) + 1;
    if (a.color == Color.red) {
      numRedMovesPerStep.putIfAbsent(_t, () => 0);
      numRedMovesPerStep[_t] = (numRedMovesPerStep[_t] ?? 0) + 1;
    } else {
      numBlueMovesPerStep.putIfAbsent(_t, () => 0);
      numBlueMovesPerStep[_t] = (numBlueMovesPerStep[_t] ?? 0) + 1;
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
    var ns = cells.neighbours(pos.x.toInt(), pos.y.toInt());
    var sameColored = ns.where( (Agent? a) => a != null && a.color == this.color );
    var numSame = sameColored.length;
    if (numSame <= minimumSame) {
      Coordinate newPos = cells.getEmpty(pos);
      cells.set(newPos.x.toInt(), newPos.y.toInt(), this);
      cells.set(pos.x.toInt(), pos.y.toInt(), null);
      //print("Agent ${pos} moves from ${pos} to ${newPos}");
      stats.move(this);
      pos = newPos;
    }
  }

}

class Segregation {

  late Coordinates _coords;
  late Cells<Agent> cells;
  late Distribution<Color> _distrib;
  late Statistics stats;

  int m = 0;                            // Breite
  int n = 0;                            // Höhe
  double empty = 0.0;                     // Anzahl leerer Zellen in Prozent
  int numberOfSame = 0;                 // Anzahl gleicher Nachbarn

  void setup(int m, int n) {
    this.m = m;
    this.n = n;
    cells = new Cells(m, n);
    _coords = new Coordinates(m, n);
    stats = new Statistics();
    cells.clear();
    // Distribution
    double colored = (1.0 - empty) / 2;
    _distrib = new Distribution([Color.empty, Color.red, Color.blue], [empty, colored, colored]);
    // Fill cells
    for (var i = 0; i < m*n; i++) {
      var c = _distrib.next();
      if (c != Color.empty) {
        var p = _coords.position(i);
        var a = new Agent(c, cells, p, numberOfSame, stats);
        cells.set1(i, a);
      }
    }
    cells.calcEmpty();
  }

  void step() {
    stats.step();
    cells.elements.forEach( (Agent? a) {
      if (a != null) a.step();
    });
  }

  void finish() {
    stats.report();
  }

  Agent? agent(int i, int j) => cells.get(i, j);

}
