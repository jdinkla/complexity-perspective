/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Ein Kreis bzw. ein "Planet". Siehe Abschnitt 2.3 im Buch.
 */

import 'vector.dart';

class Circle {

  String color;
  num mass;
  Vector position;
  Vector velocity;

  Circle({color: "", mass: 0.0, position: Vector.origin, velocity: Vector.origin}) {
    this.color = color;
    this.mass = mass;
    this.position = position;
    this.velocity = velocity;
  }

  step() {
    position = position + velocity;
  }

  String toString() => "color: $color, mass: $mass, position: $position, velocity: $velocity";

  //String toCSV() => "$color$sep$mass$sep$position$sep$velocity";

  // Konvertiere zu Map
  //Map toMap() => {"color": color, "mass": mass, "position": position.toString(), "velocity": velocity.toString() };

// print(toJSON());
// String toJSON() => JSON.encode(toMap());

  /*
  String toXML() => """<circle>
  <color>$color</color>
  <mass>$mass</mass>
  <position>$position</position>
  <velocity>$velocity</velocity>
</circle>""";
*/

}