/**
 *
 * Class Cells.
 *
 * An array of m*n elements.
 *
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'package:complexity_perspective/array.dart';
import 'package:complexity_perspective/coordinate.dart';
import 'dart:math' show Random;

class Cells<T> extends Array<T> {

  late List<int> emptyCells;
  late Random random;

  Cells(int m, int n) : super(m, n) {
    random = Random();
  }

  List<T?> neighbours(int i, int j) {
    final int im = coords.previousX(i);
    final int ip = coords.nextX(i);
    final int jm = coords.previousY(j);
    final int jp = coords.nextY(j);
    return <T?>[
      get(im, jm), get(i, jm), get(ip, jm),
      get(im, j),              get(ip, j),
      get(im, jp), get(i, jp), get(ip, jp)
    ];
  }

  void calcEmpty() {
    // count the number of empty cells
    final int numEmpty = elements.where((x) => x == null).length;
    // create a list of the indices of the empty cells
    emptyCells = List<int>.filled(numEmpty, 0);
    var j=0;
    for (var i=0; i<m*n; i++) {
      if (elements[i] == null) emptyCells[j++] = i;
    }
  }

  Coordinate getEmpty(Coordinate old) {
    var i = random.nextInt(emptyCells.length);        // get an random number
    var j = emptyCells[i];                            // get the empty cell index
    emptyCells[i] = coords.index2(old);               // the old position is empty now
    return coords.position(j);
  }

}

