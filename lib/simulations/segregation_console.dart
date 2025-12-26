/**
 * Code for the simple system in Section 2.3
 */

import 'package:complexity_perspective/simulations/segregation.dart';

class SegregationConsole extends Segregation {

  void printCells() {
    for (var j = 0; j < n; j++) {
      var sb = new StringBuffer();
      sb.write(" ");
      for (var i = 0; i < m; i++) {
        Agent a = cells.get(i, j);
        Color c = a == null ? Color.empty : a.color;
        sb.write("${printColor(c)} ");
      }
      print(sb.toString());
    }
  }

  void run(int size, int numSteps, double empty, int numberOfSame) {
    this.empty = empty;
    this.numberOfSame = numberOfSame;
    setup(size, size);
    format("Initialization");
    printCells();
    for (int t = 0; t < numSteps; t++ ) {
      format("Step ${t+1}");
      step();
      printCells();
      if (!stats.hasChanged) {
        format("Termination, because all agents are satisfied");
        break;
      }
    }
    finish();
  }

  format(String str, [length = 60]) {
    final int len = length - str.length - 1;
    print(str + " " + "-" * len);
  }

}

main() {
  final int maxT = 10;
  final int size = 10;
  final double empty = 0.05;
  final int numberOfSame = 3;

  var s = new SegregationConsole();
  s.run(size, maxT, empty, numberOfSame);
}