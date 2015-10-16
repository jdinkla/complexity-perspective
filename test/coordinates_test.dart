/**
 *
 * Unit tests of the class Coordinates.
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'package:test/test.dart';
import '../web/coordinates.dart';
import '../web/coordinate.dart';

void main() {

  Coordinates c;

  setUp(() async {
    c = new Coordinates(3, 4);
  });

  group("Coordinates", () {
    test("constructor", () {
      expect(c.m, equals(3));
      expect(c.n, equals(4));
    });

    test("index", () {
      expect(c.index(0, 0), equals(0));
      expect(c.index(1, 0), equals(1));
      expect(c.index(0, 1), equals(3));
      expect(c.index(2, 3), equals(11));
    });

    test("previousX", () {
      expect(c.previousX(1), equals(0));
      expect(c.previousX(0), equals(2));
    });

    test("previousY", () {
      expect(c.previousY(1), equals(0));
      expect(c.previousY(0), equals(3));
    });

    test("nextX", () {
      expect(c.nextX(1), equals(2));
      expect(c.nextX(2), equals(0));
    });

    test("nextY", () {
      expect(c.nextY(1), equals(2));
      expect(c.nextY(3), equals(0));
    });

    test("position", () {
      expect(c.position(0), equals(new Coordinate(0, 0)));
      expect(c.position(1), equals(new Coordinate(1, 0)));
      expect(c.position(2), equals(new Coordinate(2, 0)));
      expect(c.position(3), equals(new Coordinate(0, 1)));
      expect(c.position(11), equals(new Coordinate(2, 3)));
    });

  });

}
