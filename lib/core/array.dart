/**
 *
 * Class Array.
 *
 * An array of m*n elements.
 *
 */

import 'package:complexity_perspective/core/coordinates.dart';

class Array<T> {

  final int m;
  final int n;
  late List<T?> elements;
  late Coordinates coords;

  Array(this.m, this.n) {
    assert(1 <= m);
    assert(1 <= n);
    elements = List<T?>.filled(m*n, null);
    coords = Coordinates(m, n);
  }

  void set(int i, int j, T? v) {
    elements[coords.index(i, j)] = v;
  }

  T? get(int i, int j) {
    return elements[coords.index(i, j)];
  }

  void set1(int i, T? v) {
    elements[i] = v;
  }

  T? get1(int i) {
    return elements[i];
  }

  void clear() {
    for (var i=0; i<m*n; i++) {
      elements[i] = null;
    }
  }

}

