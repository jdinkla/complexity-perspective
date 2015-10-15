/**
 *
 * Unit tests of the class Vector.
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'package:test/test.dart';
import '../web/vector.dart';

void main() {
  group("Vector", () {
    test("constructor", () {
      var v = new Vector(1, 2);
      expect(v.x, equals(1));
      expect(v.y, equals(2));

      var w = new Vector(-1, -2);
      expect(w.x, equals(-1));
      expect(w.y, equals(-2));

      var u = new Vector(1.1, -2.2);
      expect(u.x, equals(1.1));
      expect(u.y, equals(-2.2));
    });

    test(".+", () {
      var v = new Vector(1, 2);
      var w = new Vector(-1, -2);
      var u = v + w;
      expect(u.x, equals(0));
      expect(u.y, equals(0));
    });

    test(".origin", () {
      var u = Vector.origin;
      expect(u.x, equals(0));
      expect(u.y, equals(0));
    });

    test(".toString()", () {
      var u = Vector.origin;
      expect(u.toString(), equals("(0, 0)"));
    });
  });

}
