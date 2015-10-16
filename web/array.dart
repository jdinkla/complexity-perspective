/**
 *
 * Class Array.
 *
 * An array of m*n elements.
 *
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'coordinates.dart';

class Array<T> {

  final int m;
  final int n;
  List<T> elements;
  Coordinates coords;

  Array(this.m, this.n) {
    assert(1 <= m);
    assert(1 <= n);
    elements = new List<T>(m*n);
    coords = new Coordinates(m, n);
  }

  void set(int i, int j, T v) {
    elements[coords.index(i, j)] = v;
  }

  T get(int i, int j) {
    return elements[coords.index(i, j)];
  }

  void set1(int i, T v) {
    elements[i] = v;
  }

  T get1(int i) {
    return elements[i];
  }

  void clear() {
    for (var i=0; i<m*n; i++) {
      elements[i] = null;
    }
  }

}

