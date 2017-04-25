// /**
//  * (c) 2016 Jörn Dinkla, www.dinkla.net
//  * See the file LICENSE in the ROOT directory.
//  *
//  * Ein Kreis bzw. ein "Planet". Siehe Abschnitt 2.3 im Buch.
//  */

import Vector from '../src/vector';

class Circle {

  constructor(color = '', mass = 0.0, position = Vector.origin, velocity = Vector.origin) {
    this.color = color;
    this.mass = mass;
    this.position = position;
    this.velocity = velocity;
  }

  step() {
    this.position = this.position.plus(this.velocity);
  }

}

export default Circle;
