/**
 *
 * Unit tests of the class Distribution.
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'package:test/test.dart';
import '../web/distribution.dart';

void main() {

  final List<double> probs = [0.1, 0.6, 0.3];
  Distribution<String> d;

  setUp(() async {
    d = new Distribution<String>(["a", "b", "c"], probs);
  });

  group("Distribution", () {
    test("constructor", () {
      expect(d.probabilities, equals(probs));
      expect(d.cumulative, equals([0.1, 0.7, 1.0]));
    });

    test("cumulativeSum", () {
      expect(Distribution.cumulativeSum([1, 2, 3]), equals([1, 3, 6]));
      expect(Distribution.cumulativeSum([]), equals([]));
      expect(Distribution.cumulativeSum([5]), equals([5]));
      expect(Distribution.cumulativeSum([-1, 1]), equals([-1, 0]));
      expect(Distribution.cumulativeSum(probs), equals([0.1, 0.7, 1.0]));
    });

    test("find", () {
      expect(Distribution.find(0.25, [0.5, 1.0]), 0);
      expect(Distribution.find(0.5, [0.5, 1.0]), 0);
      expect(Distribution.find(0.51, [0.5, 1.0]), 1);
      expect(Distribution.find(0.99, [0.5, 1.0]), 1);
      expect(Distribution.find(1.0, [0.5, 1.0]), 1);
      expect(Distribution.find(1.01, [0.5, 1.0]), 1);
    });

    test("next", () {
      final int numNext = 1000;
      var m = new Map<String, int>();
      m["a"] = 0; m["b"] = 0; m["c"] = 0;
      for (var i = 0; i < numNext; i++) {
        var n = d.next();
        m[n] += 1;
      }
      //print(m);
      assert(m["a"] < m["b"]);
      assert(m["a"] < m["c"]);
      assert(m["c"] < m["b"]);
    });

  });

}
