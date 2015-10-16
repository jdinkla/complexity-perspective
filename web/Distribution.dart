/**
 *
 * Class Distribution.
 *
 * An array of m*n elements.
 *
 *
 * (c) 2015 Jörn Dinkla, www.dinkla.net
 *
 * See the file LICENSE in the ROOT directory.
 *
 */

import 'dart:math' show Random, min;

class Distribution<T> {

  List<T> elems;
  List<double> probabilities;
  List<double> cumulative;
  Random random;

  Distribution(this.elems, this.probabilities) {
    assert(elems.length == probabilities.length);
    var sum = probabilities.fold(0, (a, b) => a+b);
    assert(sum == 1.0);
    cumulative = cumulativeSum(probabilities);
    random = new Random(); // TODO hier kann man die Generierung deterministisch machen!
  }

  T next() {
    final double d = random.nextDouble();
    assert(0.0 <= d && d <= 1.0);
    final int i = find(d, cumulative);
    return elems[i];
  }

  static int find(double d, List<double> cumulative) {
    int i = 0;
    int n = cumulative.length;
    bool found = false;
    while (!found && i<n) {
      if (d <= cumulative[i]) {
        found = true;
      } else {
        i++;
      }
    }
    return min(i, n-1);
  }

  static List<num> cumulativeSum(List<num> ls) {
    num sum = 0;
    var rs = [];
    ls.forEach( (x) {
      sum += x;
      rs.add(sum);
    });
    return rs;
  }

}

