/**
 * (c) 2016 Jörn Dinkla, www.dinkla.net
 * See the file LICENSE in the ROOT directory.
 *
 * Code für das einfache System in Abschnitt 2.3
 */

import Vector from './vector';
import Circle from './circle';

function print(s) {
  // eslint-disable-next-line no-console
  console.log(s);
}

function init() {
  const u = new Circle('blau', 3, new Vector(2, 1), new Vector(2, 0));
  // const v = new Circle('grau', 4, new Vector(5, 3), new Vector(0, 0));
  // const w = new Circle('rot', 2, new Vector(9, 4), new Vector(-1, -1));

  print(u);
  u.step();
  print(u);
  u.step();
  print(u);
}

const show = c => JSON.stringify(c.position);

function simulation() {
  const u = new Circle('blau', 3, new Vector(2, 1), new Vector(2, 0));
  const v = new Circle('grau', 4, new Vector(5, 3), new Vector(0, 0));
  const w = new Circle('rot', 2, new Vector(9, 4), new Vector(-1, -1));

  let t = 0;
  while (t < 10) {
    print(`t=${t}: ${show(u)}, ${show(v)}, ${show(w)}`);    // gibt u, v und w aus
    u.step(); v.step(); w.step();
    t += 1;
  }
}

export default function main() {
  print('--- Beispiel aus dem Buch in Abschnitt 2.3 -----');
  init();
  print('--- Simulation aus dem Buch in Abschnitt 2.3 ---');
  simulation();
  print('--- Ende  --------------------------------------');
}

main();
