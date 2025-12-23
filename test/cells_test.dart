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
import '../web/coordinate.dart';

void main() {

  late Cells<int> a;
  late Cells<int> b;

  setUp(() async {
    a = Cells<int>(3, 3);
    a.set(0, 0, 1);
    a.set(1, 0, 2);
    a.set(2, 0, 3);
    a.set(0, 1, 4);
    a.set(1, 1, 5);
    a.set(2, 1, 6);
    a.set(0, 2, 7);
    a.set(1, 2, 8);
    a.set(2, 2, 9);

    b = Cells<int>(3, 4);
  });

  group("Cells", () {
    test("constructor", () {
      expect(a.get(0,0), equals(1));
      expect(a.get(0,1), equals(4));
      expect(a.get(1,0), equals(2));
      expect(a.get(1,1), equals(5));
    });

    test(".neighbours 1", () {
      var ns1 = a.neighbours(1, 1);
      expect(ns1.length, equals(8));
      expect(ns1, equals([1, 2, 3, 4, 6, 7, 8, 9]));
    });

    /*
     * 1 2 3
     * 4 5 6
     * 7 8 9
     *
     * 9 7 8
     * 3 1 2
     * 6 4 5
     *
     */
    test(".neighbours 2", () {
      var ns1 = a.neighbours(0, 0);
      expect(ns1.length, equals(8));
      expect(ns1, equals([9, 7, 8, 3, 2, 6, 4, 5]));
    });

    test(".calcEmpty", () {
      a.calcEmpty();
      expect(a.emptyCells.length, equals(0));
      a.set(1, 1, null);
      a.calcEmpty();
      expect(a.emptyCells.length, equals(1));
    });

    test(".getEmpty", () {
      a.set(1, 1, null);
      a.calcEmpty();
      expect(a.emptyCells.length, equals(1));
      var oldC = Coordinate(2, 2);
      var c = a.getEmpty(oldC);
      expect(a.emptyCells.length, equals(1));
      expect(a.emptyCells, equals([8]));
    });

  });

}
