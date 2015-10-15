/**
 *
 * Unit tests of the class Cells.
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'package:test/test.dart';
import '../web/cells.dart';

void main() {

  Cells<int> a, b;

  setUp(() async {
    a = new Cells<int>(3, 3);
    a.set(0, 0, 1);
    a.set(1, 0, 2);
    a.set(2, 0, 3);
    a.set(0, 1, 4);
    a.set(1, 1, 5);
    a.set(2, 1, 6);
    a.set(0, 2, 7);
    a.set(1, 2, 8);
    a.set(2, 2, 9);

    b = new Cells<int>(3, 4);
  });

  group("Cells", () {
    test("constructor", () {
      expect(a.get(0,0), equals(1));
      expect(a.get(0,1), equals(4));
      expect(a.get(1,0), equals(2));
      expect(a.get(1,1), equals(5));
    });

    test("previousX", () {
      expect(b.previousX(1), equals(0));
      expect(b.previousX(0), equals(2));
    });

    test("previousY", () {
      expect(b.previousY(1), equals(0));
      expect(b.previousY(0), equals(3));
    });

    test("nextX", () {
      expect(b.nextX(1), equals(2));
      expect(b.nextX(2), equals(0));
    });

    test("nextY", () {
      expect(b.nextY(1), equals(2));
      expect(b.nextY(3), equals(0));
    });

    test(".neighbours 1", () {
      var ns1 = a.neighbours(1, 1);
      expect(ns1.length, equals(9));
      expect(ns1, equals([1, 2, 3, 4, 5, 6, 7, 8, 9]));
    });

    test(".neighbours 2", () {
      var ns1 = a.neighbours(0, 0);
      expect(ns1.length, equals(9));
      expect(ns1, equals([1, 2, 3, 4, 5, 6, 7, 8, 9]));
    });

  });

}
