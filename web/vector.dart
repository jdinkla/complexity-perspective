/**
 *
 * Class Vector.
 *
 * A two dimensional vector.
 *
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
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

  static const origin = const Vector(0, 0);

  String toString() => "($x, $y)";

}
