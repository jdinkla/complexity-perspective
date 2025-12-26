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
import 'package:complexity_perspective/core/vector.dart';

void main() {
  group("Vector", () {
    test("constructor", () {
      var v = Vector(1, 2);
      expect(v.x, equals(1));
      expect(v.y, equals(2));

      var w = Vector(-1, -2);
      expect(w.x, equals(-1));
      expect(w.y, equals(-2));

      var u = Vector(1.1, -2.2);
      expect(u.x, equals(1.1));
      expect(u.y, equals(-2.2));
    });

    test(".+", () {
      var v = Vector(1, 2);
      var w = Vector(-1, -2);
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

    test("==", () {
      var u = Vector.origin;
      var v = Vector(0, 0);
      assert(!identical(u, v));
      assert(u == v);
    });

  });

}
