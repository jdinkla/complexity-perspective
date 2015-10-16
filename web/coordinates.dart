/**
 *
 * Class Coordinates.
 *
 * Two dimensional coordinates.
 *
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'coordinate.dart';

class Coordinates {

  final int m;
  final int n;

  Coordinates(this.m, this.n) {
    assert(1 <= m);
    assert(1 <= n);
  }

  int index(int i, int j) {
    assert(0 <= i && i < m);
    assert(0 <= j && j < n);
    return j * m + i;
  }

  int index2(Coordinate c) => index(c.x, c.y);

  int previousX(int i) => i == 0 ? m-1 : i-1;

  int previousY(int j) => j == 0 ? n-1 : j-1;

  int nextX(int i) => i == m-1 ? 0 : i+1;

  int nextY(int j) => j == n-1 ? 0 : j+1;

  Coordinate position(int i) {
    int x = i % m;
    int y = i ~/ m;
    return new Coordinate(x, y);
  }

}

