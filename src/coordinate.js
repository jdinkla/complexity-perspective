/**
 * (c) 2016, 2017 Jörn Dinkla, www.dinkla.net
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

  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

// //   const Coordinate(this.x, this.y);
// toString() {
//   return `(${this.x}, ${this.y})`;
// }

// equals(c) {
//   return c.x === this.x && c.y === this.y;
// }

//   @override
//   bool operator ==(Coordinate p) => x == p.x && y == p.y;

//   // if one overrides ==, you should also override hashCode
//   @override
//   int get hashCode => (x*41+y).hashCode;

}

export default Coordinate;
