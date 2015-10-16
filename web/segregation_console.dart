/**
 *
 */

import 'segregation.dart';

class SegregationConsole extends Segregation {

  SegregationConsole(int m, int n) : super(m, n) {
  }

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

  void run(int numSteps, double empty, int numberOfSame) {
    this.empty = empty;
    this.numberOfSame = numberOfSame;
    setup();
    print("Initial setup");
    //printCells();
    for (int t = 0; t < numSteps; t++ ) {
      print("Step ${t+1}");
      step();
      //printCells();
      if (!stats.hasChanged) {
        print("Aborting, because no change");
        break;
      }
    }
    finish();
  }

}

main() {

  final int maxT = 1000;
  final int size = 1000;
  final double empty = 0.01;
  final int numberOfSame = 4;

  var s = new SegregationConsole(size, size);
  s.run(maxT, empty, numberOfSame);

}