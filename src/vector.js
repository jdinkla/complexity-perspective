// /**
//  * (c) 2016 Jörn Dinkla, www.dinkla.com
//  * See the file LICENSE in the ROOT directory.
//  *
//  * Ein zweidimensionaler Vektor.
//  */

// import 'dart:math';

// /**
//  * A two dimensional vector.
//  */
class Vector {

  constructor(x = 0.0, y = 0.0) {
    this.x = x;
    this.y = y;
  }

  plus(w) {
    return new Vector(this.x + w.x, this.y + w.y);
  }

  static origin = new Vector(0.0, 0.0);

}

export default Vector;
