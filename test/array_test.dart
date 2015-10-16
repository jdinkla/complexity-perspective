/**
 *
 * Unit tests of the class Array.
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'package:test/test.dart';
import '../web/array.dart';

void main() {
  group("Array", () {
    test("constructor", () {
      var a = new Array<int>(2, 2);
      expect(a.get(0,0), equals(null));
      expect(a.get(0,1), equals(null));
      expect(a.get(1,0), equals(null));
      expect(a.get(1,1), equals(null));
    });

    test(".set and .get", () {
      var a = new Array<int>(2, 2);
      expect(a.get(0,0), equals(null));
      expect(a.get(0,1), equals(null));
      expect(a.get(1,0), equals(null));
      expect(a.get(1,1), equals(null));

      a.set(0, 0, 1);
      expect(a.get(0,0), equals(1));
      expect(a.get(0,1), equals(null));
      expect(a.get(1,0), equals(null));
      expect(a.get(1,1), equals(null));

      a.set(1, 1, 2);
      expect(a.get(0,0), equals(1));
      expect(a.get(0,1), equals(null));
      expect(a.get(1,0), equals(null));
      expect(a.get(1,1), equals(2));
    });

    test(".set1 and .get1", () {
      var a = new Array<int>(2, 2);
      expect(a.get1(0), equals(null));
      expect(a.get1(1), equals(null));
      expect(a.get1(2), equals(null));
      expect(a.get1(3), equals(null));

      a.set1(0, 1);
      expect(a.get1(0), equals(1));
      expect(a.get1(1), equals(null));
      expect(a.get1(2), equals(null));
      expect(a.get1(3), equals(null));

      a.set1(3, 2);
      expect(a.get1(0), equals(1));
      expect(a.get1(1), equals(null));
      expect(a.get1(2), equals(null));
      expect(a.get1(3), equals(2));
    });

    test(".clear", () {
      var a = new Array<int>(2, 2);
      a.set1(0, 1);
      a.set1(3, 2);

      expect(a.get1(0), equals(1));
      expect(a.get1(1), equals(null));
      expect(a.get1(2), equals(null));
      expect(a.get1(3), equals(2));

      a.clear();
      expect(a.get1(0), equals(null));
      expect(a.get1(1), equals(null));
      expect(a.get1(2), equals(null));
      expect(a.get1(3), equals(null));
    });

  });

}
