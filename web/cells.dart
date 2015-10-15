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

import 'array.dart';

class Cells<T> extends Array<T> {

  Cells(int m, int n) : super(m, n) {
  }

  List<T> neighbours(int i, int j) {
    final int im = previousX(i);
    final int ip = nextX(i);
    final int jm = previousY(j);
    final int jp = nextY(j);
    return <T>[
      get(im, jm), get(i, jm), get(ip, jm),
      get(im, j),              get(ip, j),
      get(im, jp), get(i, jp), get(ip, jp)
    ];
  }

  int previousX(int i) => i == 0 ? m-1 : i-1;

  int previousY(int j) => j == 0 ? n-1 : j-1;

  int nextX(int i) => i == m-1 ? 0 : i+1;

  int nextY(int j) => j == n-1 ? 0 : j+1;


}

