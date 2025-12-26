/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Class Coordinate.
 *
 * A position on a board. Simpler than vector.
 *
 */

/**
 * A coordinate in a two dimensional coordinate system.
 */
class Coordinate {

  final num x;
  final num y;

  const Coordinate(this.x, this.y);

  String toString() => "($x, $y)";

  @override
  bool operator ==(Object? other) => other is Coordinate && x == other.x && y == other.y;

  // if one overrides ==, you should also override hashCode
  @override
  int get hashCode => (x*41+y).hashCode;

}
