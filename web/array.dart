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
class Array<T> {

  final int m;
  final int n;
  List<T> _elements;

  Array(this.m, this.n) {
    assert(1 <= m);
    assert(1 <= n);
    _elements = new List<T>(m*n);
  }

  void set(int i, int j, T v) {
    assert(0 <= i && i < m);
    assert(0 <= j && j < n);
    _elements[_index(i, j)] = v;
  }

  T get(int i, int j) {
    assert(0 <= i && i < m);
    assert(0 <= j && j < n);
    return _elements[_index(i, j)];
  }

  int _index(int i, int j) => j * m + i;


}

