/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Ein zweidimensionaler Vektor.
 */

import 'dart:math';

/**
 * A two dimensional vector.
 */
class Vector {

  final num x;
  final num y;

  const Vector(this.x, this.y);

  Vector operator +(Vector v) => new Vector(x + v.x, y + v.y);

  String toString() => "($x, $y)";

  @override
  bool operator ==(Vector v) => x == v.x && y == v.y;

  // if one overrides ==, you should also override hashCode
  @override
  int get hashCode => (x*41+y).hashCode;

  static const origin = const Vector(0, 0);

}
